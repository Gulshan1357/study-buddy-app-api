# User.destroy_all
# Slot.destroy_all
# Meeting.destroy_all
# Message.destroy_all

chris = User.create!(
  email: 'chris@gogo.com',
  password: 'aaa',
  password_confirmation: 'aaa',
  first_name: 'Chris',
  last_name: 'Hemsworth',
  details: 'I am a fourth year student. I also love acting, reading books and nature. '
  )
# chris.avatar.attach(io: File.open(File.join(Rails.root,'app/assets/images/chris.jpg')), filename: 'chris.jpg')
if chris.persisted?
  chris.slots.create(
    start_time: DateTime.new(2022,05,25,12)
  )
end

elsa = User.create!(
  email: 'elsa@gogo.com',
  password: 'eee',
  password_confirmation: 'eee',
  first_name: 'Elsa',
  last_name: 'Patakay',
  details: 'I am a second year student. I love running, mountain climbing and skiing.'
)
# elsa.avatar.attach(io: File.open(File.join(Rails.root,'app/assets/images/elsa.jpg')), filename: 'elsa.jpg')
if elsa.persisted?
  elsa.slots.create(
    start_time: DateTime.new(2022,05,25,12)
  )
end

if elsa.persisted? and chris.persisted?
  meeting = Meeting.create!(
    starts_at: DateTime.new(2022,05,25,12),
    ends_at: DateTime.new(2022,05,25,13),
    first_user_id: 1,
    second_user_id: 2
  )
  if meeting.persisted?
    meeting.messages.create(
      sender: 'Elsa',
      content: 'Hi'
    )
    meeting.messages.create(
      sender: 'Chris',
      content: 'Hello, how are you doing?'
    )
    meeting.messages.create(
      sender: 'Elsa',
      content: 'I am doing good. Planing to study in ETB at 12pm tomorrow.'
    )
    meeting.messages.create(
      sender: 'Chris',
      content: 'Count me in! What are you planning to study.'
    )
    meeting.messages.create(
      sender: 'Elsa',
      content: 'Prototying Web applicatons'
    )
    meeting.messages.create(
      sender: 'Chris',
      content: 'What a coincidence! me too. I am facing trouble populating the database using seed file. It is especially difficult when a model has two primary keys both pointing to a same table'
    )
  end
end


# assasin = User.create!(
#   email: 'ezio5@gogo.com',
#   password: 'sss',
#   password_confirmation: 'sss',
#   first_name: 'Ezio',
#   last_name: 'Auditori',
#   details: 'I am a third year Assassin student. I love skulking, stalking and climbing walls'
# )
# assasin.avatar.attach(io: File.open(File.join(Rails.root,'app/assets/images/elsa.jpg')), filename: 'avatar.jpg')
# if assasin.persisted?
#   assasin.slots.create(
#     start_time: DateTime.new(2022,05,22,11)
#   )
# end

# if User.count < 10
#   10.times do
#     u = User.create(
#       email: FFaker::Internet.email,
#       password: 'random',
#       password_confirmation: 'random',
#       first_name: FFaker::Name.first_name,
#       last_name: FFaker::Name.last_name,
#       details: FFaker::Lorem.phrase,
#     )
#     u.avatar.attach(io: File.open(File.join(Rails.root,'app/assets/images/avatar.png')), filename: 'avatar.png')
#   end
# end

