Spec '''
Feature: Create test

  Scenario:
    Given User is logged in
      And the front-page is opened
'''

Given /User is logged in/, ()->
  $.pass
  next()
  
Given /the front-page is opened/, ()->
  $.pass
  next()