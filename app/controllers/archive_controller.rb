class ArchiveController < ApplicationController

  before_filter :valid_api_key

  def create
    save_archive unique_archive_filename, params[:file]

    game = create_game params[:game]

    Resque.enqueue ArchiveProcessor, file: unique_archive_filename,
      game_id: game.id

    render text: "success"
  end

  private

  def valid_api_key
    return false unless User.find_by_api_key params[:api_key]
  end

  def save_archive(filepath,file_contents)
    FileUtils.mkdir_p File.dirname(filepath)
    File.open(filepath, "wb") { |f| f.write(file_contents.read) }
  end

  def create_game(game_parameters)
    current_user.find_or_create_game game_parameters
  end

  def unique_archive_filename
    @archive_filename ||= begin
      File.absolute_path File.join 'public', 'archives', current_user.name, current_game, "archive.tar.gz"
    end
  end

  def current_user
    User.find_by_api_key params[:api_key]
  end

  def current_game
    params[:game][:name] || "default_game"
  end

end