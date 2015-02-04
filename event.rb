class Event

  attr_reader :name, :timestamp, :user_id

  @@all = []

  def initialize(data)
    @name = data["name"]
    @timestamp = data["time"]
    @user_id = data["user_id"]

    @@all << self
  end

end
