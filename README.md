![Logo](https://github.com/MrAaronOlsen/trail-up/blob/master/app/assets/images/logo_trail_up.png)

# Trail Up
The #1 Social Media service for Colorado hikers to connect, plan trips, go hiking, and review their trails! 

![Neat](https://s-media-cache-ak0.pinimg.com/originals/b7/98/34/b79834e9c0c7779785ad73de99674b85.jpg)


## The Team
  
- [Aaron Olsen](https://github.com/MrAaronOlsen) 
- [Andrew Mossefin](https://github.com/frustratedswede) 
- [Benjamin Jacobs](https://github.com/ACC25) 
- [Carl Richmond](https://github.com/Benjaminpjacobs) 
- [Nick Edwards](https://github.com/nickedwards109) 
- [Michael Centrelli](https://github.com/Mcents) 
- [Jimmy Truong](https://github.com/jtruong2) 
- [Desislava Todorova](https://github.com/destodo)  
- [Will Rattermann](https://github.com/wratterman) 

## Installing / Getting started

We reccomend using `Ruby 2.4.1` and `Rails 5.2.1`, as those were the versions used during the development of this app.

To begin working with Trail Up, please run the following...

```shell
$ git clone git@github.com:jtruong2/trail_up.git 
$ cd trail_up
$ bundle
$ rake db:setup
```

Here you cloning Trail Up, changing directories into the new `trail_up` directory, loading all of of [gems](https://rubygems.org/) from the Gemfile by running `bundle`.

Our database is made up of the following
- Users 
  - Default Count: 24
  - Attrs: id, username, email, password_digest, slug, role, uid, fitbit_token, fitbit_id, provider
- Trails 
  - Default Count: 31
  - Attrs: id, name, description, location, distance, rating, longitude, latitude, hp_id, difficulty_id
- Difficulties 
  - Default Count: 9
  - Attrs: id, rating
- Events
  - Default Count: 54
  - Attrs: id, trail_id, name, description, location, distance, rating, longitude, latitude, hp_id, difficulty_id
- Event Roles
  - Default Count: 214
  - Attrs: id, user_id, event_id, role

## Configuration

In order to get this program to run, there are a number of keys that you are going to want to have running in the background. 

You may have notice `gem "figaro"` in your Gemfile, this is what we will be using to hide our keys. Once `bundle` has been run, make sure you run `figaro install` from the terminal. This will create a `config/application.yml` file and add that file to your git ignore. 

You will need keys for the following...
- [aws_access_key_id](http://docs.aws.amazon.com/general/latest/gr/aws-sec-cred-types.html)
- [aws_secret_access_key](http://docs.aws.amazon.com/general/latest/gr/aws-sec-cred-types.html)
- [hiking_project_api_key](https://www.hikingproject.com/data)
- [MEETUP_KEY](https://secure.meetup.com/meetup_api/key/)
- [MEETUP_SECRET](https://secure.meetup.com/meetup_api/key/)
- [google_map_api_key](https://developers.google.com/maps/documentation/embed/get-api-key)
- [WEATHER_KEY](https://www.wunderground.com/weather/api)
- [PHONE_NUMBER](https://www.twilio.com/docs/api/rest/available-phone-numbers)
- [ACCOUNT_SID](https://www.twilio.com/docs/api/rest)
- [AUTH_TOKEN](https://www.twilio.com/docs/api/rest)
- [PASSWORD](https://developer.ibm.com/answers/questions/182213/where-can-i-find-my-user-id-and-password.html)
- [USERNAME](https://developer.ibm.com/answers/questions/182213/where-can-i-find-my-user-id-and-password.html)
- [WORKSPACE_ID](https://developer.ibm.com/answers/questions/26886/how-to-get-an-api-key/)
- [TRUDY_URL](https://developer.ibm.com/answers/questions/26886/how-to-get-an-api-key/)

PLEASE MAKE SURE TO MATCH THE KEY NAMES BELOW, INCLUDE CASE SENSITIVITY. 
- ex. EXAMPLE_KEY: "1234567"

