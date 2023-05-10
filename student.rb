require './person'

class Student < Person
  attr_accessor :classroom

  def initialize(age, name, parent_permission, classroom)
    super(age, name, parent_permission: parent_permission)

    @classroom = classroom
  end

  def play_hooky
    '¯(ツ)/¯'
  end

  def class=(classroom)
    @class = classroom
    classroom.students.push(self) unless classroom.students.include?(self)
  end

  def to_h
    {
      id: @id,
      name: @name,
      age: @age,
      parent_permission: @parent_permission,
      rentals: @rentals
    }
  end
end
