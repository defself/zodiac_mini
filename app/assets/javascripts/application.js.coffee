#= require jquery
#= require foundation
#= require turbolinks
#= require handlebars
#= require ember
#= require ember-data
#= require_self
#= require zodiac_mini

->
  $(document).foundation()

# for more details see: http://emberjs.com/guides/application/
window.ZodiacMini = Ember.Application.create()
