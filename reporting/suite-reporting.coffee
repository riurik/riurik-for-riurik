module 'suite reporting'

QUnit.setup ->
  using context, ->
    create_folder(@root, '/')
    @suite_path = "#{@root}"
    @test1_path = "#{@suite_path}/first-test.coffee"
    @test2_path = "#{@suite_path}/second-test.coffee"
    @test3_path = "#{@suite_path}/third-test.coffee"
    @suite_context = 'reporting'
    @url = $.URI(context, "actions/suite/run/?path=/#{@suite_path}&context=#{@suite_context}")
    
    set_context(@suite_path, "[#{@suite_context}]")
    write_test(@test1_path, "module 'module'\ntest 'first test', -> ok true, 'ok'")
    write_test(@test2_path, "module 'module'\ntest 'second test', -> ok true, 'ok'")
    write_test(@test3_path, "module 'module'\ntest 'third test', -> ok false, 'проверка на ошибку \u041e'")
    
    purge( @suite_context, @suite_path )
   
asyncTest 'suite is started should be reported', ->
  $.when( frame.go(context.url) ).then ->
    $.waitFor.condition ->
      suite_started( context.suite_context, context.suite_path )
    .then ->
      start()

asyncTest 'suite is done should be reported', ->
  $.waitFor.condition ->
    suite_done( context.suite_context, context.suite_path )
  .then ->
    start()

test 'suite history should be saved', ->
  history = get_history( context.suite_context, context.suite_path )
  equal history.length, 3
  
  equal history[0].name, 'module: third test'
  equal history[0].passed, "0"
  equal history[0].failed, "1"
    
get_history = (context_name, suite_path)->
  date = frame.window().riurik.reporter.date
  history = null
  
  $.ajax({
    type: 'GET',
    async: false,
    dataType: 'json',
    url: $.URI(context, "#{suite_path}?history=#{date}&context=#{context_name}&json=true"),
    success: (data)->
      history = data.data
    ,
    error: (data)->
      $.fail()
  })
  
  return history
      
QUnit.teardown ->
  delete_folder context.root