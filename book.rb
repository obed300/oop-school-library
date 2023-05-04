class Book
  attr_accessor :title, :author

  def initialize(title, author, _rentals)
    @title = title
    @author = author
    @rentals = []
  end

  def add_rental(rental)
    rental.book = self
    @rentals << rental
  end
end
