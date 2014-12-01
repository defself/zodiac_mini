ZodiacMini.SignUpFormComponent = Ember.Component.extend(
  actions:
    submit: ->
      @sendAction "submit",
        email:    @get("email")
        birthday: @get("birthday")
        password: @get("password")
        password_confirmation: @get("password_confirmation")

    cancel: ->
      @sendAction "cancel"
)

ZodiacMini.SignInFormComponent = Ember.Component.extend(
  actions:
    submit: ->
      @sendAction "submit",
        email:    @get("email")
        password: @get("password")
)
