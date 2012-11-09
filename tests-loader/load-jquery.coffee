module 'frame init'
             
asyncTest 'jQuery should be loaded', ->
  frame.init (_$)->
    ok _$?, 'jQuery should be loaded'
    $.fail 'TODO'
    start()