require './person'

class Teacher < Person
  attr_reader :specialization

  @teachers = []

  def initialize(specialization, age, name)
    super(name, age)
    @specialization = specialization
    self.class.all << self
  end

  def self.all
    @teachers
  end

  def can_use_services?
    true
  end
end
