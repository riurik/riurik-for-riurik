describe 'rename test', ->
    
    before (done)->
        setup_for_test $context, 'Rename', ->
            done()
            
    after ->
        delete_folder( $context.suite_path )
        
    it 'should have appropriate target', ->
        expect( $context.target.text() ).string( $context.test_name )

    it 'should have appropriate context', ->
        expect( $context.target.attr('class') ).string( 'test' )

    it 'should have appropriate action', ->
        expect( $context.action ).to.equal( '#rename' )
        
    describe 'should rename given test', ->
         
        before (done)->
            click_context_menu $context.action.substring(1), $context.target
            $.waitFor.condition( -> _$('#create-dir-index-dialog').is(":visible") ).then ->
                done()
            
        it 'the Rename dialog should be shown', ->
            expect( _$('#ui-dialog-title-create-dir-index-dialog') ).text('Rename')
