d3.layout.mds= ->

  n = m = null
  needs_initialization = true
  nodes = []
  links = []
  link_distance = 100
  index_id_map = {}
  id_index_map = {}
  A = []
  D = []

  event = d3.dispatch("tick", "initalization_done", "iteration_start", "iteration_end")


  create_empty_nx0 = (n)->
    A=[]
    for i in [0 .. n-1]
      A[i] = []
    A

  clone_2d_array = (A) ->
    B=[]
    for i in [0 .. A.length-1]
      B[i]= A[i].slice 0
    B

  floyd_warshall = (A) ->
    D = clone_2d_array A
    for k in [0 .. n-1]
      for i in [1 .. n-1]
        for j in [0 .. i-1]
          if j < k < i  
            D[i][j] = Math.min D[i][j], D[i][k] + D[k][j] 
    D


  replace_infinite_values = (A) ->
    D = clone_2d_array A
    max_dist = 0
    for i in [1 .. n-1]
      for j in [0 .. i-1]
        max_dist = Math.max max_dist, D[i][j] if isFinite(D[i][j])
    max_dist = max_dist + max_dist * 1/3
    for i in [1 .. n-1]
      for j in [0 .. i-1]
        D[i][j] = max_dist if not isFinite(D[i][j])
    D

  set_initial_coordinates_if_not_present = ->

    d = Math.ceil(Math.sqrt(n)) 

    for k in [0 .. n-1]
      i = k % d
      j = Math.floor(k / d)
      n = nodes[k]
      n.x = i unless n.x?
      n.y = j unless n.y?
 

  initialize = ->
    # once done remove A completely, it is essentially for prototyping/debugging
    n = nodes.length
    m = links.length
    A = create_empty_nx0 n
    for i in [0..n-1]
      id_index_map[nodes[i].id] = i 
      index_id_map[i]=nodes[i].id

    for i in [1..n-1]
      for j in [0..i-1]
        A[i][j]= Number.POSITIVE_INFINITY
   
    for link in links
      i = Math.max id_index_map[link.source.id], id_index_map[link.target.id]
      j = Math.min id_index_map[link.source.id], id_index_map[link.target.id]
      A[i][j] = if typeof link_distance is 'number' then link_distance else link_distance(link)
    
    needs_initialization = false

    D = floyd_warshall A

    D = replace_infinite_values D

    set_initial_coordinates_if_not_present()

    event.initalization_done()

  layout = ->

 
  mds = 
    nodes: (x)-> if x? then nodes = x; needs_initialization=true; mds else nodes
    links: (x)-> if x? then links = x; needs_initialization=true; mds else links 
    link_distance: (x)-> if x? then link_distance = x; needs_initialization=true; mds else link_distance

    tick: () ->
      initialize() if needs_initialization
      debugger
      # compute layout here
      layout()
      event.tick()

    start: ->
    stop: ->


  d3.rebind(mds,event,"on")


