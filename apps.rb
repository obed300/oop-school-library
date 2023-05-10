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

  # def add_person
  #   puts 'Do you want to create a student (1) or a teacher (2) [Input the number]: '
  #   number = gets.chomp.to_i
  #   puts 'Name: '
  #   name = gets.chomp
  #   puts 'Age: '
  #   age = gets.chomp.to_i
  #   if number == 1
  #     create_student(name, age)
  #   elsif number == 2
  #     create_teacher(name, age)
  #   else
  #     puts 'Invalid input'
  #   end
  # end

  # Create new student
  # def create_student(name, age)
  #   puts 'Has parent permission? [Y/N]'
  #   permission = gets.chomp.upcase == 'Y'

  #   @persons.push Student.new(age, name, permission, @classroom)
  #   write_data(@persons, './storage/person.json')
  #   puts 'Student created successfully'
  # end

  # # Create new teacher
  # def create_teacher(name, age, _classroom)
  #   puts 'Specialization: '
  #   specialization = gets.chomp

  #   @persons.push Teacher.new(name, age, specialization)
  #   write_data(@persons, './storage/person.json')
  #   puts 'Teacher created successfully'
  # end

  # def print_person
  #   @persons = read_data('./storage/person.json')
  #   puts 'There are no people in the list' if @persons.empty?
  #   @persons.each_with_index do |person, index|
  #     puts "#{index} - #{person['class']} Name: #{person['name']}, ID: #{person['id']}, Age: #{person['age']}"
  #   end
  # end
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


  # def print_person
  #   @persons = read_data('./storage/person.json')
  #   @persons.each do |person|
  #     if person.is_a?(Student)
  #       puts "Student Name: #{person.name}, Age: #{person.age}, id: #{person.id}"
  #     elsif person.is_a?(Teacher)
  #       puts "Teacher Name: #{person.name}, Age: #{person.age}, id: #{person.id}"
  #     end
  #   end
  # end

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
    @books.map do |book|
      puts %(Title: "#{book['title']}", Author: #{book['author']})
    end
  end

  def create_rental
    puts 'Select a book from the following list by number:'
    @books.each_with_index { |book, index| puts %(#{index}\) Title: "#{book.title}", Author: #{book.author}) }
    book_index = gets.chomp.to_i

    @persons.each_with_index do |person, index|
      puts "#{index}) [#{person.class.name}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
    end
    person_index = gets.chomp.to_i

    print 'Date: '
    date = gets.chomp.to_i

    @rentals << Rental.new(date, @books[book_index], @persons[person_index])
    write_data(@rentals, './storage/rental.json')
    puts 'Rental created sucessfully'
  end

  def list_rentals
    json_data = read_data('./storage/rental.json')
    @rentals = JSON.parse(json_data)
    puts "\n"
    if @rentals.empty?
      puts 'No rent is registered in the library'
    else
      puts 'Select a person form the following list by ID'
      @persons.each do |person|
        puts "ID : #{person.id} => #{person.name}"
      end
      puts "

    Enter person's ID :"
      person = gets.chomp
      puts "\n"
      @rentals.each do |rental|
        if rental.person.id.to_i == person.to_i
          puts "Date : #{rental.date}, Book \"#{rental.book.title}\" by : #{rental.book.author}"
        end
      end
    end
  end
end
