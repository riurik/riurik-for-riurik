describe 'run test', ->
    
    before (done)->
        setup_for_test $context, 'Run', ->
            $context.selector = _$('#context-action')
            done()
            
    after ->
        delete_folder( $context.suite_path )
        
    it 'should have appropriate target', ->
        expect( $context.target.text() ).string( $context.test_name )

    it 'should have appropriate context', ->
        expect( $context.target.attr('class') ).string( 'test' )

    it 'should have appropriate action', ->
        expect( $context.action ).to.equal( '#run' )
        
    describe 'should execute given test', ->
         
        before (done)->
            $context.selector.submit ->
                $context.selector.unbind( 'submit' )
                done()
                return false
            click_context_menu $context.action.substring(1), $context.target
            
        it 'should execute the test in new window', ->
            expect( $context.selector.attr('target') ).string( '_blank' )
            
        it 'test path should be set as the path variable', ->
            expect( _$('#context-action > input[name=path]').val() ).string( "#{$context.test_path}".replace(/^\/*/, '') )
            
        it 'suite path should be set as the url variable', ->
            expect( _$('#context-action > input[name=url]').val() ).string( "#{$context.suite_path}".replace(/^\/*/, '') )
            
        it 'context name should be set as the context variable', ->
            expect( _$('#context-action > input[name=context]').val() ).string( $context.ctx_name )
            
        it 'the action value should correspond to the test execution url', ->
            expect( $context.selector.attr('action' ) ).string( '/actions/test/run/' )
            
        it 'test should be successfully executed', (done)->
            $context.selector.attr('target', '')
            $context.selector.submit()
            $.when( frame.load() ).then ->
                $.waitFor.condition( frameTestsAreDone ).then ->
                    expect( _$('.test-name') ).text( $context.test_name )
                    done()