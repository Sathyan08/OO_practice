module PathAnalyzer

  def self.after_home
    home_visitors = User.home_visitors
    home_visitors.inject([ ]) { |events, user| events << user.after_home }
  end

  def self.after_home_count
    counts = { }
    counted = self.after_home.each { |event| counts[event.name] += 1 }
    counted.sort_by { |event_name, count| count }
  end

  def self.after_home_top_three
    self.after_home_count.last(3)
  end

  def self.user_paths
    users = User.blog_visitors
    paths = users.inject([ ]) {|paths_array, user| paths_array << user.after_blog_path }
    paths
  end

  def self.counted_paths
    counts = {}
    self.user_paths.each { |path| counts[path.to_s] += 1 }
    counts
  end

  def self.most_likely_path
    paths = self.counted_paths.sort_by {|path, count| count }
    hightest = paths.to_a.last
    hightest_path = hightest[0].to_a
  end

end
