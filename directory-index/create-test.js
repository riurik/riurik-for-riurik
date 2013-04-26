module('creat test'); 

QUnit.setup(function(){
  $context.test_name = 'test-for-test';
  $context.suite_name = 'first-suite';
  $context.root = create_folder( $context.cwd, context._root_ );
  $context.suite_path = create_folder( $context.suite_name, $context.root );
});

asyncTest('check created', function() { 
   
  $.when( frame.go( $.FULL_URL( $context.suite_path)) ).then(function(_$) {
    
    $.when( _$('a#new-test').click() ).then(function() {
      
      equal(_$('#create-dir-index-dialog').is(":visible"), true, 'dialog is visible');      
      equal(_$('.ui-dialog-title').text(), _$('a#new-test').text(), 'dialog has right title');
      _$('#object-name').val($context.test_name.concat('.js'));
      _$('button :contains(OK)').click()
       
      $.when( frame.load() ).then(function(_$) {
        equal(_$('#create-dir-index-dialog').is(":visible"), false, 'dialog is invisible');
        
        $.waitFor.condition( function() { return typeof frame.window().editor != 'undefined'  } ).then( function(){
          var editor = frame.window().editor; 
  
          editor.setValue("content")          
                          
          var evObj = document.createEvent('MouseEvents');
          evObj.initEvent( 'click', true, true );
          
          window.frames[0].document.getElementById('save').dispatchEvent(evObj);
              
          $.when( frame.load() ).then(function(_$) {
            
          start();
         });
        });        
      });
    });
  });  
});

QUnit.teardown(function() {
  delete_folder( $context.root );
});