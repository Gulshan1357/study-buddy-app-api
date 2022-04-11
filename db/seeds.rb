User.destroy_all
User.reset_pk_sequence
Slot.destroy_all
Slot.reset_pk_sequence
Meeting.destroy_all
Message.destroy_all

uc = User.create!(
  email: 'chris@go.com',
  password: 'aaa',
  password_confirmation: 'abc',
  first_name: 'Chris',
  last_name: 'Hemsworth',
  details: 'I am a fourth year student. I also love acting, reading books and nature. ',
  )
uc.avatar.attach(io: File.open(File.join(Rails.root,'app/assets/images/chris.jpg')), filename: 'chris.jpg')

User.first.Slot.create(start_time: '2022-04-10 19:00:00')

ue = User.create!(
  email: 'elsa@go.com',
  password: 'sss',
  password_confirmation: 'abc',
  first_name: 'Elsa',
  last_name: 'Pataky',
  details: 'I am a third year student. I love reading, skiing and chess',
  )
ue.avatar.attach(io: File.open(File.join(Rails.root,'app/assets/images/elsa.jpg')), filename: 'elsa.jpg')

User.last.Slot.create(
  start_time: '2022-04-10 19:00:00',
  user_id: User.last,
  )


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

