Template.arrows.helpers
  previousWeek: () -> "" + (+Session.get("week") - 1)
  notFirstWeek: () -> +Session.get("week") isnt 0
  nextWeek: () -> "" + (+Session.get("week") + 1)
  notLatestWeek: () -> +Session.get("week") isnt +Session.get("latestweek")
  dateWeek: () ->
    if Posts.findOne {"onweek": +Session.get("week")}
      Posts.findOne({"onweek": +Session.get("week")}).dateweek
  onPostsNewPage: () -> Meteor.Router.page() is "postsNew"
  onWeekPage: -> Meteor.Router.page() is "weekPage"
  
Template.arrows.events
  'click .getMorePosts': (e) ->
    e.preventDefault()
    getRandomSample 5