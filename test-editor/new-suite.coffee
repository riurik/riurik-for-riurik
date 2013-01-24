module 'edit test without context'

QUnit.setup ->
    create_folder(context.root, '/')
    context.suite_name = 'new-suite'
    context.suite_path = context.root.concat('/', context.suite_name)
    context.test_name = 'new-test.js'
    context.test_path = context.suite_path.concat('/', context.test_name)
    
    create_folder(context.suite_name, context.root)
    create_test(context.test_name, context.suite_path)

asyncTest 'should propose creating context', ->
    $.when( frame.go( context.test_path + '?editor' ) ).then ->
        equal( _$('#create-context').text().trim(), 'Create context' )
        equal( _$('#create-context').attr('title').trim(), 'To execute the test you have to define cotext' )
    
        start()
        
QUnit.teardown ->
  delete_folder context.root