require_relative '../../lib/mac_application_creator'

class MacApplication
  @queue = :mac_application_queue

  def self.perform(options)
    options.symbolize_keys!

    source_path = options.fetch(:source)
    root_path = options.fetch(:root)

    url = Metro::MacApplicationCreator.create source_path, target_application_path(root_path)

    game = Game.find(options[:game_id])
    release = add_or_update_mac_release_for_game(game)
    release.url = url.to_s
    release.save

    Resque.enqueue ArchiveCleanup, options[:cleanup]
  end

  def self.add_or_update_mac_release_for_game(game)
    release = game.release_for(Platform.Mac)

    unless release
      release = game.releases.create platform: Platform.Mac
    end

    release
  end

  def self.target_application_path(root_path)
    File.absolute_path(File.join(root_path, "fullgame.app"))
  end

end