module('breadcrumbs');

QUnit.setup(function() {
  context.folder_name = 'first-folder';
  context.suite_name = 'first-suite';
  context.suite_path = context.folder_name + '/' + context.suite_name;
  context.test_name = 'first-test.js';
  context.test_path = context.suite_path + '/' + context.test_name;
  create_folder(context, context.root, '/');
  var path = create_folder(context, context.folder_name, context.root);
  path = create_folder(context, context.suite_name, path);
  create_test(context.test_name, path );
  bd_selector = 'div.breadcrumbs'
});

asyncTest('for root', function() {
  var URL = $.URI(context, '');
  $.when( frame.go(URL) ).then(function(_$) {
        ok( _$(bd_selector).length > 0, 'bredcrumbs are exist' );
        equal( _$(bd_selector).html(), '', 'but empty' );
        
        start();
  });
});

asyncTest('for folder', function() {
  with(context) {
    var URL = $.URI(context, root.concat('/', folder_name));
    
    $.when( frame.go(URL) ).then(function(_$) {
        bd = _$(bd_selector)
        ok( bd.length > 0, 'bredcrumbs are exist' );
        bd_href = _$('a', bd_selector)
        equal( bd_href.length, 4, 'bredcrumbs contain all links' );
        equal( bd_href.first().html(), "•" );
        equal( bd_href.first().attr('href'), '/', 'first link leads to root' );
        equal( bd_href.last().attr('href'), '/'.concat(root, '/'), 'last link leads to previous(virtual) folder' );
        equal( $(bd_href[1]).html(), root, 'first crumb is virtual folder' );
        equal( $(bd_href[2]).html(), folder_name, 'second crumb is woring folder' );
        equal( $(bd_href[2]).attr('href'), undefined, 'current level link does not have href' );
        ok( bd_href.last().find('img').length == 1, 'last link is image' );
        equal( bd_href.last().find('img').attr('src'), '/static/img/up.png' );
      
        start();
    });
  }
});

asyncTest('for suite', function() {
  with(context) {
    var URL = $.URI(context, root.concat('/', suite_path));

    $.when( frame.go(URL) ).then(function(_$) {
        bd = _$(bd_selector)  
        ok( bd.length > 0, 'bredcrumbs are exist' );
        bd_href = _$('a', bd_selector)
        ok( bd_href.length == 5, 'bredcrumbs contain all links' );
        equal( bd_href.first().html(), "•" );
        equal( bd_href.first().attr('href'), '/', 'first link leads to root' );
        equal( bd_href.last().attr('href'), '/'.concat(root, '/', folder_name, '/'), 'last link leads to upper level' );
        equal( $(bd_href[3]).html(), suite_name );
        equal( $(bd_href[3]).attr('href'), undefined, 'current level link does not have href' );
      
        start();
    });
  }
});

asyncTest('for test', function() {
  with(context) {
    var URL = $.URI( context, root.concat('/', test_path, '?editor') );
    
    $.when( frame.go(URL) ).then(function(_$) {
        bd = _$(bd_selector)  
        ok( bd.length > 0, 'bredcrumbs are exist' );
        bd_href = _$('a', bd_selector)
        ok( bd_href.length == 5, 'bredcrumbs contain all links' );
        equal( bd_href.first().html(), "•" );
        equal( bd_href.first().attr('href'), '/', 'first link leads to root' );
        equal( $(bd_href.last()).html(), test_name, 'script name is last element');
        equal( bd_href.last().attr('href'), undefined, 'script name does not have link' );
        equal( $(bd_href[3]).html(), context.suite_name );
        equal( $(bd_href[3]).attr('href'), '/'.concat(root, '/', folder_name, '/', context.suite_name, '/'), 'second link leads to parent suite' );
      
        start();
    });
  }
});

QUnit.teardown(function() {
  delete_folder( context, context.root );
});