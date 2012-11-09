module( 'supported methods are' );

QUnit.setup( function() {
  with(context) {
    create_folder(context.root, '/');
    context.suite_path = root.concat('/', suite_name);
    context.test_path = suite_path + '/' + test_name;
    create_test( test_name, suite_path );
    write_test( test_path, search_pattern );
  }
});
                 
asyncTest( 'substring', function() {

  $.when( frame.go( get_search_url() ) ).then( function( _$ ) {

    ok( _$( "div[class=search]" ).length > 0 , 'the search results are visible' );
    equal( _$( ".highlight:contains('" + context.search_pattern + "')" ).length,
          context.search_results_expected,
          'number of results'
    );
    
    start();
  });
});

asyncTest( 'RegExp', function() {

  $.when( frame.go( get_search_url() ) ).then( function( _$ ) {

    ok( _$( "div[class=search]" ).length > 0 , 'the search results are visible' );
    equal( _$( ".highlight:contains('" + context.search_pattern + "')" ).length,
          context.search_results_expected,
          'number of results'
    );
    
    start();
  });
});

QUnit.teardown( function() {
  delete_folder(context.root);
});