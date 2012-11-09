module( 'search UI' );

asyncTest( 'it is possible to search from the root page', function() {

  context.url = $.URI( context, '' );
  QUnit.log( 'Root URL: ' + context.url );

  $.when( frame.go( context.url ) ).then( function( _$ ) {

    ok( _$( "div#search" ).length == 1, 'search is visible' );
    
    start();
  });
});

asyncTest( 'it is possible to search from a folder', function() {

  context.url = $.URI( context, context.suite_name );

  $.when( frame.go( context.url ) ).then( function( _$ ) {

    var search = _$( "div#search" );
    ok( search.length == 1, "One search input, ok" );

    var form = _$( "form", search );
    var input = _$( "input[name=search_pattern]", form );
    
    input.val( context.search_pattern );
    
    ok( form.attr( 'target' ) == context.search_form_target, 'Search form target is OK' );
    
    form.attr( 'target', '' );
    form.submit();
    
    $.waitFor.frame().then( function(_$) {
      riurik.log(_$);
      ok( _$( "h1:contains('Search results')" ).length > 0, 'Search results is not empty, OK' );
      start();
    });
  });
});