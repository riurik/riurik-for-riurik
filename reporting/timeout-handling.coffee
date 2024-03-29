module 'timeout handling'

test_content = '''
module 'module'
asyncTest 'first test', ->
  ok true, 'ok'
'''

QUnit.setup ->
  using context, ->
    create_folder(context, @root, '/')
    @suite_path = "#{@root}"
    @test1_path = "#{@suite_path}/first-test.coffee"
    @suite_context = 'reporting'
    @url = $.URI(context, "actions/suite/run/?path=/#{@suite_path}&context=#{@suite_context}")
    context.start_time = ''
    
    set_context(@suite_path, "[#{@suite_context}]\nlibraries=sinon.js")
    write_test(@test1_path, test_content)
    
    purge( @suite_context, @suite_path )
   
asyncTest 'suite is started should be reported', ->
  $.when( frame.go(context.url) ).then ->
    $.waitFor.condition ->
      suite_started( context.suite_context, context.suite_path, context.start_time )
    .then ->
        start()
        
asyncTest 'suite is done should be reported', ->
    sinon.stub frame.window().jQuery, "ajax", ->
        frame.window().jQuery.ajax.restore()
        clock = frame.window().sinon.useFakeTimers()
        clock.tick(60*1000+1)
        clock.restore()
        $.waitFor.condition ->
            suite_done( context.suite_context, context.suite_path, context.start_time )
        .then ->
            #clock.restore()
            start()
      
    frame.window().start()

QUnit.teardown ->
  delete_folder context, context.root