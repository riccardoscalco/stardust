Template.weekPage.helpers
  posts: () -> Posts.find {onweek: +Session.get('week')}
  loading: () -> Session.get 'loading'