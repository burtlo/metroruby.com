class AddRelease
  @queue = :add_release_queue

  def self.perform(options)
    options.symbolize_keys!

    game = Game.find(options[:game_id])
    url = options[:url]
    
    release = add_or_update_release_for_platform(game,parse_platform_name(options[:platform]))
    release.url = url
    release.save
  end

  def self.parse_platform_name(name)
    { pc: 'PC', mac: 'Mac', linux: 'Linux '}[name.downcase.to_sym]
  end

  def self.add_or_update_release_for_platform(game,platform_name)
    platform = Platform.find_by_name(platform_name)
    release = game.release_for(platform)

    unless release
      release = game.releases.create platform: platform
    end

    release
  end

end