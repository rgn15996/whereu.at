App = Ember.Application.create()

App.Router.map ->
  # put your routes here
  #@resource('index')

App.IndexRoute = Ember.Route.extend
  model: ->
    return ['red', 'yellow', 'blue']

App.IndexController = Ember.ObjectController.extend
  longitude: null
  latitude: null
  accuracy: null
  heading: null
  speed: null
  geo: null
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

# App.Location = Ember.Object.extend
#   longitude: 0
#   latitude: 0