module 'demo'

asyncTest 'front page should provide sing in', ->
	$.when( frame.go('') ).then ->
        $.waitFor.condition( -> _$('#inputArea').length > 0 ).then ->
            equal _$('input[name="username"]').length, 1, 
            equal _$('input[name="password"]').length, 1
            start()

asyncTest 'dashboard should be shown for authorized user', ->
    _$('input[name="username"]').val('SPBDev@QuestSPDev.onmicrosoft.com')
    _$('input[name="password"]').val('school-240')
    $.waitFor.frame(10000).then ->
        equal _$('div.sa_hdr:contains("SharePoint Online")').length, 1
        start()
    _$('#inputArea').submit()
    
asyncTest 'top five site collections gadget should be on dashboard', ->
    $.waitFor.condition( -> _$('#tblSiteCollections .div-table-row').length > 0 ).then ->
        equal _$('#tblSiteCollections .div-table-row').length, 5
        start()