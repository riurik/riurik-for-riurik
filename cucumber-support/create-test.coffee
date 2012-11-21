Spec '''
Feature: Create test

  Scenario:
    Given User is logged in
      And the front-page is opened
'''

Given /User is logged in/, (next)->
  $.when( frame.go('') ).then (_$)->
    if $.trim( _$('#github-user').text() ) != 'riurik'
      next.fail('The riurik user should be logged in')
    else
      next()
  
Given /the front-page is opened/, (next)->
  next()