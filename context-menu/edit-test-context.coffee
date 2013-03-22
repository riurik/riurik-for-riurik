describe 'edit context', ->
    
    before (done)->
        $context.test_name = 'new-test.js'
        $context.suite_path = create_folder($context.cwd, $context._root_)
        $context.test_path = create_test( $context.test_name, $context.suite_path )
        set_context( $context.suite_path, "[#{$context.cws}]" )
        $.when( frame.go( $context.suite_path ) ).then ->
            $context.target = _$( ".dir-index ul:contains('new-test.js')" )
            $context.action = _$( "#{$context.menu_locator} a:contains('Context')" ).attr('href')
            done()
            
    after ->
        delete_folder( $context.suite_path )
    
    it 'should have appropriate href', ->
        expect( $context.target.text() ).string( $context.test_name )
        
    it 'should have appropriate action', ->
        expect( $context.action ).to.equal( '#editctx' )
        
     describe 'should open context for editing', ->
         
        before (done)->
            window.frames[0].ctxMenuActions.dispatcher( $context.action.substring(1), $context.target )
            $.when( frame.load() ).then ->
                $.waitFor.condition( -> frame.window().editor? ).then ->
                    done()
            
        it 'editor has appropriate content', ->
            expect( frame.window().editor.getValue() ).to.equal( "[#{$context.cws}]" )
            
        it 'breadcrumbs shows context.ini title', ->
            expect( _$($context.breadcrumbs_selector).text() ).string( $context.ctx_ini )