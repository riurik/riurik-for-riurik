module('enumirate suites');

QUnit.setup(function() {
  var content = '[' + context.suite + ']';
  context.suites_list = '';

  context.cwd_path = create_folder(context, context.cwd, context._root_);
  $.each(context.suites, function(i, value) {
    create_suite(context, value, context.cwd_path, content);
  });
  
  var suite_path = context.cwd_path.concat('/', context.suites[0]);
  set_context(suite_path, '[other-context]');
  context.URL = $.URI(context, context.emum_url.concat(context.cwd_path, '&context=', context.suite));
  
});

function enum_suites(URL, checker) {
  $.ajax({
    type: 'GET',
    async: true,
    url: URL,
    success: function(data) {
      checker(data);
    },
    error: function() {
      ok(false, URL);
      start();
    }
  });
};
         
asyncTest('should return suites as string', function() {
  enum_suites(context.URL, function(result){
    QUnit.substring(result, context.suites[1], context.suites[1] + ' is in ' + result);
    QUnit.substring(result, context.suites[2], context.suites[2] + ' is in ' + result);
    start();
  });
});

asyncTest('should return suites as json', function() {
  var URL = context.URL.concat('&json=true');
  enum_suites(URL, function(result){
    result = $.parseJSON(result);
    ok($.inArray(context.suites[0], result ) == -1, context.suites[0] + ' is not in ' + result);
    ok($.inArray(context.suites[1], result ) != -1, context.suites[1] + ' is in ' + result);
    ok($.inArray(context.suites[2], result ) != -1, context.suites[2] + ' is in ' + result);
    start();
  });
});

asyncTest('should return only suites those match with given context', function() {
  var URL = context.URL.concat('&json=true');
  enum_suites(URL, function(result){
    result = $.parseJSON(result);
    ok($.inArray(context.suites[0], result ) == -1, context.suites[0] + ' is not in ' + result);
    start();
  });
});

asyncTest('should not return suites if no context', function() {
  var URL = $.URI(context, context.emum_url.concat(context.root, '&json=true'));
  enum_suites(URL, function(result){
    result = $.parseJSON(result);
    equal(result.length, 0, 'result is empty');
    start();
  });
});

QUnit.teardown(function() {
  delete_folder(context, context.cwd_path);
});