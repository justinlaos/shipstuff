# README

Welcome to ShipStuff

* Version
This app uses Rails 7 and Ruby 2.7.0
    
* Get it running
```brew install mongodb-community@6.0```
```brew services start mongodb-community@6.0```

CD into repo

```bundle install```
```rails db:seed```
```rails s```

then run the frontend 

* How to run the test suite
```rake db:seed RAILS_ENV=test --trace```
```rails test```


* API Docs

```http://localhost:3000/products```
is the product crud endpoint. "/products" will return all products in the database. if you add params 
length, width, height, and weight. It will return a product that fits the query

```http://localhost:3000/products?length=26&width=16&height=22&weight=50```
will return Checked Bag

if there are missing params or none numbers for params it will return a error message
