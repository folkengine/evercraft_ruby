require 'fileutils'

class Harshed
  attr_reader :hash, :key_to_map

  include Yamlable

  def initialize(key_to_map, items = [],
                 storage_base: Harshed.default_base_folder,
                 storage_folder: '')
    @key_to_map = key_to_map
    @hash = {}
    @storage_folder = storage_folder
    @storage_base = storage_base
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

  def valid_type?(item)
    @hash.values.last.class == item.class
  end

  def validate_type(item)
    return if @hash.empty?
    unless valid_type?(item)
      raise TypeError.new("Harshed Object class types (#{last_class}/#{item_class}) must be the same.")
    end
  end

  def to_a
    @hash.values
  end

  def key?(key)
    @hash.key?(key)
  end

  def value(my_key)
    @hash[my_key]
  end

  def sample
    @hash.values.sample
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
    if @storage_folder.empty?
      File.join(@storage_base, @hash.values.first.class.to_s)
    else
      File.join(@storage_base, @storage_folder)
    end
  end

  def filename(key)
    File.join(folder_path, "#{key}.yml")
  end

  def self.default_base_folder
    File.join(File.dirname(__FILE__), '..', '..', '..', 'data')
  end
end
