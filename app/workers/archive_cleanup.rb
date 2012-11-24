class ArchiveCleanup
  @queue = :archive_cleanup_queue

  def self.perform(files)
    files.each { |file| FileUtils.rm_rf file }
  end

end