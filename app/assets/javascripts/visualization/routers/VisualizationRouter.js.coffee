Visualization.Routers.Router = Backbone.Router.extend

  routes:
    "visualization/:data_set_description" : "vis"

  vis: ->
    console.log "vis route"
    console.log arguments

