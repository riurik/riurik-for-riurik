module 'riurik log'

test 'should not be QUnit.log', ->
  ok not QUnit.log?, 'this should be removed'
