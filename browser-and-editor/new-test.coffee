module 'new test'

QUnit.setup ->
    $context.cwd_path = create_folder( $context.cwd, $context._root_ )
    $context.suite_path = create_folder( 'new-suite', $context.cwd_path )
    $context.test_path = create_test( 'new-test.js', $context.suite_path )

asyncTest 'should propose creating context', ->
    $.when( frame.go( $context.test_path + '?editor' ) ).then ->
        ok( not _$('a#run').is(':visible'), 'Run test button should not be visible' );
        equal( _$('#create-context').text().trim(), 'Create context' )
        equal( _$('#create-context').attr('title').trim(), 'To execute the test you have to define cotext' )
        
        ok( _$('a#spec-link').is(':visible'), 'Spec button is visible' );
        ok( _$('a#save').is(':visible'), 'Save button is visible' );
        ok( _$('a#close').is(':visible'), 'Close button is visible' );
    
        start()
        
QUnit.teardown ->
  delete_folder $context.cwd_path