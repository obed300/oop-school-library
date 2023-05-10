require './person'

class Teacher < Person
  attr_accessor :parent_permission

  def initialize(specialization, age, name)
    super(age, name, parent_permission: parent_permission)

    @specialization = specialization
  end

  def can_use_services?
    true
  end

  def to_h
    {
      id: @id,
      name: @name,
      age: @age,
      parent_permission: @parent_permission,
      specialization: @specialization
    }
  end
end
