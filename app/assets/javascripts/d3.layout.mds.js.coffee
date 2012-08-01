d3.layout.mds= ->

  n = m = null
  nodes = []
  links = []
  link_distance = 100
  index_id_map = {}
  id_index_map = {}
  A = []

  event = d3.dispatch("start", "tick", "end")


  create_empty_nx0 = (n)->
    A=[]
    for i in [0 .. n-1]
      A[i] = []
    A

  initialize = ->
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
      i = Math.min id_index_map[link.source.id], id_index_map[link.target.id]
      j = Math.max id_index_map[link.source.id], id_index_map[link.target.id]
      A[i][j] = link_distance


  clone_2d_array = (A) ->
    B=[]
    for i in [0 .. A.length-1]
      B[i]= A[i].slice 0
    B

  floyd_warshall_apsp = (A) ->
    D = clone_2d_array A
    for k in [0 .. n-1]
      for i in [1 .. n-1]
        for j in [0 .. i-1]
          D[i][j] = Math.min D[i][j], D[i][k] + D[k][j] if k < i and k > j # check these conditions here
    D


  mds = 
    nodes: (x)-> if x? then nodes = x; mds else nodes
    links: (x)-> if x? then links = x; mds else links 
    link_distance: (x)-> if x? then link_distance = x; mds else link_distance

    start: () ->
      event.start()
      initialize()
      D = floyd_warshall_apsp A

      # test floyd_warshall_apsp
      debugger
        
      mds

  d3.rebind(mds,event,"on")


