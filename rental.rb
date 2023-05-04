class Rental
  attr_accessor :date, :book

  def initialize(person, date, book)
    @person = person
    @date = date
    @book = book
  end
end
