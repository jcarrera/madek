d3.layout.mds= ->

  n = m = null
  nodes = []
  links = []
  link_distance = 100
  index_id_map = {}
  id_index_map = {}
  A = []

  event = d3.dispatch("start", "tick", "end")


  create_empty_nxn = (n)->
    A=[]
    for i = [0 .. n-1]
      A[i] = []
    A

  initialize = ->
    n = nodes.length
    m = links.length
    A = create_empty_nxn n
    for i in [0..n-1]
      id_index_map[nodes[i].id] = i 
      index_id_map[i]=nodes[i].id

    for i in [0..n-1]
      A[i][i] = 0
      for j in [i..n-1]
        if i isnt j then A[i][j]=A[j][i]= Number.POSITIVE_INFINITY
    
    for link in links
      A[id_index_map[link.source.id]][id_index_map[link.target.id]] = link_distance
      A[id_index_map[link.target.id]][id_index_map[link.source.id]] = link_distance


  clone_2_darray = (A) ->
    B=[]
    for i in [0 .. A.length -1]
      B[i]=[]
      for j in [0 .. B.length -1]
        B[i][j] = A[i][j]
    B

  floyd_warshall_apsp = (D_) ->
    D = clone_2_darray D_
    for k in [0 .. n-1]
      for i in [0 .. n-1]
        for j in [0 .. n-1]
          D[i][j] = Math.min D[i][j], D[i][k] + D[k][j]
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


