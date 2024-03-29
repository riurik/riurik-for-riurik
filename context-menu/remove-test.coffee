describe 'remove test', ->
    
    before (done)->
        setup_for_test $context, 'Delete', ->
            done()
            
    after ->
        delete_folder( $context.suite_path )
        
    it 'should have appropriate target', ->
        expect( $context.target.text() ).string( $context.test_name )

    it 'should have appropriate context', ->
        expect( $context.target.attr('class') ).string( 'test' )

    it 'should have appropriate action', ->
        expect( $context.action ).to.equal( '#remove' )
        
    describe 'should remove given test', ->
         
        before (done)->
            $context.confirmStub = sinon.stub frame.window(), "confirm"
            $context.confirmStub.returns( true )
            click_context_menu_frame_load $context.action.substring(1), $context.target, ->
                done()
            
        it 'should ask if you sure to delete the test', ->
            expect( $context.confirmStub.calledOnce )
            $context.confirmStub.restore()
            
        it 'the test should be removed', ->
            expect( _$( ".dir-index ul li:contains('#{$context.test_name}')" ) ).length(0)
