module 'context view - editor with .context.ini file'

QUnit.setup ->
    create_folder(context.root, '/')

asyncTest 'control panel is available', ->
    $.when( frame.go "#{context.context_for_testing}?editor" ).then ->
        hmenu = _$( 'ul.horizontal-menu' )
        
        ok ! _$('a#run', hmenu).is(':visible'), 'Run button is NOT visible'
        ok ! _$('a#context-preview-ctrl', hmenu).is(':visible'), 'Context button is NOT visible'
        ok ! _$('a#spec-link', hmenu).is(':visible'), 'Spec button is not visible'
        ok _$('a#save', hmenu).is(':visible'), 'Save button is visible'
        ok _$('a#close', hmenu).is(':visible'), 'Close button is visible'
        start()
    
QUnit.teardown ->
  delete_folder context.root
