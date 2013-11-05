Template.loadingPage.rendered = ->
  NProgress.start()
  Meteor.setInterval(
    () ->
      if Session.get('loading') is false
        NProgress.done()
    ,
    500)
