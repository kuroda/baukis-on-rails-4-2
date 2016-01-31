require 'digest/md5'
require 'database_cleaner'

md5 = Digest::MD5.new
Dir[Rails.root.join("spec/initial_data/*.rb")].each do |f|
  md5.update File.new(f).read
end

conn = ActiveRecord::Base.connection

DIGEST_TABLE_NAME = '_initial_data_digest'

unless conn.table_exists?(DIGEST_TABLE_NAME)
  conn.create_table(DIGEST_TABLE_NAME) do |t|
    t.string :md5_value
  end
end

class InitialDataDigest < ActiveRecord::Base
  self.table_name = DIGEST_TABLE_NAME
end

digest = InitialDataDigest.first

unless digest.try(:md5_value) == md5.hexdigest
  DatabaseCleaner.strategy = :truncation, { except: [ DIGEST_TABLE_NAME ] }
  DatabaseCleaner.clean

  yaml_path = Rails.root.join('spec', 'initial_data', '_index.yml')
  if File.exist?(yaml_path)
    table_names = YAML.load_file(yaml_path)
    table_names.each do |table_name|
      path = Rails.root.join('spec', 'initial_data', "#{table_name}.rb")
      if File.exist?(path)
        puts "Creating #{table_name}...."
        require path
      end
    end
  else
    Dir[Rails.root.join("spec/initial_data/*.rb")].each do |f|
      table_name = f.match(/(\w+)\.rb$/)[1]
      puts "Creating #{table_name}...."
      require f
    end
  end

  digest ||= InitialDataDigest.new
  digest.md5_value = md5.hexdigest
  digest.save
end
