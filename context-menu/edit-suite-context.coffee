describe 'edit suite context', ->
    
    before (done)->
        setup_for_suite $context, 'Context', ->
            done()
            
    after ->
        delete_folder( $context.suite_path )
    
    it 'should have appropriate target', ->
        expect( $context.target.text() ).string( $context.cwd )
        
    it 'should have appropriate context', ->
        expect( $context.target.attr('class') ).string( 'suite' )
        
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