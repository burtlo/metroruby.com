require 'zlib'
require 'archive/tar/minitar'

class ArchiveProcessor
  @queue = :archive_process_queue

  def self.perform(options)
    options.symbolize_keys!
    archive_filename = options.fetch(:file)

    tgz = Zlib::GzipReader.new(File.open(archive_filename, 'rb'))
  
    root_path = File.dirname(archive_filename)
    source_path = File.join root_path, "source"

    Archive::Tar::Minitar.unpack(tgz,source_path)

    Resque.enqueue MacApplication, options.merge(root: root_path, source: source_path)
  end
end