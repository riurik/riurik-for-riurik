describe 'for suite', ->

    before (done)->
        $context.number_of_items = 5
        $context.menu_locator = '#dir-index-menu li'
        $context.suite_path = "#{$context._root_}/#{$context.cws}/first-suite"
        set_context( $context.suite_path, "[#{$context.cws}]" )
        $.when( frame.go( $context.suite_path ) ).then ->
            done()
            
    after ->
        delete_folder( $context.suite_path )
      
    describe 'should have appropriate menu items for each action', ->
        
        it "number of menu items", ->
            expect( _$( "#{$context.menu_locator}" ).length ).to.equal( $context.number_of_items )
            
        it 'Edit context', ->
            expect( _$("#{$context.menu_locator} a:contains('Context')") ).to.have.attr( 'href', '#editctx' )
            
        it 'Edit specification', ->
            expect( _$("#{$context.menu_locator} a:contains('Specification')") ).to.have.attr( 'href', '#editspec' )
            
        it 'Remove a suite or a test', ->
            expect( _$("#{$context.menu_locator} a:contains('Delete')") ).to.have.attr( 'href', '#remove' )
            
        it 'Rename a suite or a test', ->
            expect( _$("#{$context.menu_locator} a:contains('Rename')") ).to.have.attr( 'href', '#rename' )
            
        it 'Execute a suite or a test', ->
            expect( _$("#{$context.menu_locator} a:contains('Run')") ).to.have.attr('href', '#run' )
    
    describe 'Edit context should open context for editing', ->
        
        before.skip (done)->
            target = _$( "#{$context.menu_locator} a:contains('Context')" )
            action = target.attr('href').substring(1)
            window.frames[0].ctxMenuActions.dispatcher(action, target)
            $.when( frame.load() ).then ->
                fwnd = frame.window()
                $.waitFor.condition( -> frame.window().editor? ).then ->
                console.log frame.window().editor.getValue()
                console.log _$('.CodeMirror-lines')
                done()
                
        it 'should be OK', ->
            expect( true ).to.be.ok