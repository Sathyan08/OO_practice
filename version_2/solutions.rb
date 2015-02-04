class Solution

  def initialize(event_file, user_file)
    DataGatherer.new(event_file, user_file)
    @visitors = User.home_visitors
    @converted = User.converted
    @blog_visitors = User.blog_visitors
  end

  def number_of_events
    Event.all.count
  end

  def average_age_of_home_visitors
    total_ages = @visitors.inject(0) { |sum, user| sum + user.age }

    total_ages / @visitors.count
  end

  def conversion_rate
    @converted.count / @visitors.count
  end

  def after_home_visits
    after_events = {}
    @visitors.each { |user| after_events[user.after_home] += 1 }
    after_events.sort_by! { |event, count| count }
    after_events.to_a.last(3)
  end

  def most_common_after_blog
    paths = {}
    @blog_visitors.each { |user| paths[user.events_after_blog.to_s] += 1 }
    paths.sort_by! { |path, count| count }
    most_common_path = paths.last
    most_common_path[0].to_a
  end

end
