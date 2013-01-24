module 'suite view'

QUnit.asyncSetup ->
    create_folder(context.root, '/')
    $.when( frame.go "#{context.root}" ).then ->
        start()

test 'title should be name of the suite', ->
    equal frame.document().title, context.suite_for_testing
  
test 'control panel is available', ->
    ok _$('a#run-suite-btn').is(':visible'), 'Run suite button is visible'
    ok _$('a#context-preview-ctrl').is(':visible'), 'Context button is visible'
    ok _$('a#spec-link').is(':visible'), 'Spec button is visible'
    ok _$('a#new-test').is(':visible'), 'Create test button is visible'
  
QUnit.teardown ->
    delete_folder context.root