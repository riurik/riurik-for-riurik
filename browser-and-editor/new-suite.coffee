module 'new suite'

QUnit.asyncSetup ->
    create_folder(context.root, '/')
    $.when( frame.go( context.root ) ).then ->
        start()
        
test 'title should be name of the suite', ->
    equal frame.document().title, context.root
  
test 'should be possible to create folder or script', ->
    hmenu = _$( 'ul.horizontal-menu' )
    ok _$( 'a#new-suite', hmenu ).length > 0, 'create suite'
    ok _$( 'a#new-test', hmenu ).length > 0, 'create test'
    ok ! _$('a#run', hmenu).is(':visible'), 'Run button is NOT visible'
        
QUnit.teardown ->
    delete_folder context.root