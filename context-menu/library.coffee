setup_for_test = ( $context, menu_name, done )->
    $context.suite_path = create_folder( $context.cwd, $context._root_ )
    $context.test_path = create_test( $context.test_name, $context.suite_path )
    $.when( frame.go( $context.suite_path ) ).then ->
        $context.target = _$( ".dir-index ul li:contains('#{$context.test_name}')" )
        $context.action = _$( "#{$context.menu_locator} a:contains('#{menu_name}')" ).attr('href')
        done()
        
setup_for_suite = ( $context, menu_name, done )->
    $context.suite_path = create_folder( $context.cwd, $context._root_ )
    set_context( $context.suite_path, "[#{$context.ctx_name}]" )
    $.when( frame.go( $context._root_ ) ).then ->
        $context.target = _$( ".dir-index ul li:contains('#{$context.cwd}')" )
        $context.action = _$( "#{$context.menu_locator} a:contains('#{menu_name}')" ).attr('href')
        done()
