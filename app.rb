require './book'
require './classroom'
require './nameable'
require './rental'
require './teacher'
require './student'


class App
  def start
    puts 'Welcome to School Library App!'
    puts # blank
    @choice = ''
    options
  end

  def options
    puts 'Please choose an option by enterin a number:'
    puts '1 - List all books', '2 - List all people', '3 - Create a person', '4 - Create a book',
         '5 - Create a rental', '6 - List all rentals for a given person id', '7 - Exit'

    @choice = gets.chomp
    puts @choice
    if @choice.to_i != 0 && @choice.to_i.between?(1, 6)
      enter_menu
    elsif @choice.to_i == 7
      puts 'Thank you for using this app!'
    else
      options
    end
  end

  def enter_menu
    case @choice
    when '1' then list_all_books
    when '2' then list_all_people
    when '3' then create_person
    when '4' then create_book
    when '5' then create_rental
    when '6' then list_rental_by_id
    end
  end

  def list_all_books
    books = Book.all
    if books.empty?
      puts 'There are no books added yet.'
    else
      puts 'These are all the books:'
      books.each do |book|
        puts "\"#{book.title}\" by #{book.author}"
      end
    end
    puts # blank
  end

  def list_all_people
    students = Student.all
    teachers = Teacher.all

    if students.empty? && teachers.empty?
      puts 'There are no people added yet.'
    else
      puts 'These are all the people:'
      students.each do |student|
        puts "#{student.name}, Student aged #{student.age} with ID: #{student.id}."
      end
      teachers.each do |teacher|
        puts "#{teacher.name}, #{teacher.specialization} Teacher aged #{teacher.age} with ID: #{teacher.id}."
      end
    end
    puts # blank
  end

  def create_person
    puts 'Do you want to create a student (1) or a teacher (2)? [input the number]: '
    input = gets.chomp
    case input
    when '1' then create_student

    when '2' then create_teacher
    end
  end

  def create_student
    puts 'Please add details of Student...'
    print 'Name: '
    s_name = gets.chomp
    print 'Age: '
    s_age = gets.chomp.to_i
    print 'Has parent permission (Y/N): '
    s_perm = gets.chomp.upcase == 'Y'
    Student.new(s_age, s_perm, s_name).make_student
  end

  def create_teacher
    puts 'Please add details of Teacher...'
    print 'Name: '
    t_name = gets.chomp
    print 'Age: '
    t_age = gets.chomp.to_i
    print 'Specialization: '
    t_spec = gets.chomp
    Teacher.new(t_spec, t_age, t_name)
  end

  def create_book
    print 'Please add Book title: '
    b_title = gets.chomp
    print 'Please add Book author: '
    b_author = gets.chomp
    Book.new(b_title, b_author)
    puts 'Book added successfully!'
  end

  def choose_person(persons)
    puts 'Please choose the Person for the Rental (input number)'
    persons.each_with_index do |person, index|
      puts "[#{index + 1}] #{person.name}, #{person.class} aged #{person.age} with ID:#{person.id}"
    end
    persons[gets.chomp.to_i - 1]
  end

  def choose_book(books)
    puts 'Please choose the Book for the Rental (input number)'
    books.each_with_index do |book, index|
      puts "[#{index + 1}] \"#{book.title}\" by #{book.author}"
    end
    books[gets.chomp.to_i - 1]
  end

  def create_rental
    students = Student.all
    teachers = Teacher.all
    persons = students + teachers
    books = Book.all
    if persons.empty?
      puts 'There are no People added yet.'
    else
      @r_person = choose_person(persons)
    end
    if books.empty?
      puts 'There are no Books added yet.'
    else
      @r_book = choose_book(books)
    end
    return if books.empty? && persons.empty?

    print 'Please input Date of Rental (YYYY/MM/DD): '
    r_date = gets.chomp
    Rental.new(r_date, @r_book, @r_person)
    puts 'Rental created successfully!'
  end

  def list_rental_by_id
    rentals = Rental.all
    puts 'Please provide Person ID for Rental list...'
    p_id = gets.chomp.to_i
    rental_found = false
    puts # blank
    puts "All Rentals by User ID:#{p_id}"
    rentals.each do |rental|
      next unless rental.person.id == p_id

      puts "Date: #{rental.date}, Book: \"#{rental.book.title}\" by #{rental.book.author}"
      rental_found = true
    end
    puts "No Rental for Person with ID: #{p_id}" unless rental_found
    puts # blank
  end
end