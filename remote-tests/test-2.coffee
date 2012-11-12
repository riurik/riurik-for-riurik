module('second test');

asyncTest 'should be executed on the remote server', ->
  $.when( frame.go('hello') ).then ->
    equal $.trim(_$('body').text()), 'Hello world!'
    start()