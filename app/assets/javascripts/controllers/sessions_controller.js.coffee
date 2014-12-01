ZodiacMini.SessionsNewController = Ember.ObjectController.extend(
  actions:
    submit: (session) ->
      self = this
      onSuccess = (session) ->
        self.transitionToRoute "users.show", id: session.id
      onFail = (session) ->
        alert "Login failed"

      @store.createRecord("session", session).save().then(onSuccess, onFail)
)
