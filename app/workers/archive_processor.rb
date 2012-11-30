require_relative '../../lib/s3_source_deliverer'

class ArchiveProcessor
  @queue = :archive_processor_queue

  def self.perform(options)
    options.symbolize_keys!

    object = s3.object destination(user_name,game_name)
    object.write file: options[:file]

    game = Game.find(options[:game_id])

    application_options = { game_name: game.name, user_name: game.user.name,
      game_id: game.id }


    Resque.enqueue MacApplication, application_options
    Resque.enqueue PCApplication, application_options
  end

  def self.bucket_name
    "rubymetro-dev"
  end

  def self.destination(user_name,game_name)
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