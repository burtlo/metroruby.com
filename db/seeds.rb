# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

unless user = User.find_by_name('Frank')
  user.create(name: 'Frank', api_key: ApiKeyGenerator.generate)
  user.save!
end

Platform.find_or_create_by_name('Mac')
Platform.find_or_create_by_name('PC')
Platform.find_or_create_by_name('Linux')

s3 = AWS::S3.new

[ 'rubymetro-dev', 'rubymetro-prod' ].each do |bucket|
  s3.buckets.create bucket
end