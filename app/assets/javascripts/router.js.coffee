# For more information see: http://emberjs.com/guides/routing/

ZodiacMini.Router.map () ->
  @resource 'users', ->
    @route 'new'
    @route 'show', path: ":id"
  @resource 'sessions', ->
    @route 'new'

ZodiacMini.Router.reopen
  location: 'history'

ZodiacMini.UsersIndexRoute = Ember.Route.extend
  setupController: (controller, model) ->
    users = @store.find 'user'
    controller.set "content", users

ZodiacMini.UsersShowRoute = Ember.Route.extend
  model: (params)->
    { id: params.id }
  setupController: (controller, model) ->
    self = this
    userModel = @store.find('user', model.id).then( (user) ->
      self.store.find("horoscope", { type: "today", user_id: user.id }).then( (horoscope) ->
        forecast = horoscope.content[0].get("forecast")
        $("#today").html(forecast)
      )
      controller.set "content", user
    )
