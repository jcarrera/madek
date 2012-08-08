#= require_self
#= require_tree ./functions
#= require_tree ./modules
#= require_tree ./templates
#= require_tree ./models
#= require_tree ./views
#= require_tree ./routers

window.Visualization =
  Collections: {}
  Functions: {}
  Models: {}
  Modules: {}
  Routers: {}
  Views: {}

window.Visualization.init = ->
  window.Visualization.router = new Visualization.Routers.Router();
  Backbone.history.start({pushState: true, root: "/visualization/"})

