Future = Npm.require "fibers/future"

Meteor.methods
  
  # Called when a user submit a link.
  post: (postAttributes) ->
    maxPosts = 50 # maxPosts is magical number
    if not (Globals.findOne().submittedPosts < maxPosts)
      throw new Meteor.Error(503, 'Sorry, submissions are currently blocked')
    if not postAttributes.url
      throw new Meteor.Error(422, 'Please insert the URL')
    mayBePostWithSameLink = mayBePosts.findOne {url: postAttributes.url}
    postWithSameLink = Posts.findOne {url: postAttributes.url}
    if (mayBePostWithSameLink or postWithSameLink)
      throw new Meteor.Error(302, 'Sorry, this link has already been posted')
    postAttributes.username = postAttributes.username.replace('@','').trim()
    post = _.extend(_.pick(postAttributes, 'url', 'title', 'username'),
      submitted: new Date().getTime()
    )
    id = Globals.findOne()._id
    Globals.update(id, {$inc: {submittedPosts: 1}})
    postId = mayBePosts.insert post
  
  #
  latestWeek: () ->
    Math.floor (Posts.find({'onweek': {$ne: 'false'}}).count() - 1)/7
  
  # Called when a user upvote a post.
  # Note that the user can upvote the same post many times
  # (the number of votes is not visible to the users).
  upVote: (id) ->
    Posts.update(id, {$inc: {score: 1}})
  
  # Get a cursor of a random sample of posts.
  # The posts have a score less than N.
  getRandomSample: (n, visitedPostsIds) ->
    now = new Date().getTime()
    oneWeekAgo = now - 1000*60*60*24*7
    N = 100 # N is a magical number
    posts = Posts.find({'onweek': 'false', 'passed': {$gte: oneWeekAgo}, 'score': {$lte: N}}).fetch()
    newPostsIds = _.difference (i._id for i in posts), visitedPostsIds
    newPostsIds = _.shuffle newPostsIds
    listOfIds = newPostsIds[..n-1]
    Posts.find({'_id': {$in: listOfIds}}, {fields: {title: 1, url: 1, urlImage: 1, username: 1}}).fetch()

  # Set the Twitter profile image.
  setProfileImageUrl: (username, postId) ->
    url = ProfileImages.findOne({'username': username})?.url
    if url is undefined
      fut = new Future() #https://gist.github.com/possibilities/3443021
      Twit = new TwitMaker
        consumer_key:         'consumer_key'
        consumer_secret:      'consumer_secret'
        access_token:         'access_token'
        access_token_secret:  'access_token_secret'
      Twit.get 'users/show', { screen_name: username }, (err, reply) ->
        if err
          console.log err
          fut['return'] 'http://a0.twimg.com/sticky/default_profile_images/default_profile_6_normal.png'
          #fut['return'] ''
        else
          fut['return'] reply.profile_image_url      
      url = fut.wait()
      ProfileImages.insert {'username': username, 'url': url}
    mayBePosts.update {'_id': postId}, {$set: {'urlImage': url}}

  subscribeEmail: (email) ->
    # set here the email marketing service provider of your choice