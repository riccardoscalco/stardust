Template.postsWeekly.helpers
  posts: -> Posts.find {'onweek': 'false'}, {sort: {score: -1, submitted: -1}}