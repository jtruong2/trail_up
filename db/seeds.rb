class Seed
  attr_reader :user_counter

  def initialize
    @user_counter = 0
  end

  def self.start
    seed = Seed.new
    seed.drop_tables
    seed.generate_users(20)
    seed.generate_difficulties
    sleep 2
    seed.generate_trails(10)
    sleep 2
    seed.generate_events(10)
    sleep 2
    seed.generate_trails(10)
    sleep 2
    seed.generate_events(10)
    sleep 2
    seed.generate_trails(10)
    sleep 2
    seed.generate_events(10)
    sleep 2
    seed.most_active_user_events
    seed.fitbit_user
  end

  def fitbit_user
    user = User.create!(username: "Active User", email: "activeuser@gmail.com", password: "password")
    difficulty = Difficulty.create!(rating: 5)
      trail = Trail.create!(
        name: "#{Faker::Hobbit.location}, #{Faker::Address.community}",
        description: Faker::Hobbit.quote,
        distance: %w(5,10,15,20,25,50,100).sample,
        rating: %w(1,2,3,4).sample,
        longitude: 39.7392,
        latitude: 104.9903,
        difficulty_id: difficulty.id
      )
      event_1 = Event.create!(
        trail_id: trail.id,
        name: Faker::Space.agency,
        description: Faker::Hobbit.quote,
        date: DateTime.new(2017, 7, 15),
        longitude: 39.7392,
        latitude: 104.9903,
        archived: true
      )
      EventRole.create!(user_id: user.id, event_id: event_1.id, role: 1)
      event_2 = Event.create!(
        trail_id: trail.id,
        name: Faker::Space.agency,
        description: Faker::Hobbit.quote,
        date: DateTime.new(2017, 7, 16),
        longitude: 39.7392,
        latitude: 104.9903,
        archived: true
      )
      EventRole.create!(user_id: user.id, event_id: event_2.id, role: 1)
      event_3 = Event.create!(
        trail_id: trail.id,
        name: Faker::Space.agency,
        description: Faker::Hobbit.quote,
        date: DateTime.new(2017, 7, 17),
        longitude: 39.7392,
        latitude: 104.9903,
        archived: true
      )
      EventRole.create!(user_id: user.id, event_id: event_3.id, role: 1)
      event_4 = Event.create!(
        trail_id: trail.id,
        name: Faker::Space.agency,
        description: Faker::Hobbit.quote,
        date: DateTime.new(2017, 7, 18),
        longitude: 39.7392,
        latitude: 104.9903,
        archived: true
      )
      EventRole.create!(user_id: user.id, event_id: event_4.id, role: 1)
    end


  def drop_tables
    Event.destroy_all
    Trail.destroy_all
    User.destroy_all
    Difficulty.destroy_all
  end

  def generate_users(n)
    n.times do |i|
      user = User.create!(
        username: Faker::Name.name,
        email: Faker::Internet.email,
        password: 'password'
      )
      puts "User #{i}: #{user.username} created!"
    end
    admin = User.create!(
      username: 'admin',
      email: 'admin@admin.com',
      password: 'password',
      role: 'admin'
    )
  end

  def generate_difficulties
    [ 'White', 'White-Green', 'Green', 'Green-Blue',
      'Blue', 'Blue-Black', 'Black Diamond', 'Double Black Diamond' ].each do |diff|
        difficulty = Difficulty.create(rating: diff)
        puts "Difficulty #{Difficulty.last.rating} created!"
      end
  end

  def generate_trails(n)
    n.times do |i|
      trail = Trail.new(
        name: "#{prefix} #{Faker::Zelda.location} #{suffix}",
        description: Faker::Hobbit.quote,
        distance: %w(5,10,15,20,25,50,100).sample,
        rating: %w(1,2,3,4).sample,
        longitude: longitude,
        latitude: latitude
      )

      trail.difficulty = Difficulty.all.sample
      trail.save

      puts "User #{i}: #{trail.name} created!"
    end
  end

  def generate_events(n)
    n.times do |i|
      trail = Trail.order('Random()').first
      user = User.order('Random()').first
      event = generate_event(trail)
      user.event_roles.create(event_id: event.id, role: 1)
      assign_guests(event)
      puts "Event #{i}: #{event.name} created!"
    end
  end

  def generate_event(trail)
        Event.create(
        trail_id: trail.id,
        name: "#{event_prefix} #{Faker::Hipster.words.sample.capitalize} #{event_suffix}",
        description: Faker::Hobbit.quote,
        date: Faker::Date.between(Date.today, 1.year.from_now)
      )
  end

  def assign_guests(event)
    5.times do |i|
      users = User.offset(i).to_a
      EventRole.create(event_id: event.id, user_id: users.pop.id)
      puts "Assigned #{i} users to #{event.name}"
    end
  end

  def most_active_user_events
    user = User.create!(username: "Mr. Popular", email: "mrpopular@gmail.com", password: "password")
    user_b = User.create!(username: "Mr. UnPopular", email: "mrunpopular@gmail.com", password: "password")
    5.times do |i|
      trail = Trail.order('Random()').first
      upcoming_host_event = generate_event(trail)
      archived_host_event = generate_event(trail)
      upcoming_guest_event = generate_event(trail)
      archived_guest_event = generate_event(trail)
      EventRole.create(event_id: upcoming_host_event.id, user_id: user.id, role: 0)
      EventRole.create(event_id: archived_host_event.id, user_id: user.id, role: 0)
      EventRole.create(event_id: upcoming_host_event.id, user_id: user_b.id, role: 1)
      EventRole.create(event_id: archived_host_event.id, user_id: user_b.id, role: 1)
      EventRole.create(event_id: upcoming_guest_event.id, user_id: user.id, role: 1)
      EventRole.create(event_id: archived_guest_event.id, user_id: user.id, role: 1)
    end
  end

  def latitude
    (37.74..40.74).step(0.01).to_a.sample
  end

  def longitude
    (-105.99...-102.99).step(0.01).to_a.sample
  end

  def suffix
    %w(Trail Path Way Gulley Path Footpath By-Way Route).sample
  end

  def prefix
    %w(North Northwest Northeast South Southwest Southeast East West Circular).sample
  end

  def event_prefix
    %w(Moonlit Sunrise Sunset Exciting Adventurous Casual Professional Educational Quick Dangerous Fantastical Co-Ed Early-Morning Late-Afternoon).sample
  end

  def event_suffix
    %w(Hike Walk Stroll Run Trail-Run Ascent Descent Climb Trek March Ramble Tour Trip Excursion Traipse Exploration).sample
  end
end

Seed.start
