class DataGatherer

  attr_reader :join_table

  def initialize(event_file, user_file)
    @join_table = {}
    make_users_from(user_file)
    make_events_from(event_file)
  end

  def event_data
    file = File.read(event_file)
    events = JSON.parse(file)
    events["events"]
  end

  def user_data
    file = File.read(user_file)
    users = JSON.parse(file)
    users["users"]
  end

  def make_users
    user_data.each do |user_id, info|
      user = User.new(user_id, info)
      @join_table[user_id] = user
    end
  end

  def make_events
    event_data.each do |event_info|
      event = Event.new(event_info)
      @join_table[event.user_id].add_event(event)
    end
  end

end
