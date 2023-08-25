# Study Buddy App

An application where a student can find a study partner.

## Main Features
1. Log in and Log-out
2. Update personal information including password
3. Upload profile photo using activ estorage
4. Book a meeting
5. Chat with their partner. Messages are not updated in real time.
6. Access data through API Endpoints (need API key to authenticate)


## What did I learn
1. How to build a full-stack web applicaaiton.
2. How to handle database.
3. How to manage different routes
4. Active Storage in Rails
5. Nested Resources in Rails
6. Create Authentication and Authorisation functionality from scratch
7. How to add API functionality to a web application

## Development
1. Clone the repository
2. Run bundle command
3. Migrate database 
```ruby
rails db:migrate
```
4. Seed data using
```ruby
rails db:seed
```
5. Run the server inside the project folder using
```ruby
rails s
```
6. Generate an API key using
```ruby
curl -v -X POST https://study-buddy-app-api.herokuapp.com/api \ -u chris@gogo.com:aaa
```
7. Communicate with App using these Endpoints
```ruby
https://study-buddy-app-api.herokuapp.com/api/ 
https://study-buddy-app-api.herokuapp.com/api/user
https://study-buddy-app-api.herokuapp.com/api/time_slots
https://study-buddy-app-api.herokuapp.com/api/time_slots?id=2
https://study-buddy-app-api.herokuapp.com/api/meetings
https://study-buddy-app-api.herokuapp.com/api/meeting?id=1
https://study-buddy-app-api.herokuapp.com/api/meeting
```

