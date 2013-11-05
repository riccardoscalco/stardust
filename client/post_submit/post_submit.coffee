Template.postSubmit.events
  'submit form': (e) ->
    e.preventDefault()
    username = $(e.target).find('[name=username]').val()
    post =
      url: $(e.target).find('[name=url]').val()
      title: $(e.target).find('[name=title]').val()
      username: username
    postId = undefined
    Meteor.call 'post', post, (error,result) ->
      if error
        Session.set 'alertMessage', error.reason
        $("#alertMessage").collapse('show')
      else
        Session.set 'alertMessage',
          'Your link will be submitted to the editors, thanks'
        $("#alertMessage").collapse('show')
        if post.username
          Meteor.call 'setProfileImageUrl', username, result, (err, res) ->
            if error
              console.log err
            return

      
    

