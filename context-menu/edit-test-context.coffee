describe 'edit test context', ->
    
    before (done)->
        setup_for_test $context, 'Context', ->
            set_context( $context.suite_path, "[#{$context.ctx_name}]" )
            done()
            
    after ->
        delete_folder( $context.suite_path )
    
    it 'should have appropriate target', ->
        expect( $context.target.text() ).string( $context.test_name )

    it 'should have appropriate context', ->
        expect( $context.target.attr('class') ).string( 'test' )

    it 'should have appropriate action', ->
        expect( $context.action ).to.equal( '#editctx' )
        
    describe 'should open context for editing', ->
         
        before (done)->
            click_context_menu_frame_load $context.action.substring(1), $context.target, ->
                $.waitFor.condition( frameEditorIsOpened ).then ->
                    done()
            
        it 'editor has appropriate content', ->
            expect( frame.window().editor.getValue() ).to.equal( "[#{$context.ctx_name}]" )
            
        it 'breadcrumbs shows context.ini title', ->
            expect( _$($context.breadcrumbs_selector).text() ).string( $context.ctx_ini )