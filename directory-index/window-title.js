module('window title');

QUnit.setup(function() {
    $context.suite_name = 'first-suite';
    $context.test_name = 'first-test.js';
    $context.root = create_folder( $context.cwd, $context._root_ );
    $context.suite_path = create_folder( $context.suite_name, $context.root);
});

asyncTest('title for folder', function() {
    $.when( frame.go( $.FULL_URL( $context.root ) ) ).then(function(_$) {
        equal(frame.document().title, $context.cwd);
        start();
    });
});

asyncTest('title for suite', function() {
    $.when( frame.go( $.FULL_URL( $context.suite_path ) ) ).then(function(_$) {
        equal(frame.document().title, $context.suite_name);
        start();    
    });
});

asyncTest('title for test', function() {
    write_test( $context.suite_path + '/' + $context.test_name, "test('first test', function(){ok(true)});");
    $.when( frame.go( $.FULL_URL( $context.suite_path + '/' + $context.test_name + '?editor' ) ) ).then(function(_$) {
        equal(frame.document().title, $context.test_name);
        start();
  });
});

QUnit.teardown(function() {
  delete_folder( $context.root );
});