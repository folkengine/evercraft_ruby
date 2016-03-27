require_relative '../../test_helper'

class Widget < Struct.new(:ean, :color)
  def self.test_factory
    Widget.new(Faker::Code.ean, Faker::Color.color_name)
  end
end

class TestHashed < Minitest::Test
  def setup
    @widget1 = Widget.test_factory
    @widget2 = Widget.test_factory
    @hashed = Harshed.new(:ean, [@widget1, @widget2])
  end

  def test_initialize
    # puts @hashed.to_yaml
  end

  def test_store_to_disk
    @hashed.store_to_disk
    dir = File.join(File.dirname(__FILE__), '..', '..', '..', 'data', @widget1.class.to_s)
    assert Dir.exist?(dir), "Dir.exist?(#{dir})"
    @hashed.rm_r
    refute Dir.exist? dir
  end

  def test_retreive_from_disk
    @hashed.store_to_disk
    @hashed.retrieve_from_disk
    @hashed.rm_r
  end
end
