#!C:/Ruby/bin/ruby.exe
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
