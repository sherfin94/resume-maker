require 'user'

describe User do
  let(:user) { User.new('Some Name', '21', 'Some Place') }
  it 'responds to name and name=' do
    expect(user).to respond_to(:name)
    expect(user).to respond_to(:name=)
  end
  it 'responds to to_hash' do
    expect(user).to respond_to(:to_hash)
  end
  it 'resturns a hash with name, age, place when called to_hash' do
    the_hash = user.to_hash
    expect(the_hash).to be_a(Hash)
    expect(the_hash).to eq({name: 'Some Name', age: '21', place: 'Some Place'})
  end
end
