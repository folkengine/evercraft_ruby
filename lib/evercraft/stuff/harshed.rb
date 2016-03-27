require 'fileutils'

class Harshed
  attr_reader :hash, :key_to_map

  include Yamlable

  def initialize(key_to_map, items = [],
                 storage_base: File.join(File.dirname(__FILE__), '..', '..', '..', 'data'),
                 storage_folder: '')
    @key_to_map = key_to_map
    @hash = {}
    @storage_location = File.join(storage_base, storage_folder)
    store(items)
  end

  def store(items)
    # Hack to get around how Array() mangles Hashes and Structs
    if items.is_a?(Array)
      items.each { |item| store_item(item) }
    else
      store_item(items)
    end
  end

  def store_item(item)
    validate_type(item)
    @hash[item.send(@key_to_map)] = item
  end

  def validate_type(item)
    unless @hash.empty?
      last_class = @hash.values.last.class
      item_class = item.class
      if last_class != item_class
        raise TypeError.new("Harshed Object class types (#{last_class}/#{item_class}) must be the same.")
      end
    end
  end

  def key?(key)
    @hash.key?(key)
  end

  def retrieve_from_disk
    Dir["#{folder_path}/*.yml"].each do |filename|
      yml = File.read(filename)
      store(Psych.load(yml, filename))
    end
  end

  def store_to_disk
    mkdir
    @hash.each do |key, value|
      File.open(filename(key), 'w') { |file| file.write(value.to_yaml) }
    end
  end

  def mkdir
    Dir.mkdir(folder_path) unless Dir.exist?(folder_path)
  end

  def rm_r
    FileUtils.remove_dir folder_path
  end

  def folder_path
    File.join(@storage_location, @hash.values.first.class.to_s)
  end

  def filename(key)
    File.join(folder_path, "#{key}.yml")
  end
end
