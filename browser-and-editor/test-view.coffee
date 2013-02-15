module 'test view'

QUnit.asyncSetup ->
    current_test = "test-view.coffee"
    $.when( frame.go "#{get_current_suite()}/#{current_test}?editor" ).then ->
        start()
        
test 'control panel is available', ->
    hmenu = _$( 'ul.horizontal-menu' )
    ok _$('a#run', hmenu).is(':visible'), 'Run suite button is visible'
    ok _$('a#context-preview-ctrl', hmenu).is(':visible'), 'Context button is visible'
    ok _$('a#spec-link', hmenu).is(':visible'), 'Spec button is not visible'
    ok _$('a#save', hmenu).is(':visible'), 'Save button is visible'
    ok _$('a#close', hmenu).is(':visible'), 'Close button is visible'