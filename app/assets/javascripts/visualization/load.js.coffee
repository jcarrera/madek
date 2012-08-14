#= require_self
#= require_tree ./d3
#= require_tree ./functions
#= require_tree ./modules
#= require_tree ./templates
#= require_tree ./models
#= require_tree ./views
#= require_tree ./routers

window.Visualization =
  Collections: {}
  Data: {}
  Functions: {}
  Models: {}
  Modules: {}
  Objects: {}
  Routers: {}
  Views: {}
  State: {}

window.Visualization.init = ->

  # graph datastructure
  graph = Visualization.Data.graph = {}
  state = Visualization.State
  graph.nodes = nodes =  {}
 
  graph.arcs= arcs = []
  $("#graph-data").data("nodes").forEach (n)->
    n.children = []
    n.parents = []
    nodes[n.id] = n
  $("#graph-data").data("arcs").forEach (arc)->
    arc.source = nodes[arc.parent_id]
    arc.target = nodes[arc.child_id]
    arcs.push arc
    nodes[arc.parent_id].children.push arc.child_id
    nodes[arc.child_id].parents.push arc.parent_id

  svg = data.svg = d3.select("#visualization").append("svg:svg").attr("width", 800).attr("height", 800).attr('id','drawing')

  svg_height = ->
    $("#visualization svg").attr("height")
  svg_width = ->
    $("#visualization svg").attr("width")

  layouter = Visualization.Objects.layouter = d3.layout.mds()

  layouter.nodes(d3.values(nodes)).links(arcs)

  graph = svg.append("svg:g").attr("id","graph")

  nodes_vis= graph.selectAll("circle.node")
    .data(layouter.nodes()).enter().append("circle").attr("class",(n)->"node #{n.type}").attr("r",10).attr("id",(n)->"resource-#{n.id}")

  layouter.on "initalization_done", ->
    console.log "mds-layouter initalization_done"
    console.log "current stress #{layouter.stress()}"

  iteration_count = 0

  layouter.on "iteration_end", (stress_improvement) ->
    console.log "mds-layouter iteration_end #{++iteration_count}"
    console.log "current stress #{layouter.stress()}"
    console.log "stress_improvement #{stress_improvement}"

    if stress_improvement > 0.03
      setTimeout(layouter.iterate,0)
    else
      nodes_vis.attr("cx",(n)->n.x).attr("cy",(n)->n.y)
      bbox = state.bbox = Visualization.Functions.bbox  $("#drawing .node")
      bbox_center = state.bbox_center= Visualization.Functions.center_of_box bbox
      graph.select("rect#bbox").remove()
      graph.append("svg:rect").attr("id","bbox").attr("x",bbox[0]).attr("y",bbox[1]).attr("width",bbox[2]-bbox[0]).attr("height",bbox[3]-bbox[1])
      graph.append("svg:circle").attr("id","center").attr("r",2).attr("cx",bbox_center[0]).attr("cy",bbox_center[1])
      scale = state.scale  =  Math.min(svg_width() / (bbox[2] - bbox[0]), svg_height() / (bbox[3] - bbox[1]))
      scaled_bbox_center = bbox_center.map( (x)-> x * scale)
      tx = state.tx =  svg_width()/2 - scaled_bbox_center[0] 
      ty = state.ty = svg_height()/2 - scaled_bbox_center[1] 
      graph.attr("transform","translate(#{tx},#{ty}) scale(#{scale},#{scale}) ")  

  layouter.iterate()

