Visualization.Functions.bbox = (svg_elements) ->
  _.chain(svg_elements)
    .map((e)-> e.getBBox())
    .reduce(
      ((A,rect)->[Math.min(A[0],rect.x),Math.min(A[1],rect.y),Math.max(A[2],rect.x+rect.width),Math.max(A[3],rect.y+rect.height)])
      ,[Number.MAX_VALUE,Number.MAX_VALUE,Number.MIN_VALUE,Number.MIN_VALUE])
    .value()



