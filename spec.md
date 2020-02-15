# Specifications for the Sinatra Assessment

Specs:
- [x] Use Sinatra to build the app
# required the sinatra gem and then bundle install
- [x] Use ActiveRecord for storing information in a database
# required activerecord gem
- [x] Include more than one model class (e.g. User, Post, Category)
# two models, gig and user
- [x] Include at least one has_many relationship on your User model (e.g. User has_many Posts)
# user has_many gigs (models/user)
- [x] Include at least one belongs_to relationship on another model (e.g. Post belongs_to User)
# gig belongs_to user (models/gig)
- [x] Include user accounts with unique login attribute (username or email)
# user cannot signup if username or email already exists (users_controller post signup)
- [x] Ensure that the belongs_to resource has routes for Creating, Reading, Updating and Destroying
# shown in gigs_controller.rb
- [x] Ensure that users can't modify content created by other users
# edit does not show up on screen for gig that user did not create (shown in gigs/index.erb)
- [x] Include user input validations
# form will not submit if user does not fill out entirely (gigs/new, users/login, users/signup)
- [ ] BONUS - not required - Display validation failures to user with error message (example form URL e.g. /posts/new)
- [x] Your README.md includes a short description, install instructions, a contributors guide and a link to the license for your code

Confirm
- [x] You have a large number of small Git commits
- [x] Your commit messages are meaningful
- [x] You made the changes in a commit that relate to the commit message
- [x] You don't include changes in a commit that aren't related to the commit message