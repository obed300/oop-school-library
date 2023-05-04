class Rental
  attr_accessor :date, :book

  def initialize(person, date, book)
    @person = person
    person.rentals.push(self) unless person.rentals.include?(self)
    @date = date
    @book = book
    book.rentals.push(self) unless book.rentals.include?(self)
  end
end
