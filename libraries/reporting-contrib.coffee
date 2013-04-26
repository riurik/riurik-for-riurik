suite_started = (context_name, suite_path, date)->
    suite_status( context_name, suite_path, date, (status)-> status != 'undefined' )
  
suite_done = (context_name, suite_path, date)->
    suite_status( context_name, suite_path, date, (status)-> status == 'done' )
  
suite_status = (context_name, suite_path, date, check) ->  
    status = get_status context_name, suite_path, date
    if check(status)
        return true
    else
        return false

get_status = (context_name, suite_path, date)->
    $.ajax({
        type: 'GET',
        async: false,
        dataType: 'json',
        url: $.FULL_URL( "report/status?context=#{context_name}&path=#{suite_path}&date=#{date}" ),
        success: (data)->
            $context.suite_status = data.status
        ,
        error: (data)->
            riurik.log('The get status operation is failed')
            $context.suite_status = 'undefined'
    })
  
    return $context.suite_status
  
purge = (context_name, suite_path)->
    $.ajax({
        type: 'GET',
        async: false,
        url: $.FULL_URL( "report/purge?context=#{context_name}&path=#{suite_path}" ),
        success: (data)->
            riurik.log('The purge operation is succeeded')
        ,
        error: (data)->
            riurik.log('The purge operation is failed')
    })
  
get_history = (context_name, suite_path)->
    date = frame.window().riurik.reporter.date
    history = null
  
    $.ajax({
        type: 'GET',
        async: false,
        dataType: 'json',
        url: $.FULL_URL( "#{suite_path}?history=#{date}&context=#{context_name}&json=true"),
        success: (data)->
            history = data.data
        ,
        error: (data)->
            riurik.log('The get history operation is failed')
            $context.suite_status = 'undefined'
    })
  
    return history