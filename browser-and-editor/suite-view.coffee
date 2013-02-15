module 'suite view'

QUnit.asyncSetup ->
    $context.suite_name = 'browser-and-editor'
    $.when( frame.go get_current_suite() ).then ->
        start()

test 'title should be name of the suite', ->
    equal frame.document().title, $context.suite_name
  
test 'control panel is available', ->
    hmenu = _$( 'ul.horizontal-menu' )
    ok _$('a#run-suite-btn', hmenu).is(':visible'), 'Run suite button is visible'
    ok _$('a#history', hmenu).is(':visible'), 'Run suite button is visible'
    ok _$('a#context-preview-ctrl', hmenu).is(':visible'), 'Context button is visible'
    ok _$('a#spec-link', hmenu).is(':visible'), 'Spec button is visible'
    ok _$('a#new-test', hmenu).is(':visible'), 'Create test button is visible'