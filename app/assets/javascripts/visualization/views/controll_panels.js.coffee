Visualization.Views.ControlPanel = Backbone.View.extend

  template: """
    <h1>Controls</h1>
    <form>

    <label>Edge Length: <span id="edge_length_value"></span></label>
    <div id="edge_length"></div>

    <label>Default Resource Radius: <span id="node_radius_value"></span></label>
    <div id="node_radius"></div>

    <label>Maximal Set Radius: <span id="max_set_radius_value"></span></label>
    <div id="max_set_radius"></div>
    </form>
  """

  initialize: ->
    @el =  $("#controls")
    @render()
    $("#edge_length").slider
      min: 10
      step: 10
      value: 100
      max: 200
      slide: (event,ui) ->
        $("#edge_length_value").html(ui.value)
      stop: (event,ui) ->
        console.log "stop edge_length #{ui.value}"

    $("#node_radius").slider
      min: 5
      step: 5
      value: 5
      max: 50
      slide: (event,ui) ->
        $("#node_radius_value").html(ui.value)

    $("#max_set_radius").slider
      min: 5
      step: 5
      value: 25
      max: 50
      slide: (event,ui) ->
        $("#max_set_radius_value").html(ui.value)

  render: ->
    $(@el).html @template

