describe 'run suite', ->
    
    before (done)->
        setup_for_suite $context, 'Run', ->
            $context.alertStub = sinon.stub frame.window(), "alert"
            done()
            
    after ->
        delete_folder( $context.suite_path )
        
    it 'should have appropriate target', ->
        expect( $context.target.text() ).string( $context.cwd )

    it 'should have appropriate context', ->
        expect( $context.target.attr('class') ).string( 'suite' )

    it 'should have appropriate action', ->
        expect( $context.action ).to.equal( '#run' )
        
    it 'as the context is not available here yet an alert should be shown', ->
        click_context_menu $context.action.substring(1), $context.target
        expect( $context.alertStub.calledOnce )
        $context.alertStub.restore()
        
        