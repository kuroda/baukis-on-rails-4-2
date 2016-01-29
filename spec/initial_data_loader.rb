require 'digest/md5'
require 'database_cleaner'

md5 = Digest::MD5.new
Dir[Rails.root.join("spec/initial_data/*.rb")].each do |f|
  md5.update File.new(f).read
end

conn = ActiveRecord::Base.connection

unless conn.table_exists?('_initial_data_digest')
  conn.create_table('_initial_data_digest') do |t|
    t.string :md5_value
  end
end

class InitialDataDigest < ActiveRecord::Base
  self.table_name = '_initial_data_digest'
end

digest = InitialDataDigest.first

unless digest.try(:md5_value) == md5.hexdigest
  table_names = %w(staff_members customers)

  DatabaseCleaner.strategy = :truncation
  DatabaseCleaner.clean

  table_names.each do |table_name|
    path = Rails.root.join('spec', 'initial_data', "#{table_name}.rb")
    if File.exist?(path)
      puts "Creating #{table_name}...."
      require(path)
    end
  end

  digest ||= InitialDataDigest.new
  digest.md5_value = md5.hexdigest
  digest.save
end
