require './person'
require './classroom'

class Student < Person
  attr_reader :classroom

  def play_hooky
    '¯(ツ)/¯'
  end

  def classrooms=(classroom)
    @classroom = classroom
    classroom.students.push(self) unless classroom.students.include?(self)
  end
end
