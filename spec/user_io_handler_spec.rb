require 'user_io_handler'

def with_captured_stdout
  begin
    old_stdout = $stdout
    $stdout = StringIO.new('','w')
    yield
    $stdout.string
  ensure
    $stdout = old_stdout
  end
end

describe UserIOHandler do
  let(:io_handler) { UserIOHandler.new }
  it 'shows requested message' do
    output = with_captured_stdout do
      io_handler.show_message('hello world')
    end
    expect(output).to eq("hello world\n")
  end
  it 'shows requested menu' do
    # expect(io_handler).to respond_to(:display_menu_and_get_choice).with(2)
    # allow(STDIN).to receive(:gets).and_return('1')
    $stdin = StringIO.new('1')
    output = with_captured_stdout do
      io_handler.display_menu_and_get_choice(%(a b).split, 'letter')
    end
    expect(output).to eq("Choose your letter\n1. a\n2. b\nyour option : ")
  end
  it 'asks user for a parameter' do
    # expect(io_handler).to respond_to(:ask_user_for).with(1)
    $stdin = StringIO.new('myans')
    output = with_captured_stdout do
      io_handler.ask_user_for('your answer')
    end
    expect(output).to eq('Enter your answer : ')
  end

  it 'responds to clear screen' do
    expect(io_handler).to respond_to(:clear_screen)
  end
end
