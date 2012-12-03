Given /it is necessary to create the (.+) script in the (.+) suite/, (test_name, suite_name, next)->
  @given_test = test_name
  @given_suite = suite_name
  next()