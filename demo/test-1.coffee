test 'test', ->
	$.each( { '.qui-btn-mini': 22, '.qui-btn-small': 32, '.qui-btn-medium': 38, '.qui-btn-large': 49 }, (button, height)->
        console.log(height)
    )
