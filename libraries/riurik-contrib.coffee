frameTestsAreStarted = ->
  fwnd = frame.window()
  fwnd.riurik? and fwnd.riurik.QUnit?

frameTestsAreDone = ->
  fwnd = frame.window()
  fwnd.riurik? and fwnd.riurik.QUnit? and fwnd.riurik.QUnit.status == 'done'

frameEditorIsOpened = ->
    return frame.window().editor?