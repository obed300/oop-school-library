require './student'

class Classroom
  attr_accessor :label, :student

  def initialize(label, _students)
    @label = label
    @students = []
  end

  def add_student(student)
    student.classroom = self
    @students << student
  end
end

classroom = Classroom.new('math')
student = Student.new('obed')

classroom.add_student(student)
