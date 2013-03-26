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
