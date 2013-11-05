Meteor.call 'latestWeek', (error, result) ->
  if error
    console.log error.reason
  else
    Session.set 'latestweek', "" + result
