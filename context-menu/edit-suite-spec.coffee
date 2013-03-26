describe 'edit suite spec', ->
    
    before (done)->
        $context.spec_url = 'http://google.com'
        setup_for_suite $context, 'Specification', ->
            set_spec( $context.suite_path, $context.spec_url, "" )
            done()
            
    after ->
        delete_folder( $context.suite_path )
    
    it 'should have appropriate target', ->
        expect( $context.target.text() ).string( $context.cwd )
        
    it 'should have appropriate context', ->
        expect( $context.target.attr('class') ).string( 'suite' )
        
    it 'should have appropriate action', ->
        expect( $context.action ).to.equal( '#editspec' )
        
    describe 'should open context for editing', ->
         
        before (done)->
            window.frames[0].ctxMenuActions.dispatcher( $context.action.substring(1), $context.target )
            $.when( frame.load() ).then ->
                $.waitFor.condition( -> frame.window().editor? ).then ->
                    done()
            
        it 'editor has appropriate content', ->
            expect( frame.window().editor.getValue() ).string( $context.spec_url )
            
        it 'breadcrumbs shows context.ini title', ->
            expect( _$($context.breadcrumbs_selector).text() ).string( $context.spec_ini )