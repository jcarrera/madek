Visualization.Routers.Router = Backbone.Router.extend

  routes:
    "visualization/:data_set_description" : "vis"

  vis: ->
    Visualization.Objects.control_panel_model = new Visualization.Models.ControlPanel
      edge_length: 100
      component_separation: 5
      node_radius: 5
      max_set_radius: 25

    Visualization.Objects.control_panel_view = new Visualization.Views.ControlPanel
      model: Visualization.Objects.control_panel_model
    
    console.log "vis route"
    console.log arguments

