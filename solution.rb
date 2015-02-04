class Solution

  def self.events
    file = File.read('events.json')
    json = JSON.parse(file)
    json["events"]
  end

  def self.users
    file = File.read('users.json')
    json = JSON.parse(file)
    json["users"]
  end

  def initialize
    @users = make_users
    @events = Event.all
  end

  def make_users
    users = Solution.users
    users.each do |user_id, user_info|
      user = User.new(user_id, user_info)
      user_events = Solution.events.select { |event| event["user_id"] == user_id }
      user_events.each { |event_data| make_event(user, event_data)  }
    end

    users
  end

  def make_event(user, event_data)
    event = Event.new(event_data)
    user.add_event(event)
  end

  def first_problem
    @events.length
  end

  def second_problem
    total_ages = User.home_visitors.inject(0) { |sum, user| sum + user.age  }
    total_ages / User.home_visitors.length
  end

  def third_problem
    users = User.home_visitors
    converted = users.select { |user| user.converted? }
    converted.length / users.length
  end

  def fourth_problem
    PathAnalyzer.after_home_top_three
  end

  def fifth_problem
    PathAnalyzer.most_likely_path
  end


end
