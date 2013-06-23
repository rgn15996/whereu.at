App = Ember.Application.create()

# Router

App.Router.map ->
  # put your routes here
  @resource('locations')

App.LocationsRoute = Ember.Route.extend
  model: ->
    App.Location.find()
  # setupController: (controller, model) ->
  #   latty = @controllerFor('application').get('latitude')
  #   console.log "latty " + latty
  #   @set('latty', latty)

App.IndexRoute = Ember.Route.extend
  model: ->
    return ['red', 'yellow', 'blue']

# Controllers

App.ApplicationController = Ember.ObjectController.extend
  longitude: 0
  latitude: 0
  accuracy: 0
  tempus: 0
  geo: false
  status: ""
  init: ->
    @set('tempus', moment().format())
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
    # @set 'heading', location.coords.heading
    # @set 'speed', location.coords.speed
    console.log 'I think I got a position'

  noGeo: (positionError) ->
    console.log 'noGeo: Oops!'
    console.log positionError.message
    @set('status', positionError.message)  

# App.IndexController = Ember.ObjectController.extend


App.LocationsController = Ember.ArrayController.extend(
  needs: ['application'],
  lattyBinding: Ember.Binding.oneWay("controllers.application.latitude")
  longyBinding: Ember.Binding.oneWay("controllers.application.longitude")
  )
# Helpers

Ember.Handlebars.helper('distance', (lat1, lon1, lat2, lon2) ->
  R = 6371
  dlat = (lat1 - lat2).toRad()
  dlon = (lon1 - lon2).toRad()
  lat1 = lat1.toRad()
  lat2 = lat2.toRad()
  a = Math.sin(dlat/2) * Math.sin(dlat/2) + 
      Math.sin(dlon/2) * Math.sin(dlon/2) * Math.cos(lat1) * Math.cos(lat2)
  c = 2 * Math.atan(Math.sqrt(a), Math.sqrt(1-a))
  dist = (R * c).toPrecision(3)
  )
Ember.Handlebars.helper('displaynum', (num) ->
  num.toFixed(4)
  )
Number.prototype.toRad = ->
  this * Math.PI / 180

# Models

App.Store = DS.Store.extend
  adapter: 'DS.FixtureAdapter'

App.Location = DS.Model.extend
  name: DS.attr('string'),
  lat:  DS.attr('number'),
  long: DS.attr('number'),
  seen: DS.attr('date'),
  # distance: (->
  #   lat1 = @get('lat')
  #   lat2 = @get('latty')
  #   distance = lat1 - lat2
  # ).property('lat','long')

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