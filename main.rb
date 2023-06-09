require './apps'
require './input_module'

class Main
  attr_reader :app

  def initialize
    @app = App.new
  end

  include InputModule

  def menu_options
    "
1 - List all books
2 - List all people
3 - Create a person
4 - Create a book
5 - Create a rental
6 - List all rentals for a given person id
7 - Exit
Please choose an option by entering a number between 1 and 7: "
  end

  def menu
    loop do
      input = numeric_input(menu_options, (1..7))
      case input
      when 1
        app.list_books
      when 2
        app.print_person
      when 3
        app.add_person
      when 4
        app.create_book
      when 5
        app.create_rental
      when 6
        app.list_rentals
      else
        break
      end
    end
    puts 'Thank you for using this app!'
  end

  def main
    puts "Welcome to the School Library app!\n"
    menu
  end
end

main = Main.new
main.main
