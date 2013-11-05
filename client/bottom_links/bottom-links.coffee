Template.bottomLinks.events
  'click #suggest': (e) ->
    e.preventDefault()
    if not (Globals.findOne().submittedPosts < 50)
      Session.set 'alertMessage', 'Sorry, submissions are currently blocked'
      $("#alertMessage").collapse('show')
      $("html, body").animate({ scrollTop: $(document).height() }, 1000)
    else
      $("#submitForm").collapse('toggle')
      $("html, body").animate({ scrollTop: $(document).height() }, 1000)
