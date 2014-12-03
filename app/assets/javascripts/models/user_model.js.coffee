ZodiacMini.User = DS.Model.extend
  email:                 DS.attr('string')
  birthday:              DS.attr('string')
  password:              DS.attr('string')
  password_confirmation: DS.attr('string')
