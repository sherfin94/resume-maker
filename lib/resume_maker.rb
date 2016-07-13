require 'user_io_handler'

# Main class that controls the program
class ResumeMaker
  attr_accessor :io_handler
  def initialize
    @io_handler = UserIOHandler.new
  end

  def start
  end

  def display_main_menu_and_get_choice
    @io_handler.display_menu_and_get_choice(
      %(Choose-Format Export Quit),
      'option'
    )
  end
end
