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
  Graph: {}
  Data: {}

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
    arcs.push arc
    nodes[arc.parent_id].children.push arc.child_id
    nodes[arc.child_id].parents.push arc.parent_id

  Visualization.Data.svg = svg = d3.select("#visualization").append("svg").attr("width", 600).attr("height", 600);


    




