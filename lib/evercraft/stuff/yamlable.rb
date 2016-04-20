require 'psych'

module Yamlable
  def to_yaml
    Psych.dump(self)
  end

  def self.from_yaml(yaml)
    Psych.load(yaml)
  end
end
