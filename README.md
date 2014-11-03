# Running Locally

The Gemfile expects that you're running `ruby` version `2.1.2`. If you have installed `rbenv`, you should be able to do `rbenv install 2.1.2`. Alternatively, you should be okay to comment out the ruby line in `Gemfile` and use whatever ruby you have installed (though please don't check in that change).`

Clone down and `cd` into the project and then run

```
$ bundle
$ bundle exec rake db:setup
$ bundle exec rails s
```

You should then be able to navigate to `localhost:3000` and see the welcome page. Press Ctrl-C in the terminal running the server to stop it.

You can manipulate sample Topics in the rails console as follows:

```
$ bundle exec rails console
> t = Topic.new
> t.title = '...'
> t.description = '...'
> t.save!
> exit
```
