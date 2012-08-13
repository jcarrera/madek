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
  Graph: {}
  Models: {}
  Modules: {}
  Objects: {}
  Routers: {}
  Views: {}

window.Visualization.init = ->

  # graph datastructure
  graph = Visualization.Graph
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

  Visualization.Data.svg = svg = d3.select("#visualization").append("svg").attr("width", 800).attr("height", 800);

  layouter = Visualization.Objects.layouter = d3.layout.mds()

  layouter.nodes(d3.values(nodes)).links(arcs)

  layouter.on "initalization_done", ->
    console.log "mds-layouter initalization_done"
    console.log "current stress #{layouter.stress()}"

  layouter.on "tick", ->
    console.log "mds-layouter tick"
    console.log "current stress #{layouter.stress()}"

  layouter.tick()

