class Hashed
  attr_reader :hash, :key_to_map

  def initialize(key_to_map, items = [])
    @key_to_map = key_to_map
    @hash = {}
    store(items)
  end

  def store(items)
    Array(items).each do |item|
      @hash[item.send(@key_to_map)] = item
    end
  end

  def key?(key)
    @hash.key?(key)
  end
end
