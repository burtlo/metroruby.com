class AddRelease
  @queue = :add_release_queue

  def self.perform(options)
    options.symbolize_keys!

    game = Game.find(options[:game_id])

    release = add_or_update_release_for_platform(options[:platform])
    release.url = url.to_s
    release.save
  end

  def self.add_or_update_release_for_platform(platform_name)
    platform = Platform.find_by_name(platform_name.to_s.capitalize)
    release = game.release_for(platform)

    unless release
      release = game.releases.create platform: platform
    end

    release
  end

  def self.target_application_path(root_path)
    File.absolute_path(File.join(root_path, "fullgame.app"))
  end

end