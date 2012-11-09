#chromium-browser --disable-web-security

module 'frame init on google maps'
             
asyncTest 'jQuery should be loaded', ->
  $.when( frame.go( "https://maps.google.ru/maps?hl=en&tab=wl&output=embed", true ) ).then (_$)->
    ok _$?, 'jQuery is loaded'
    start()