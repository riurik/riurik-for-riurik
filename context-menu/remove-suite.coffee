describe 'remove suite', ->
    
    before (done)->
        setup_for_suite $context, 'Delete', ->
            done()
            
    it 'should have appropriate target', ->
        expect( $context.target.text() ).string( $context.cwd )
        
    it 'should have appropriate context', ->
        expect( $context.target.attr('class') ).string( 'suite' )
        
    it 'should have appropriate action', ->
        expect( $context.action ).to.equal( '#remove' )
        
    describe 'should remove given suite', ->
         
        before (done)->
            $context.confirmStub = sinon.stub frame.window(), "confirm"
            $context.confirmStub.returns( true )
            click_context_menu_frame_load $context.action.substring(1), $context.target, ->
                done()
                
        it 'should ask if you sure to delete the suite', ->
            expect( $context.confirmStub.calledOnce )
            $context.confirmStub.restore()
            
        it 'the test should be removed', ->
            expect( _$( ".dir-index ul li:contains('#{$context.cwd}')" ) ).length(0)