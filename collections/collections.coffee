# Accepted posts
@Posts = new Meteor.Collection 'posts'
Posts.allow
  insert: -> Roles.userIsInRole Meteor.user(), ['admin']
  update: -> Roles.userIsInRole Meteor.user(), ['admin']
  remove: -> Roles.userIsInRole Meteor.user(), ['admin']

# Submitted posts
@mayBePosts = new Meteor.Collection 'maybeposts'
mayBePosts.allow
  update: -> Roles.userIsInRole Meteor.user(), ['admin']
  remove: -> Roles.userIsInRole Meteor.user(), ['admin']

@Globals = new Meteor.Collection 'globals'
Globals.allow
  update: -> Roles.userIsInRole Meteor.user(), ['admin']

# Twitter profile images
@ProfileImages = new Meteor.Collection 'images'

Meteor.methods
  # Called when the admin accepts a post.
  okpost: (thePost) ->
    post = _.extend(_.pick(thePost, 'url', 'title', 'username', 'submitted', 'urlImage'),
      passed: new Date().getTime()
      score: 0
      onweek: 'false'
    )
    if Roles.userIsInRole Meteor.user(), ['admin']
      postId = Posts.insert post
    else
      throw new Meteor.Error(403, 'Insert failed, forbidden.')