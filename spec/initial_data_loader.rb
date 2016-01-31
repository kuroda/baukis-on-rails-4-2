require 'digest/md5'
require 'database_cleaner'

md5 = Digest::MD5.new
Dir[Rails.root.join("spec/initial_data/*.rb")].each do |f|
  md5.update File.new(f).read
end

digest_path = Rails.root.join('tmp', 'initial_data.md5')

md5_digest = nil

if File.exist?(digest_path)
  File.open(digest_path) do |f|
    md5_digest = f.read
  end
end

unless md5_digest == md5.hexdigest
  DatabaseCleaner.strategy = :truncation
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

  File.open(digest_path, 'w') do |f|
    f.write md5.hexdigest
  end
end
