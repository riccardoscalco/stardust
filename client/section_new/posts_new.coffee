# create a local database (minimongo)
@NewPosts = new Meteor.Collection null

NewPosts.allow
  update: -> true

@getRandomSample = (n) ->
  visitedPostsIds = (i._id for i in NewPosts.find().fetch())
  Meteor.call 'getRandomSample', n, visitedPostsIds, (error, newPosts) ->
    if error
      console.log error.reason
    else
      if newPosts.length is 0
        $("#noMoreNewLinks").collapse('show')  
      l = visitedPostsIds.length
      newPosts.forEach (element, index) ->
        element['position'] = l + index + 1
        element['voted'] = false
        NewPosts.insert(element)

if Meteor.isClient
  Meteor.startup ->
    Session.setDefault 'loading', true
    getRandomSample 5


Template.postsNew.helpers
  posts: -> NewPosts.find {}, {sort: {position: -1}}

Template.postsNew.events
  'click #closeButton1': (e) ->  
    $("#noMoreNewLinks").collapse('hide')