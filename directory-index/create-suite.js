module('create a suite');

QUnit.setup(function() {
    $context.root = create_folder($context.cwd, context._root_);
    $context.suite_name = 'first-suite';
    $context.suite_path = $context.root.concat('/', context.suite_name);
});

asyncTest('suite should be created', function() {
  $.when( frame.go( $.FULL_URL( $context.root ) ) ).then(function(_$) {
    
    $.when( _$('a#new-suite').click() ).then(function() {
      
      _$('#object-name').val($context.suite_name);
      _$('#create-folder-btn').click();
      
      $.when( frame.load() ).then(function(_$) {
        equal(_$('li#'+ $context.suite_name + '.folder').length, 1, 'new folder for suite has been created');
                
        start();
      });
    });
  });
});

QUnit.teardown(function() {
  delete_folder( $context.root );
});