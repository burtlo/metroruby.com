class ArchiveController < ApplicationController

  before_filter :valid_api_key, :game_name_present?

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

  def game_name_present?
    params[:game] && params[:game][:name]
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
      user_name = current_user.underscore.downcase.gsub(/\s/,'_')
      game_name = current_game.underscore.downcase.gsub(/\s/,'_')
      File.absolute_path File.join 'public', 'archives', user_name, game_name, "archive.tar.gz"
    end
  end

  def current_user
    User.find_by_api_key params[:api_key]
  end

  def current_game
    params[:game][:name]
  end

end