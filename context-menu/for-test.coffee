module 'context menu inside suite'

QUnit.asyncSetup ->
  using context, ->
    @menu_locator = '#dir-index-menu li'
    @suite_path = "#{@root}/#{@cws}/first-suite"
    set_context(@suite_path, "[#{@cws}]")
    $.when( frame.go( @suite_path ) ).then ->
      start()
      
test 'should have appropriate actions', ->
  using context, ->
    equal _$("#{@menu_locator}").length, 6, 'there are context menu items'
    equal _$("#{@menu_locator} a:contains('Context')").attr('href'), '#editctx', 'Edit context'
    equal _$("#{@menu_locator} a:contains('Specification')").attr('href'), '#editspec', 'Edit specification'
    equal _$("#{@menu_locator} a:contains('Delete')").attr('href'), '#remove', 'Remove a suite or a test'
    equal _$("#{@menu_locator} a:contains('Rename')").attr('href'), '#rename', 'Rename a suite or a test'
    equal _$("#{@menu_locator} a:contains('Move')").attr('href'), '#move', 'Move a suite or a test'
    equal _$("#{@menu_locator} a:contains('Run')").attr('href'), '#run', 'Execute a suite or a test'
    
asyncTest 'Edit context should open context for editing', ->
  $.when( frame.go( context.suite_path ) ).then ->
    target = _$("#{context.menu_locator} a:contains('Context')")
    action = target.attr('href').substring(1)
    window.frames[0].ctxMenuActions.dispatcher(action, target)
    $.when( frame.load() ).then ->
      fwnd = frame.window()
      $.waitFor.condition( -> frame.window().editor? ).then ->
        console.log frame.window().editor.getValue()
        console.log _$('.CodeMirror-lines')
        start()