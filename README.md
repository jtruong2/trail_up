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
$ rails s
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

## Developing

Here's a brief intro about what a developer must do in order to start developing
the project further:

```shell
git clone https://github.com/your/awesome-project.git
cd awesome-project/
packagemanager install
```

And state what happens step-by-step.

### Building

If your project needs some additional steps for the developer to build the
project after some code changes, state them here:

[image](Screen Shot 2017-09-20 at 7.00.17 PM copy)
```shell
./configure
make
make install
```

Here again you should state what actually happens when the code above gets
executed.

### Deploying / Publishing

In case there's some step you have to take that publishes this project to a
server, this is the right time to state it.

```shell
packagemanager deploy awesome-project -s server.com -u username -p password
```

And again you'd need to tell what the previous code actually does.

## Features

What's all the bells and whistles this project can perform?
* What's the main functionality
* You can also do another thing
* If you get really randy, you can even do this

## Configuration

Here you should write what are all of the configurations a user can enter when
using the project.

#### Argument 1
Type: `String`  
Default: `'default value'`

State what an argument does and how you can use it. If needed, you can provide
an example below.

Example:
```bash
awesome-project "Some other value"  # Prints "You're nailing this readme!"
```

#### Argument 2
Type: `Number|Boolean`  
Default: 100

Copy-paste as many of these as you need.

## Contributing

When you publish something open source, one of the greatest motivations is that
anyone can just jump in and start contributing to your project.

These paragraphs are meant to welcome those kind souls to feel that they are
needed. You should state something like:

"If you'd like to contribute, please fork the repository and use a feature
branch. Pull requests are warmly welcome."

If there's anything else the developer needs to know (e.g. the code style
guide), you should link it here. If there's a lot of things to take into
consideration, it is common to separate this section to its own file called
`CONTRIBUTING.md` (or similar). If so, you should say that it exists here.

## Licensing

One really important part: Give your project a proper license. Here you should
state what the license is and how to find the text version of the license.
Something like:

"The code in this project is licensed under MIT license."
