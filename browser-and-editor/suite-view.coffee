describe 'suite view', ->

    before (done)->
        $.when( frame.go get_current_suite() ).then ->
            done()

    it 'title should be name of the suite', ->
        expect( get_current_suite() ).string( frame.document().title )
  
    describe 'control panel is available', ->
        
        before ->
            $context.hmenu = _$( 'ul.horizontal-menu' )
            
        it 'create suite', ->
            expect( _$( 'a#new-suite', $context.hmenu ) ).to.not.be.empty
            
        it 'create test', ->
            expect( _$( 'a#new-test', $context.hmenu ) ).to.not.be.empty
    
        it 'Run suite button is visible', ->
            expect( _$('a#run-suite-btn', $context.hmenu) ).to.be.visible
            
    
        it 'History button is visible', ->
            expect( _$('a#history', $context.hmenu) ).to.be.visible
            
        it 'Context button is visible', ->
            expect( _$('a#context-preview-ctrl', $context.hmenu) ).to.be.visible
        
        it 'Spec button is visible', ->
            expect( _$('a#spec-link', $context.hmenu) ).to.be.visible