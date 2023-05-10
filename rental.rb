class Rental
  attr_reader :book, :person
  attr_accessor :date

  def initialize(date, book, person)
    @date = date
    @book = book
    @person = person
  end

  def book=(book)
    @book = book
    @book.rentals.push(self) unless book.rental.include?(self)
  end

  def person=(person)
    @person = person
    person.rentals.push(self) unless person.rental.includes?(self)
  end

  def to_h
    {
      date: @date,
      book: @book,
      person: @person
    }
  end
end
