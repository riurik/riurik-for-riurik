Given /it is necessary to create the (.+) script in the (.+) suite/, (test_name, suite_name, next)->
  @given_test = test_name
  @given_suite = suite_name
  create_folder(@given_suite, '/')
  next()
  
When /user (.+) is in the given folder/, (name, next)->
  $.when( frame.go("#{@given_suite}") ).then (_$) ->
    equal $.trim( _$('#github-user').text() ), name
    next()
    
Then /he dose not see the given script/, (next)->
  equal _$("li.test[title='#{@given_test}']").length, 0
  next()
  
Then /he sees the (.+) link/, (link_title, next)->
  @create_test = _$('a#new-test')
  equal @create_test.text(), link_title
  next()
  
When /the link is pushed/, (next)->
  $.when( @create_test.click() ).then ()->
    next()
  
Then /the user sees the (.+) dialog/, (dialog_title, next)->
  equal _$('#create-dir-index-dialog').is(":visible"), true
  equal _$('.ui-dialog-title').text(), dialog_title
  next()
  
When /he types given test name/, (next)->
  _$('#object-name').val(@given_test)
  next()
  
When /press the (.+) button/, (button, next)->
  $.waitFor.frame().then ()->
    next()
  _$("button :contains(#{button})").click()
  
Then /new test script should be created/, (next)->
  #$.substring _$("p.breadcrumbs").text(), "folder-for-tests  ‣  first-test.coffee"
  #$.substring _$("p.breadcrumbs").text(), "first-test.coffee"
  delete_folder("/#{@given_suite}")
  next()
  
After (next)->
    delete_folder @given_suite
    next()