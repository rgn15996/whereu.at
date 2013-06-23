App = Ember.Application.create()

# Router

App.Router.map ->
  # put your routes here
  @resource('locations')

App.LocationsRoute = Ember.Route.extend
  model: ->
    App.Location.find()

App.IndexRoute = Ember.Route.extend
  model: ->
    return ['red', 'yellow', 'blue']

# Controllers

App.IndexController = Ember.ObjectController.extend
  longitude: 0
  latitude: 0
  accuracy: 0
  heading: 0
  speed: 0
  geo: false
  init: ->
    if (navigator.geolocation)
      console.log 'Apparently there is geolocation'
      navigator.geolocation.getCurrentPosition(@geoLocation.bind(this), @noGeo.bind(this))
      @set('geo', true)
    else
      console.log 'No geolocation - bummer'
      @set('geo', false)

  geoLocation: (location) ->
    @set('latitude', location.coords.latitude)
    @set('longitude', location.coords.longitude)
    @set 'accuracy', location.coords.accuracy
    @set 'heading', location.coords.heading
    @set 'speed', location.coords.speed
    console.log 'I think I got a position'

  noGeo: (positionError) ->
    console.log 'noGeo: Oops!'
    console.log positionError.message
    @set('status', positionError.message)

App.LocationsController = Ember.ArrayController.extend()
  # timeNow = moment().format()
  # console.log timeNow
  # )


# Models

App.Store = DS.Store.extend
  adapter: 'DS.FixtureAdapter'

App.Location = DS.Model.extend
  name: DS.attr('string'),
  lat:  DS.attr('number'),
  long: DS.attr('number'),
  seen: DS.attr('date')

App.Location.FIXTURES = [
  {
    id:   1,
    name: "Alice",
    lat:  52.63001,
    long: 1.3010,
    seen: 0
  },
  {
    id:   2,
    name: "Bob",
    lat:  52.59231,
    long: 1.2810,
    seen: 0
  },
  {
    id:   3,
    name: "Christine",
    lat:  52.6339,
    long: 1.29002,
    seen: 0
  }
]