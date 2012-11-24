require 'zlib'
require 'archive/tar/minitar'

class ArchiveProcessor
  @queue = :archive_process_queue

  def self.perform(options)
    options.symbolize_keys!

    archive_path = options.fetch(:file)
    source_path = unpack_source_location archive_path

    Unpacker.unpack archive_path, source_path

    options[:cleanup] = [ archive_path, source_path ]

    Resque.enqueue MacApplication, options.merge(root: File.dirname(archive_path),
      source: source_path)
  end

  def self.unpack_source_location(path)
    File.join File.dirname(path), "source"
  end

  class Unpacker
    def self.unpack(source,destination)
      tgz = Zlib::GzipReader.new File.open(source, 'rb')
      Archive::Tar::Minitar.unpack(tgz,destination)
    end
  end
end