module( 'search in tests' );

QUnit.setup( function() {
  with(context) {
    create_folder(context.root, '/');
    context.suite_path = root.concat('/', suite_name);
    context.test_path = suite_path + '/' + test_name;
    create_test( test_name, suite_path );
    write_test( test_path, search_pattern );
    
    context.ini_name = '.context.ini'
    context.jsini_name = 'context.js'
    context.ini_path = context.suite_name + '/' + context.ini_name;
  }
});
                 
asyncTest( 'should show results', function() {
  $.when( frame.go( get_search_url() ) ).then( function( _$ ) {
  
    equal( _$( "div.search h1" ).text(), "Search results for '" + context.search_pattern + "'", 'should be title' );
    
    var files = _$( "div.search ul li" );
    equal( files.length, context.search_results_expected, 'should be list of files' );
    
    var link = _$( "a[href$='" + context.ini_name + "']", files);
    ok( link.length === 1, context.ini_name + ' should be found');
    equal( link.text(), '/' + context.ini_path, 'should show name of file');
    equal( link.attr('href'), '#/' + context.ini_path, 'should have anchor');
    
    var link = _$( "a[href$='" + context.test_name + "']", files);
    ok( link.length === 1, context.test_name + ' should be found');
    equal( link.text(), '/' + context.test_path, 'should show name of file');
    equal( link.attr('href'), '#/' + context.test_path, 'should have anchor');
    
    var link = _$( "a[href$='" + context.jsini_name + "']", files);
    ok( link.length === 0, context.jsini_name + ' should not be found');
    
    var contents = _$( "div.filepath" );
    equal( contents.length, context.search_results_expected, 'should be list of files content' );
    var link = _$( "a[href$='" + context.test_name + "']", contents);
    ok( link.length === 1, context.test_name + ' should be link to file');
    var link = _$( "a[href$='" + context.test_name + "?editor']", contents);
    ok( link.length === 1, context.test_name + ' should be link to file to edit');
    
    start();
  });
  
});

QUnit.teardown( function() {
  delete_folder(context.root);
});