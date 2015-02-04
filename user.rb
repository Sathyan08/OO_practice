class User

  attr_reader :home_visitor, :blog_visitor, :id, :age, :events

  @@all_users = []

  def initialize(id, info)
    @id = id
    @age = info["age"]
    @events = []
    @@all_users << self
    @home_visitor = false
    @blog_visitor = false
  end

  def self.all
    @@all_users
  end

  def self.home_visitors
    @@all_users.select { |user| user.home_visitor }
  end

  def self.blog_visitor
    @@all_users.select { |user| user.blog_visitor }
  end

  def add_event(event)
    @home_visitor = true if (event.name == "Visited the Home Page")
    @blog_visitor = true if (event.name == "Visited the Blog Page")
    @events << event
  end

  def events_by_time
    @events.sort_by {|attribute, value| attribute["time"] }
  end

  def first_home_page_visit
    events_by_time.index {|event| event.name == "Visited the Home Page"}
  end

  def after_home
    i = first_home_page_visit + 1
    events_by_time[i]
  end

  def last_purchase
    events_by_time.rindex {|event| event.name == "Purchased Item in Cart"}
  end

  def first_blog_visit
    events_by_time.index {|event| event.name == "Visited a Blog Page"}
  end

  def after_blog_path
    after_blog = first_blog_visit + 1
    events_by_time[after_blog..-1]
  end

  def home_and_purchase?
    !first_home_page_visit.nil? && !last_purchase.nil?
  end

  def converted?
    (home_and_purchase?) ? (first_home_page_visit < last_purchase) : false
  end

end
