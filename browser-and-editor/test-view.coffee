describe 'test view', ->

    before (done)->
        current_test = "test-view.coffee"
        $.when( frame.go "#{get_current_suite()}/#{current_test}?editor" ).then ->
            $context.hmenu = _$( 'ul.horizontal-menu' )
            done()
        
    it 'Run test button should be visible', ->
        expect( _$('a#run') ).to.be.visible
        
    it 'Context button should be visible', ->
        expect( _$('a#context-preview-ctrl', $context.hmenu) ).to.be.visible
    
    it 'Spec button should be visible', ->
        expect( _$('a#spec-link') ).to.be.visible
    
    it 'Save button should be visible', ->
        expect( _$('a#save') ).to.be.visible
        
    it 'Close button should be visible', ->
        expect( _$('a#close') ).to.be.visible