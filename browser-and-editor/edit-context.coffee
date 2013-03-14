describe 'context view - editor with .context.ini file', ->

    before ->
        $context.path = create_folder($context.cwd, $context._root_)
        
    after ->
        delete_folder( $context.path )

    describe 'control panel is available', ->
        
        before (done)->
            $.when( frame.go "#{$context.path}/#{$context.ctx_ini}?editor" ).then ->
                $context.hmenu = _$( 'ul.horizontal-menu' )
                done()
        
        it 'Run button is NOT visible', ->
            expect( _$('a#run', $context.hmenu) ).to.not.be.visible

        it 'Context button is NOT visible', ->
            expect( _$('a#context-preview-ctrl', $context.hmenu) ).to.not.be.visible
            
        it 'Spec button is not visible', ->
            expect( _$('a#spec-link', $context.hmenu) ).to.not.be.visible
            
        it 'Save button is visible', ->
            expect( _$('a#save', $context.hmenu) ).to.be.visible
            
        it 'Close button is visible', ->
            expect( _$('a#close', $context.hmenu) ).to.be.visible