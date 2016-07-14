class User
  attr_accessor :name, :age, :place
  def initialize(name, age, place)
    @name = name
    @age = age
    @place = place
  end

  def to_hash
    {
      name: @name,
      age: @age,
      place: @place
    }
  end
end
