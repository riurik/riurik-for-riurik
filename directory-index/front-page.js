module('front page');

asyncTest('is first page', function() {
  $.when( frame.go( $.URI(context, '') ) ).then(function(_$) {
    equal( _$('.breadcrumbs').html(), '', 'there are no breadcrumbs' );
    
    var suites = $.map(_$('li.suite'), function(el) { return $.trim($(el).text()); })
    ok( $.inArray( context.vfolder1, suites ) != -1, context.vfolder1.concat(' is in ', suites ) );
    
    var folders = $.map(_$('li.folder'), function(el) { return $.trim($(el).text()); })
    ok( $.inArray( context.vfolder2, folders ) != -1, context.vfolder2.concat(' is in ', folders ) );
    
    ok( _$('a#virtual-settings').length == 1, 'the Settings button is shown' );
    ok( _$('a#new-suite').length == 1, 'the Create Suite button is shown' );
    ok( _$('a#new-test').length == 0, 'the Create test button is not shown' );
    
    start();
  });
});