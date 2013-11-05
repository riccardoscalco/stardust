Template.postItem.helpers
  domain: ->
    a = document.createElement "a"
    a.href = @url
    a.hostname
  notAdmin: -> not ((Meteor.Router.page() is "postsList") or 
    (Meteor.Router.page() is "postsWeekly"))
  adminPage: -> Meteor.Router.page() is "postsList"
  newPostsPage: -> Meteor.Router.page() is "postsNew"
  weeklyPage: -> Meteor.Router.page() is "postsWeekly"
  votes: -> @score
  submittedDate: -> new Date(@submitted).toString()
  alreadyVoted: -> @voted
  hasImage: -> Boolean @urlImage
  twitterUrl: ->
    "https://twitter.com/intent/tweet" +
    "?original_referer=http://mysite.co" + 
    "&url=" + @url +
    "&text=" + (encodeURIComponent(@title)) + 
    "&via=mysite"
  googleUrl: ->
    "https://plus.google.com/share" +
    "?url=" + @url
  facebookUrl: ->
    "https://www.facebook.com/sharer/sharer.php" +
    "?u=" + @url

Template.postItem.events
  'click .share': (e) ->
    e.preventDefault()
    if Session.get('atItemId') isnt @_id and not $("#" + Session.get('atItemId') + " .share-icons").hasClass("hidden")
      $("#" + Session.get('atItemId') + " .share-icons").toggleClass("hidden")
    Session.set 'atItemId', @_id
    $("#" + @_id + " .share-icons").toggleClass("hidden")
  'click .up-vote': (e) ->
    e.preventDefault()
    $(e.currentTarget).toggleClass('icon-thumbs-up-alt')
    $(e.currentTarget).toggleClass('no-vote')
    $(e.currentTarget).toggleClass('up-vote')
    $(e.currentTarget).toggleClass('icon-thumbs-up')
    NewPosts.update(@_id, {$set: {voted: true}}) 
    Meteor.call 'upVote', @_id

  'click button': (e) ->
    e.preventDefault()
    action = $(e.currentTarget).find("i").attr("class")[5..]
    switch action
      when 'remove'
        mayBePosts.remove @._id
        id = Globals.findOne()._id
        Globals.update(id, {$inc: {submittedPosts: -1}})
      when 'ok'
        Meteor.call 'okpost', @
        mayBePosts.remove @._id
        id = Globals.findOne()._id
        Globals.update(id, {$inc: {submittedPosts: -1}})
      when 'heart'
        if (Session.get('setWeek')? and Session.get('setDateWeek')?)
          Posts.update(@._id, {$set:
            onweek: Session.get('setWeek'),
            dateweek: Session.get('setDateWeek')
            }
          )
      when 'trash'
        Posts.remove @._id

Template.postItem.rendered = ->
  $('img[rel=tooltip]').tooltip()