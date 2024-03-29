module 'bootstrap'

test 'environmen variables should be defined', ->
  ok riurik?, 'Top level namespace for Riurik is defined'
   
  equal riurik.src.jquery, '/static/js/jquery.min.js', 'jquery source to load into the frame'
  equal riurik.src.bootstrap, '/static/js/bootstrap.js', 'bootsrtap script source'
  equal riurik.args.server, riurik.GetArgument 'server', 'Riurik server URL'
  equal riurik.args.path, riurik.GetArgument 'path', 'current executed test or suite path'
  
test 'tests context should be defined', ->
  ok context?
  
test 'GetArgument method should warn if argument can not be found by name', ->
  arg1 = 'arg1'
  sinon.stub window, "alert"
  
  riurik.GetArgument "#{arg1}"
  
  ok window.alert.withArgs("Can not find argument #{arg1}").calledOnce
  window.alert.restore()
  
test 'BuildHttpUri should return absolute http URI for the Riurik server', ->
  equal riurik.BuildHttpUri('/path/to/js/script'), "http://#{riurik.args.server}/path/to/js/script"
  
test 'GetCwd should return a suite path if executed target is suite', ->
  path = '/riurik-inner-tests/tests-loader'
  equal riurik.GetCwd(path), path
  
test 'GetCwd should return a test parent dir if executed target is test', ->
  parentDir = '/riurik-inner-tests/tests-loader'
  equal riurik.GetCwd("#{parentDir}/bootsrap.js"), parentDir
  
test 'it should be checked if QUnit is loaded', ->
  QUnit = window.QUnit
  window.QUnit = QUnit.not
  sinon.stub window, "alert"
  
  riurik.engine.config();
  
  ok window.alert.withArgs("QUnit should be preliminary loaded").calledOnce, 'warning alert is called'
  window.alert.restore()
  window.QUnit = QUnit

test 'it should be checked if context is loaded', ->
  Context = window.context
  window.context = context.not
  sinon.stub window, "alert"
  
  riurik.trigger( "riurik.inited" )
  
  ok window.alert.withArgs("context should be preliminary loaded").calledOnce, 'warning alert is called'
  window.alert.restore()
  window.context = Context
  
test 'the Waits object should be exported with context timeout and check_every', ->
  ok riurik.exports.waitFor?, 'object is created'
  equal riurik.exports.waitFor.timeout, context.timeout, 'timeout is fine'
  equal riurik.exports.waitFor.checkEvery, context.check_every, 'check_every is fine'

test 'the QUnit engine should be loaded and configured properly', ->
  ok riurik.QUnit?, 'object is created'
  equal riurik.QUnit.status, 'started'
  ok riurik.QUnit.current.module
  ok riurik.QUnit.current.test