Template.alertMessage.events
  'click button': (e) ->
    e.preventDefault()
    $("#alertMessage").collapse('hide')
    if $("#submitForm").hasClass('in')
      $("#submitForm").collapse('hide')

Template.alertMessage.helpers
  'message': -> Session.get 'alertMessage'