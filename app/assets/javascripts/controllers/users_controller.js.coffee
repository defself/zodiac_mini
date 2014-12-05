ZodiacMini.UsersNewController = Ember.ObjectController.extend
  actions:
    createUser: (user) ->
      self = this
      onSuccess = (user) ->
        self.transitionToRoute "users.show", id: user.id

      onFail = (user) ->
        alert "Sign up failed"

      @store.createRecord("user", user).save().then(onSuccess, onFail)

ZodiacMini.UsersShowController = Ember.ObjectController.extend
  actions:
    horoscope: (userId, type) ->
      onSuccess = (horoscope) ->
        forecast = horoscope.content[0].get("forecast")
        $("##{type}").html(forecast)
        $(document).foundation "equalizer", "reflow"

      onFail = (horoscope) ->
        alert "Forecast for #{type} wasn't found"

      @store.find("horoscope", { user_id: userId, type: type }).then(onSuccess, onFail)

    logOut: (id) ->
      self = this
      onSuccess = (session) ->
        self.transitionToRoute "sessions.new"

      onFail = (session) ->
        alert "Log out failed"

      @store.find("session", id).then( (session) ->
        session.destroyRecord().then(onSuccess, onFail)
      )
