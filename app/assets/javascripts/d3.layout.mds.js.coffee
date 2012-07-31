d3.layout.mds= ->

  nodes = {}
  links = {}

  event = d3.dispatch("start", "tick", "end")

  mds = 
    tick: ->

    nodes: (x)->
      nodes = x if x? 
      mds 
    links: (x)->
      links = x if x? 
      mds 
    start: () ->
      debugger
      mds


