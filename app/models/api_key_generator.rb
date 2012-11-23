require "digest/sha1"

class ApiKeyGenerator
  def self.generate(length = 40)
    Digest::SHA1.hexdigest(seed)[1..length]
  end

  def self.seed
    "#{Time.now}#{rand(999_999_999)}"
  end
end