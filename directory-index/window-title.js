module('window title');

QUnit.setup(function() {
  context.suite_name = 'first-suite';
  context.suite_path = context.root + '/' + context.suite_name;
  context.test_name = 'first-test.js';
  create_folder(context, context.root, '/');
  var path = create_folder(context, context.suite_name, context.root);
});

asyncTest('title for folder', function() {
  $.when( frame.go( $.URI(context, context.root) ) ).then(function(_$) {
    equal(frame.document().title, context.root);
    start();
    
  });
});

asyncTest('title for suite', function() {
  $.when( frame.go( $.URI(context, context.suite_path) ) ).then(function(_$) {
    equal(frame.document().title, context.suite_name);
    start();
    
  });
});

asyncTest('title for test', function() {
  write_test(context.suite_path + '/' + context.test_name, "test('first test', function(){ok(true)});");
  $.when( frame.go( $.URI(context, context.suite_path + '/' + context.test_name + '?editor') ) ).then(function(_$) {
    equal(frame.document().title, context.test_name);
    start();
    
  });
});

QUnit.teardown(function() {
  delete_folder(context, context.root);
});