module Metro

  class MacApplicationCreator

    def self.create(source,target)
      creator = new source, target
      creator.create!
      creator.archive!
      url = creator.upload_to_s3!
      creator.clean!
      url
    end

    attr_reader :target_archive, :source

    def initialize(source,target)
      @source = source
      @target_archive = target
    end

    def create!
      FileUtils.cp_r application_wrapper_path, target_archive
      FileUtils.cp_r Dir["#{source}/**/*"], source_target_path
    end

    def source_target_path
      File.join target_archive, *path_within_app
    end

    def path_within_app
      %w[ Contents Resources application ]
    end

    def application_wrapper_path
      File.absolute_path File.join File.dirname(__FILE__), "..", "public", "Game.app"
    end
    
    def archive!
      old_working_directory = Dir.pwd
      Dir.chdir File.dirname(target_tar_archive)
      tgz = Zlib::GzipWriter.new(File.open(target_tar_archive, 'wb'))
      Archive::Tar::Minitar.pack(File.basename(target_archive), tgz)
      Dir.chdir old_working_directory
    end
    
    def target_tar_archive
      File.join File.dirname(target_archive), 'mac.tar.gz'
    end
    
    def upload_to_s3!
      s3 = AWS::S3.new
      bucket = s3.buckets['rubymetro-dev']
      basename = File.basename(target_tar_archive)
      obj = bucket.objects[amazon_archive]
      obj.write file: target_tar_archive
      obj.public_url
    end

    def amazon_folder
      File.dirname(target_archive)[/\/([^\/]+\/[^\/]+)$/,1]
    end
    
    def amazon_archive
      File.join amazon_folder, File.basename(target_tar_archive)
    end
    
    def clean!
      FileUtils.rm_rf target_archive
      FileUtils.rm_rf target_tar_archive
    end

  end

end