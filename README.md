> Stardust is a linkblog template powered by [Meteor][1]. You have the
> opportunity to suggest links and to upvote links suggested by others.
> See a demo at [stardust.meteor.com][3].
>
> *Please enjoy*.

Quick Start
-----------

Create a meteor project and download Stardust:

```
$ mkdir project
$ cd project
$ git clone git://github.com/riccardoscalco/stardust.git .
$ meteor create stardust
$ mv * stardust
$ cd stardus
$ rm stardust.*
```

Install packages:

```
$ meteor add bootstrap
$ meteor add coffeescript
$ meteor add underscore
$ meteor add spiderable
$ meteor add http
```

```
$ mrt add router
$ mrt add accounts-password
$ mrt add roles
$ mrt add font-awesome
$ mrt add twit
$ mrt add nprogress
```

Start Meteor:

```
$ meteor remove autopublish
$ meteor remove insecure
```
```
$ meteor
```


Admin User
----------

Set username and password in the file `../server/admin.coffee`.

To login/logout, type on the browser console:
```
$ Meteor.loginWithPassword('admin','password')
$ Meteor.logout()
```

The admin uses two paths.

The first path is `site.co/admin`, here the admin can delete or accept the posts. Posts are ordered according to *Mongodb natural order*. Accepted posts will appear in the section `New`, where they are *randomly* proposed for a period of one week since their submission.

The second path is `site.co/adminweek`, where the admin can publish the posts on the weekly list. Posts are ordered according to decreasing number of votes and more recent date of submission. There are two fields to fill in, the first one is the week number (the hint should be correct), the second one is the week name, something like `November 12th - 18th, 2013`.


Parameters
-------------

#### Magic numbers

There is a couple of magic numbers in the file `../server/methods.coffee`. 
The first is the variable `maxPosts`, it blocks link submissions if the number of submitted links is greater than a `maxPosts`.
The second is the variable `N` on the `getRandomSample` function, it filters the random sample of posts to show in the section `New` in a way that
only posts with a score less than `N` will have the possibility to be chosen (and then voted).

The value of `N` should represent the expected maximum score a post can have, calculated according to the past ranks. Being it generally unknown from the users, it can be useful to prevent cheating (a score much greater than `N` is possible only with a cheating).

#### Credentials

Google Analytics credentials are provided in the file `./client/utility/googleAnalytics.js`. Uncomment the code and use your data to fill thel line `ga('create', ' ', ' ')`.

In order to show the users' Twitter pictures, `consumer-key` and `access-token` have to be indicated in the file `./server/methods.coffee`.



--------------------------



> Written with [StackEdit](https://stackedit.io/).


  [1]: http://www.meteor.com
  [2]: http://seofon.co
  [3]: http://stardust.meteor.com