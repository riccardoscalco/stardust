Template.emailSubscribe.events
  'click #subscribeButton': (e) ->
    e.preventDefault()
    email = $("#emailInput").val()
    if email
      Meteor.call "subscribeEmail", email
      $("#subscribedMessage").collapse('show')
  'click #closeButton': (e) ->  
    $("#subscribedMessage").collapse('hide')