# Register dependency on user so subscriptions
# will update once user has logged in
Deps.autorun () ->
  reactiveVar = Meteor.userId()
  Meteor.subscribe "acceptedPosts"
  Meteor.subscribe "notAcceptedPosts"

# Subscribe all clients to the accepted posts
Deps.autorun () ->
  Session.set 'loading', true
  Meteor.subscribe "weeklyPosts", +Session.get('week'), () ->
    Session.set 'loading', false

# Global variables
Meteor.subscribe "Globals"