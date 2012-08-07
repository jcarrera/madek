window.Visualization.Routers.Router = Backbone.Router.extend(
  routes:
    "/*" : "root" 

  root: ->
    @navigate "my_sets_and_direct_descendants/", {trigger: true}

  
)
