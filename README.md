# traintrack

![](http://i.giphy.com/pkKfX8NzvSW88.gif)

A rails app for tracking personal development expenses.

Train Track. get it?

## To install

(This only might work)

Install dependencies:

```
$ bundle install
```

Then, copy `.env.sample` to `.env` and fill it in:

```
$ cp .env{.sample,}
```

Create database:

```
$ rake db:create
```

GO:

```
rails server
```

## To deploy

Master is automatically deployed. Don't push WIP commits.