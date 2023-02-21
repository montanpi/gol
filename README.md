# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

- Ruby version
  - 3.2.0
- Deployment instructions
  - build and run/deploy docker image
- Deployed on
  - [render](https://gol.onrender.com/) and [heroku](gol.herokuapp.com)
- A few things to keep in mind
  - deployed on free instances, so it takes a few seconds to wake up and load the page
  - the user must sign up with (not verified) email and password on first access
  - the uploaded file is in the format specified on [extendi/game-of-life](https://github.com/extendi/game-of-life#solution-implementation) repo
  - file validation is implemented, but there's no user feedback when uploading a file in invalid format; if the file is valid, the user is redirected to the game page
- Implementation details
  - html for the matrix is generated on rails app and sent through server-sent-events stream
  - network latency is the main bottleneck
  - in order to get up and running quickly `async` adapter was used instead of `redis`
- Todo
  - user feedback for invalid login and file upload
  - use production mode instead of development
  - add generation number to the state
