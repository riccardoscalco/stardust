Meteor.Router.add
  '/admin': 'postsList'
  '/adminweek': 'postsWeekly'
  '/about': 'about'
  '/':
    as: 'latestWeekPage'
    to: 'weekPage'
    and: () -> 
      Session.set 'week', Session.get 'latestweek'
  '/new': 'postsNew'
  '/submit': 'postSubmit'
  '/success': 'successfullyInsert'
  '/week/:onweek':
    to: 'weekPage'
    and: (onweek) ->
      Session.set 'week', onweek

Meteor.Router.filters
  'beadmin': (page) ->
    if Roles.userIsInRole Meteor.user(), ['admin']
      return page
    else
      Meteor.Router.to "/"

Meteor.Router.filter 'beadmin', {only: ['postsList', 'postsWeekly']}
