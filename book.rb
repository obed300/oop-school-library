class Book
  attr_accessor :title, :author

  def initialize(title, author, rentals: [])
    @title = title
    @author = author
    @rentals = rentals
  end

  def add_rental(rental)
    rental.book = self
    @rentals << rental
  end
end
