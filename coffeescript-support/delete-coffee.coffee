describe 'removing coffee script', ->

    before ->
        $context.suite_path = create_folder( $context.cwd, $context._root_ )
        $context.test1_path = "#{$context.suite_path}/first-test.coffee"
        $context.test2_path = "#{$context.suite_path}/second-test.coffee"
        suite_context = 'coffee'
        $context.url = $.URI( $context, "actions/suite/run/?path=/#{$context.suite_path}&context=#{suite_context}" )
    
        set_context($context.suite_path, "[#{suite_context}]")
        write_test($context.test1_path, "test 'first test', -> ok true, 'ok'")
        write_test($context.test2_path, "test 'second test', -> ok true, 'ok'")
        
    after ->
        delete_folder( $context.suite_path )
        
    describe 'compiled js file should be removed too', ->
             
        it 'both tests should be executed first time', (done)->
            $.when( frame.go( $context.url ) ).then ->
                $.waitFor.condition( frameTestsAreDone ).then ->
                    expect( _$('.test-name').length ).to.equal( 2 )
                    delete_test( $context.test2_path )
                    done()
    
        it 'only one test should be executed after removing one', (done)->
            $.when( frame.go( $context.url ) ).then ->
                $.waitFor.condition( frameTestsAreDone ).then ->
                    expect( _$('.test-name').length ).to.equal( 1 )
                    done()