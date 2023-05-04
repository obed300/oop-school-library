require './person'
require './classroom'

class Student < Person
  attr_accessor :name, :classroom

  def initialize(name, age, classroom)
    super(name, age)
    @classroom = classroom
  end

  def play_hooky
    '¯(ツ)/¯'
  end
end
