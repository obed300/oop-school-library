class Book
  attr_accessor :title, :author

  def initialize(title, author)
    @title = title
    @author = author
    @rentals = []
  end

  def add_rentals(rental)
    @rentals.push(rental)
    rental.book = self
  end

  def to_h
    {
      title: @title,
      author: @author,
      rentals: @rentals
    }
  end
end
