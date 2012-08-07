window.Visualization.Routers.Router = Backbone.Router.extend(
  routes:
    "/*" : "root" 

  root: ->
    alert("RootRoute")
  
)
