describe 'edit suite context', ->
    
    before (done)->
        $context.suite_path = create_folder($context.cwd, $context._root_)
        set_context( $context.suite_path, "[#{$context.ctx_name}]" )
        $.when( frame.go( $context._root_ ) ).then ->
            $context.target = _$( ".dir-index ul li:contains('#{$context.cwd}')" )
            $context.action = _$( "#{$context.menu_locator} a:contains('Context')" ).attr('href')
            done()
            
    after ->
        delete_folder( $context.suite_path )
    
    it 'should have appropriate href', ->
        expect( $context.target.text() ).string( $context.cwd )
        
    it 'should have appropriate action', ->
        expect( $context.action ).to.equal( '#editctx' )
        
    describe 'should open context for editing', ->
         
        before (done)->
            window.frames[0].ctxMenuActions.dispatcher( $context.action.substring(1), $context.target )
            $.when( frame.load() ).then ->
                $.waitFor.condition( -> frame.window().editor? ).then ->
                    done()
            
        it 'editor has appropriate content', ->
            expect( frame.window().editor.getValue() ).to.equal( "[#{$context.ctx_name}]" )
            
        it 'breadcrumbs shows context.ini title', ->
            expect( _$($context.breadcrumbs_selector).text() ).string( $context.ctx_ini )