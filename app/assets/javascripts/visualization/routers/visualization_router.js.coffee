Visualization.Routers.Router = Backbone.Router.extend

  routes:
    "visualization/:data_set_description" : "vis"

  vis: ->
    Visualization.Objects.control_panel_model = new Visualization.Models.ControlPanel()
    Visualization.Objects.control_panel_view = new Visualization.Views.ControlPanel
      model: Visualization.Objects.control_panel_model
    
    console.log "vis route"
    console.log arguments

