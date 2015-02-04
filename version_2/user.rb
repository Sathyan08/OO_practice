class User

  attr_reader :id, :events, :age

  @@all = []
  @@home_visitors = []
  @@blog_visitors = []
  @@converted = []

  def self.all
    @@all
  end

  def self.home_visitors
    @@home_visitors
  end

  def self.blog_visitors
    @@blog_visitors
  end

  def self.converted
    @@converted
  end

  def initialize(id, data)
    @id = id
    @events = []
    @age = data["age"]

    @home_visitor = false
    @made_purchase = false
    @sorted = false

    @@all << self
  end

  def add_event(event)
    @home_visitor = true if event.name == "Visit the Home Page"
    @@home_visitors << self if event.name == "Visit the Home Page"

    @@blog_visitors << self if event.name == "Visit a Blog Page"

    @made_purchase = true if event.name == "Purchased Item in Cart"
    self.converted?  if self.home_visitor && self.made_purchase

    @sorted = false
    @events << event
  end

  def events_by_time
    @events.sort_by! { |event| event.time } if !@sorted
    @sorted = true
    @events
  end

  def first_home_visit
    events_by_time.index { |event| event.name == "Visit the Home Page" }
  end

  def last_purchase
    events_by_time.rindex { |event| event.name == "Purchased Item in Cart" }
  end

  def converted?
    @@converted << self if first_home_visit < last_purchase
  end

  def after_home
    after = first_home_visit + 1
    events_by_time[after]
  end

  def first_blog
    events_by_time.index { |event| event.name == "Visit a Blog Page" }
  end

  def events_after_blog
    after = first_blog + 1
    events_by_time[after..-1]
  end

end
