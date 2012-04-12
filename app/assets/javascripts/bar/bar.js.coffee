###

  Bar
  
  This script provides functionalities for the bar

###

class Bar
  
  @setup = (type, permission, sort_by, laoyy)->
    $("#bar .selection .types ."+type).addClass("active").addClass("current")
    $("#bar .permissions ."+permission).addClass("active")
    $("#bar .sort ."+sort_by).addClass("active")
    $("#bar .sort").prepend $("#bar .sort ."+sort_by)
    $("#bar .layout a:first").addClass "active"
    
    $("#bar .selection .types a").bind "mouseenter", ()->
      $(this).closest(".types").find(".active").removeClass("active")
      $(this).addClass("active")
      Bar.set_href_selection_for $(this) 
      
    $("#bar .selection").bind "mouseleave", ()->
      $(this).find(".types .active").removeClass("active")
      $(this).find(".types .current").addClass("active")
      Bar.set_href_selection_for $(this).find(".types .current")

  @set_href_selection_for = (active_element)->
    active_type = $(active_element).data "type"
    $("#bar .selection .permissions a").each (i, current_element)->
      href = $(current_element).attr("href")
      console.log "----"
      console.log href
      if href.match("type=")
        href = href.replace(/type=(\w+|\w?)/, "type="+active_type)
      else
        href = href+"&type="+active_type
      $(current_element).attr("href", href)
      console.log $(current_element).attr("href")
  
window.Bar = Bar