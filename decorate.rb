require_relative './nameable'


class Decorator
  include Nameable
  attr_accessor :nameable, :age

  def initialize(nameable, age)
    @nameable = nameable
    @age = age
  end

  def correct_name
    @nameable.correct_name
  end
end

class CapitalizeDecorator < Decorator
  def correct_name
    @nameable.correct_name.capitalize
  end
end

class TrimmerDecorator < Decorator
  def correct_name
    @nameable.correct_name.slice(0, 10)
  end
end
