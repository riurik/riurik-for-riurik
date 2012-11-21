suite_started = (context_name, suite_path)->
  suite_status( context_name, suite_path, (status)-> status != 'undefined' )
  
suite_done = (context_name, suite_path)->
  suite_status( context_name, suite_path, (status)-> status == 'done' )
  
suite_status = (context_name, suite_path, check) ->  
  status = get_status context_name, suite_path
  if check(status)
    $.pass( "suite is #{status}" )
    return true
  else
    return false

get_status = (context_name, suite_path)->
  $.ajax({
    type: 'GET',
    async: false,
    dataType: 'json',
    url: $.URI(context, "report/status?context=#{context_name}&path=#{suite_path}"),
    success: (data)->
      context.suite_status = data.status
    ,
    error: (data)->
      $.fail()
  })
  
  return context.suite_status
  
purge = (context_name, suite_path)->
  $.ajax({
    type: 'GET',
    async: false,
    url: $.URI(context, "report/purge?context=#{context_name}&path=#{suite_path}"),
    success: (data)->
      $.pass()
    ,
    error: (data)->
      $.fail()
  })
  
  return context.suite_status