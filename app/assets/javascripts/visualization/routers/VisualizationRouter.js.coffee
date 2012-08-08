window.Visualization.Routers.Router = Backbone.Router.extend

  routes:
    "" : "root" 
    ":graph": "graph"
    ":graph/*": "rest"

  root: ->
    console.log "root route"
    console.log arguments
    @navigate "my_sets_and_direct_descendants/", {trigger: true}


  graph: -> 
    console.log "graph route"
    console.log arguments

  reset: -> 
    console.log "rest route"
    console.log arguments



  

