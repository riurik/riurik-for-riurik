module 'errors handling'

test_content = '''
module 'module'
asyncTest 'first test', ->
  ok true, 'ok'
'''

QUnit.setup ->
  using context, ->
    create_folder(@root, '/')
    @suite_path = "#{@root}"
    @test1_path = "#{@suite_path}/first-test.coffee"
    @suite_context = 'reporting'
    @url = $.URI(context, "actions/suite/run/?path=/#{@suite_path}&context=#{@suite_context}")
    
    set_context(@suite_path, "[#{@suite_context}]")
    write_test(@test1_path, test_content)
    
    purge( @suite_context, @suite_path )
   
asyncTest 'suite is started should be reported', ->
  $.when( frame.go(context.url) ).then ->
    $.waitFor.condition ->
      suite_started( context.suite_context, context.suite_path )
    .then ->
      sinon.stub frame.window().jQuery, "ajax", ->
        frame.window().jQuery.ajax.restore()
        setTimeout(start, 1)
        throw "Artificial exception to test reporting errors handling"
      
      frame.window().start()

asyncTest 'suite is done should be reported', ->
  $.waitFor.condition ->
    suite_done( context.suite_context, context.suite_path )
  .then ->
    start()

QUnit.teardown ->
  delete_folder context.root