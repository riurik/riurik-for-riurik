Spec '''
Feature: Create test

  Scenario:
    Given User is logged in
      And the front-page is opened
'''

Given /User is logged in/, (next)->
  $.when( frame.go('') ).then (_$)->
    equal $.trim( _$('#github-user').text() ), 'riurik'
    next()
  
Given /the front-page is opened/, (next)->
  next()