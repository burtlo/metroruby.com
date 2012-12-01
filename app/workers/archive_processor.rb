class MacApplication
  @queue = :mac_application_queue
end

class PCApplication
  @queue = :pc_application_queue
end

class ArchiveProcessor
  @queue = :archive_processor_queue

  def self.perform(options)
    options.symbolize_keys!

    game = Game.find(options[:game_id])
    game_id = game.id
    game_name = game.name
    user_name = game.user.name

    object = s3_object destination(user_name,game_name)
    object.write file: options[:file]

    application_options = { game_name: game_name, user_name: user_name,
      game_id: game_id }

    Resque.enqueue MacApplication, application_options
    Resque.enqueue PCApplication, application_options
  end

  def self.bucket_name
    "rubymetro-dev"
  end

  def self.destination(user_name,game_name)
    user_name = user_name.downcase.underscore.gsub(/\s/,'_')
    game_name = game_name.downcase.underscore.gsub(/\s/,'_')
    File.join user_name, game_name, "archive.tar.gz"
  end

  def self.s3
    AWS::S3.new
  end

  def self.bucket
    s3.buckets[bucket_name]
  end

  def self.s3_object(path)
    bucket.objects[path]
  end


end