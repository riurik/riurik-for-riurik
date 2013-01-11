module 'suite status'

QUnit.setup ->
    create_folder(context.root, '/')
    
    context.suite_path = "#{context.root}"
    context.test1_path = "#{context.suite_path}/first-test.coffee"
    context.test2_path = "#{context.suite_path}/second-test.coffee"
    context.test3_path = "#{context.suite_path}/third-test.coffee"
    context.suite_context = 'reporting'
    context.start_time = '1354259978.0'
    context.url = $.URI(context, "actions/suite/run/?path=/#{context.suite_path}&context=#{context.suite_context}&date=#{context.start_time}")

    set_context(context.suite_path, "[#{context.suite_context}]")
    write_test(context.test1_path, "module 'module'\ntest 'first test', -> ok true, 'ok'")
    write_test(context.test2_path, "module 'module'\ntest 'second test', -> ok true, 'ok'")
    write_test(context.test3_path, "module 'module'\ntest 'third test', -> ok false, 'just error'")

    purge( context.suite_context, context.suite_path )
   
asyncTest 'suite is started should be reported', ->
    $.when( frame.go(context.url) ).then ->
        $.waitFor.condition ->
            suite_started( context.suite_context, context.suite_path, context.start_time )
        .then ->
            start()

asyncTest 'suite is done should be reported', ->
    $.waitFor.condition ->
        suite_done( context.suite_context, context.suite_path, context.start_time )
    .then ->
        start()

QUnit.teardown ->
    delete_folder context.root
