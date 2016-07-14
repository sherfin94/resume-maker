require 'resume_maker'

describe 'ResumeMaker' do
  let(:maker) { ResumeMaker.new }

  it 'responds to the start call that starts the program' do
    expect(maker).to respond_to(:start)
  end

  it 'sets a user_io_handler' do
    expect(maker).to respond_to(:io_handler=).with(1)
  end

  it 'sets a plugin_handler' do
    expect(maker).to respond_to(:plugin_handler=).with(1)
  end

  describe '#display_main_menu_and_get_choice' do
    it 'gets a user choice from the list of items supplied' do
      io_handler = instance_double('UserIOHandler')
      allow(io_handler).to receive(:display_menu_and_get_choice).and_return(1)
      maker.io_handler = io_handler
      expect(maker.display_main_menu_and_get_choice)
        .to eq(1)
    end
  end

  describe '#display_format_choice_menu_and_get_choice' do
    it 'displays the available formats and gets the user choice' do
      io_handler = instance_double('UserIOHandler')
      allow(io_handler).to receive(:display_menu_and_get_choice)
        .and_return(1)
      plugin_handler = instance_double('PluginHandler')
      allow(plugin_handler).to receive(:load_plugins)
      allow(plugin_handler).to receive(:list_plugins).and_return(
        %(PDF CSV PlainText)
      )

      maker.io_handler = io_handler
      maker.plugin_handler = plugin_handler
      expect(maker.display_format_choice_menu_and_get_choice).to eq(1)
    end
  end

  # split this
  describe '#export' do
    it 'asks io controller for filename and tells plugin_handler to export' do
      io_handler = instance_double('UserIOHandler')
      allow(io_handler).to receive(:ask_user_for).with(kind_of(String))
        .and_return('somename', 'someage', 'someplace', 'somefile')
      plugin_handler = instance_double('pluginLoader')
      allow(plugin_handler).to receive(:export).with(
        kind_of(Array),
        kind_of(String)
      ).and_return('success')

      maker.io_handler = io_handler
      maker.plugin_handler = plugin_handler
      expect(io_handler).to receive(:ask_user_for).with(kind_of(String))
      expect(plugin_handler).to receive(:export).with(
        kind_of(Array),
        kind_of(String)
      )
      expect(maker.export).to eq('success')
    end
  end
end
