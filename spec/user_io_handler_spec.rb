require 'user_io_handler'

describe UserIOHandler do
  let(:io_handler) { UserIOHandler.new }
  it 'responds to show_message' do
    expect(io_handler).to respond_to(:show_message)
  end
  it 'responds to display_menu_and_get_choice with two arguements' do
    expect(io_handler).to respond_to(:display_menu_and_get_choice).with(2)
  end
  it 'responds to ask_user_for with one arguement' do
    expect(io_handler).to respond_to(:ask_user_for).with(1)
  end
  it 'responds to clear screen' do
    expect(io_handler).to respond_to(:clear_screen)
  end
end
