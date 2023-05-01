require './student'
require './person'

class Teacher < Person
  def initialize(specialization, age)
    super(age)
    @specialization = specialization
  end

  def can_use_services?
    true
  end
end
