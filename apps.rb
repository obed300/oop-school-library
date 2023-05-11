require './person'
require './student'
require './teacher'
require './book'
require './input_module'
require './classroom'
require './rental'
require './storage/reserve'
require 'json'


class App
  def initialize
    @persons = []
    @books = []
    @rentals = []
    @classroom = Classroom.new(1)
  end

  include InputModule


  def act_regarding_input
    loop do
      display_options
      choice = gets.to_i
      if choice == 7
        puts 'Thank You for using my School Library!'
        break
      end
      options(choice)
    end
  end

  def add_person
    text = 'Do you want to create a student (1) or a teacher (2)? [Input the number]: '
    type = numeric_input(text, (1..2))

    print 'Age: '
    age = gets.chomp
    print 'Name: '
    name = gets.chomp

    if type == 1
      letter = letter_input('Has parent permission? [Y/N] ', %w[Y N])
      permission = letter == 'Y'
      new_person = Student.new(age, name, permission, @classroom)
    else
      print 'Specialization: '
      specialization = gets.chomp
      new_person = Teacher.new(specialization, age, name)
    end

    @persons << new_person
    write_data(@persons, './storage/person.json')

    puts 'Person created successfully'
  end

  def print_person
    json_data = read_data('./storage/person.json')
    @persons = JSON.parse(json_data)

    @persons.each_with_index do |person, index|
      if person.key?('specialization')
        puts "#{index} - [Teacher] Name: #{person['name']}, ID: #{person['id']}, Age: #{person['age']}"
      else
        puts "#{index} - [Student] Name: #{person['name']}, ID: #{person['id']}, Age: #{person['age']}"
      end
    end
  end

  def create_book
    print 'Title: '
    title = gets.chomp
    print 'Author: '
    author = gets.chomp
    book = Book.new(title, author)
    @books << book

    write_data(@books, './storage/book.json')
    print 'Book created successfully'
  end

  def list_books
    json_data = read_data('./storage/book.json')
    @books = JSON.parse(json_data)
    puts 'Book list is empty! Add a book.' if @books.empty?
    @books.each_with_index do |book, index|
      puts "#{index}) Title: \"#{book['title']}\", Author: #{book['author']}"
    end
  end

  def select_book
    list_books
    puts 'Select a book index from the above list by number: '
    book_index = gets.chomp.to_i
    @books[book_index]
  end

  def select_person
    print_person
    puts 'Select a person index from the above list by number: '
    person_index = gets.chomp.to_i
    @persons[person_index]
  end

  def create_rental
    rented_book = select_book
    renter = select_person
    puts 'Enter a date as (YYYY-MM-DD): '
    date = gets.chomp

    @rentals.push Rental.new(date, rented_book, renter)
    write_data(@rentals, './storage/rental.json')
    puts 'Rental created successfully'
  end

  def list_rentals
    json_data = read_data('./storage/rental.json')
    @rentals = JSON.parse(json_data)
    print_person
    puts 'Enter ID of person: '
    renter_id = gets.chomp.to_i

    if rentals_empty?
      puts 'Rental is empty'
    else
      rentals_for_person = @rentals.select do |rental|
        rental_for_person?(rental, renter_id)
      end

      if rentals_for_person.empty?
        puts 'No rentals found for the given person'
      else
        rentals_for_person.each do |rental|
          puts "Rental date: #{rental['date']}, Book: #{rental['book']['title']} by #{rental['book']['author']}"
        end
      end
    end
  end

  def rentals_empty?
    @rentals.nil? || @rentals.empty?
  end

  def rental_for_person?(rental, renter_id)
    rental['person'] && rental['person']['id'] == renter_id && rental['book']
  end
end
