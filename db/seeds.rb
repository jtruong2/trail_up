class Seed
  def self.start
    seed = Seed.new
    seed.generate_users
    seed.generate_trails
    seed.generate_events
  end

  def generate_users
    20.times do |i|
      user = User.create!(
        username: Faker::Name.name, 
        email: Faker::Internet.email,
        password: 'password'
      )
      puts "User #{i}: #{user.username} created!"
    end
  end

  def generate_trails
    10.times do |i|
      trail = Trail.create!(
        name: "#{Faker::Hobbit.location}, #{Faker::Address.community}",
        description: Faker::Hobbit.quote,
        difficulty: %w(white, blue, green, black diamond, double black diamond).sample,
        distance: %w(5,10,15,20,25,50,100).sample,
        rating: %w(1,2,3,4).sample,
        longitude: longitude,
        latitude: latitude
      )
      puts "User #{i}: #{trail.name} created!"
    end
  end
  
  def generate_events
    10.times do |i|
      trail = Trail.offset(i).first
      user = User.offset(i).first
      event = Event.create(
        trail_id: trail.id,
        name: Faker::Space.agency,
        description: Faker::Hobbit.quote,
        date: Faker::Date.between(Date.today, 1.year.from_now)
      )
      EventRole.create(event_id: event.id, user_id: user.id, role: 1)
      assign_guests(event)
      puts "Event #{i}: #{event.name} created!"
    end
  end

  def assign_guests(event)
    5.times do |i|
      users = User.offset(i+5).to_a
      EventRole.create(event_id: event.id, user_id: users.pop.id)
      puts "Assigned #{i} users to #{event.name}"
    end
  end


  def latitude
    (19.50..44.85).step(0.01).to_a.sample
  end

  def longitude
    (-141.75..-88.01).step(0.01).to_a.sample
  end
end

Seed.start