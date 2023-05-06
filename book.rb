require './rental'
require './person'

class Book
  attr_accessor :rental, :title, :author

  @books = []

  def initialize(title, author)
    @title = title
    @author = author
    @rentals = []
    self.class.all << self
  end

  def add_rental(_rental)
    Rental.new(date, self, person)
  end

  def self.all
    @books
  end
end
