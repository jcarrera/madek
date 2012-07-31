d3.layout.mds= ->

  nodes = []
  links = []

  n = m = null

  link_distance = 100

  index_id_map = {}
  id_index_map = {}

  A = []

  event = d3.dispatch("start", "tick", "end")


  initialize = ->
    A=[]
    n = nodes.length
    m = links.length
    for i in [0..n-1]
      id_index_map[nodes[i].id] = i 
      index_id_map[i]=nodes[i].id
      A[i]=[]

    for i in [0..n-1]
      A[i][i] = 0
      for j in [i..n-1]
        if i isnt j then A[i][j]=A[j][i]= Number.POSITIVE_INFINITY
    
    for link in links
      A[id_index_map[link.source.id]][id_index_map[link.target.id]] = link_distance
      A[id_index_map[link.target.id]][id_index_map[link.source.id]] = link_distance



  mds = 
    nodes: (x)-> if x? then nodes = x; mds else nodes
    links: (x)-> if x? then links = x; mds else links 
    link_distance: (x)-> if x? then link_distance = x; mds else link_distance

    start: () ->
      event.start()
      initialize()

      debugger
      # now use Dijkstra e.g. to compute D
      # http://jsclass.jcoglan.com/set.html
      # http://mcc.id.au/2004/10/dijkstra.js
      #
       
      mds

  d3.rebind(mds,event,"on")


