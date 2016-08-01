require 'hanami/validations'
class Name
  include Hanami::Validations
  MAX_NAME_LENGTH = 64
  attr_reader :name
  validates :name, type: String, size: 1..MAX_NAME_LENGTH, presence: true, format: /\A[\-_a-zA-Z1234567890]+\z/

  def initialize(name)
    @name = name.to_s
    raise "Invalid Name: #{name}" unless valid?
  end
end

n = Name.new('Goodname')
m = Name.new('Invalidname%%%%%%')
