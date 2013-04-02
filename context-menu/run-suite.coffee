describe 'run suite', ->
    
    before (done)->
        setup_for_suite $context, 'Run', ->
            done()
            
    after ->
        delete_folder( $context.suite_path )
        
    it 'should be disabled', ->
        expect( false ).ok