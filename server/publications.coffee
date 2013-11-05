# Posts listed on pages ../adminweek and ../new
Meteor.publish "acceptedPosts", () ->
  if Roles.userIsInRole this.userId, ['admin']
    return Posts.find {'onweek': 'false'}
  else
    this.stop()
    return

# Posts listed on page ../admin
Meteor.publish "notAcceptedPosts", () ->
  if Roles.userIsInRole this.userId, ['admin']
    return mayBePosts.find()
  else
    this.stop()
    return

# Global parameters
Meteor.publish "Globals", () -> Globals.find()

# Weekly posts
Meteor.publish "weeklyPosts", (week) ->
  Posts.find {'onweek': week}, {sort: {submitted: -1}, fields: {score: 0, passed: 0}}



