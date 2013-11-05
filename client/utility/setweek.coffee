Template.setWeek.helpers
  week: -> Session.get("setWeek")
  dateweek: -> Session.get("setDateWeek")
  weekNumber: -> +Session.get('latestweek') + 1

Template.setWeek.events
  'submit form': (e) ->
    e.preventDefault()
    Session.set 'setWeek', +$(e.target).find('[name=week]').val()
    Session.set 'setDateWeek', $(e.target).find('[name=dateweek]').val()