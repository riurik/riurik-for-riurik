describe 'suite status reporting', ->

    before ->
        $context.suite_path = create_folder( $context.cwd, $context._root_ )
        $context.test1_path = "#{$context.suite_path}/first-test.coffee"
        $context.test2_path = "#{$context.suite_path}/second-test.coffee"
        $context.test3_path = "#{$context.suite_path}/third-test.coffee"
        $context.suite_context = 'reporting'
        $context.start_time = '1354259978.0'
        $context.url = $.FULL_URL( "actions/suite/run/?path=/#{$context.suite_path}&context=#{$context.suite_context}&date=#{$context.start_time}" )
    
        set_context( $context.suite_path, "[#{context.suite_context}]" )
        write_test( $context.test1_path, "module 'module'\ntest 'first test', -> ok true, 'ok'")
        write_test( $context.test2_path, "module 'module'\ntest 'second test', -> ok true, 'ok'")
        write_test( $context.test3_path, "module 'module'\ntest 'third test', -> ok false, 'just error'")

        purge( $context.suite_context, $context.suite_path )
        
    after ->
        delete_folder( $context.suite_path )
   
    it 'suite is started should be reported', (done)->
        $.when( frame.go( $context.url ) ).then ->
            $.waitFor.condition ->
                suite_started( $context.suite_context, $context.suite_path, $context.start_time )
            .then ->
                done()

    it 'suite is done should be reported', (done)->
        $.waitFor.condition ->
            suite_done( $context.suite_context, $context.suite_path, $context.start_time )
        .then ->
            done()
