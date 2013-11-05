if Meteor.isServer
  # create the admin user if not existing.
  # To login, type on browser console:
  # $ Meteor.loginWithPassword('admin','password')
  # To logout:
  # $ Meteor.logout()
  if Meteor.users.find().count() is 0
    id = Accounts.createUser
      username: 'admin'      # username and
      password: "password"   # password
    Roles.addUsersToRoles id, 'admin'

  # Prevent non-authorized users from creating new users
  Accounts.validateNewUser (user) ->
    if Roles.userIsInRole Meteor.user(), ['admin']
      return true
    throw new Meteor.Error 403, "Not authorized to create new users"

  # Count the submitted posts and store the value. 
  if Globals.find().count() is 0
    Globals.insert {submittedPosts: mayBePosts.find().count()}



