module 'context view - editor with .context.ini file'

QUnit.setup ->
    create_folder(context.root, '/')

asyncTest 'control panel is available', ->
  $.when( frame.go "#{context.context_for_testing}?editor" ).then ->
    ok ! _$('a#run').is(':visible'), 'Run button is NOT visible'
    ok ! _$('a#context-preview-ctrl').is(':visible'), 'Context button is NOT visible'
    ok ! _$('a#spec-link').is(':visible'), 'Spec button is not visible'
    ok _$('a#save').is(':visible'), 'Save button is visible'
    ok _$('a#close').is(':visible'), 'Close button is visible'
    start()
    
QUnit.teardown ->
  delete_folder context.root
