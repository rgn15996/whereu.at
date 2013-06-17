App = Ember.Application.create()

App.Router.map ->
  # put your routes here

App.IndexRoute = Ember.Route.extend
  model: ->
    return ['red', 'yellow', 'blue']

  setupController: (controller, model) ->
    
    if (navigator.geolocation)
      console.log 'Apparently there is geolocation'
      navigator.geolocation.getCurrentPosition(controller.geoLocation, controller.noGeo)
      # @set('geo', true)
    else
      console.log 'No geolocation - bummer'
      # @set('geo', false)

App.IndexController = Ember.ObjectController.extend


  geoLocation: (location) ->

    # Ember.set(Index, 'latitude', location.coords.latitude)
    # @set('latitude', location.coords.latitude)
    # @set('longitude', locations.coords.longitude)
    # Ember.set(Index, 'longitude', location.coords.longitude)
    @set('latitude', location.coords.latitude)
    @set('longitude', location.coords.longitude)
    console.log 'I think I got a position'

  noGeo: (positionError) ->
    console.log 'noGeo: Oops!'
    console.log positionError.message
    @set('coords', positionError.message)
