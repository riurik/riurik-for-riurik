describe 'edit test specification', ->
    
    before (done)->
        $context.spec_url = 'http://google.com'
        setup_for_test $context, 'Specification', ->
            set_spec( $context.suite_path, $context.spec_url, "" )
            done()
            
    after ->
        delete_folder( $context.suite_path )
    
    it 'should have appropriate target', ->
        expect( $context.target.text() ).string( $context.test_name )

    it 'should have appropriate context', ->
        expect( $context.target.attr('class') ).string( 'test' )

    it 'should have appropriate action', ->
        expect( $context.action ).to.equal( '#editspec' )
        
     describe 'should open specification for editing', ->
         
        before (done)->
            click_context_menu_frame_load $context.action.substring(1), $context.target, ->
                $.waitFor.condition( frameEditorIsOpened ).then ->
                    done()
            
        it 'editor has appropriate content', ->
            expect( frame.window().editor.getValue() ).string( $context.spec_url )
            
        it 'breadcrumbs shows context.ini title', ->
            expect( _$($context.breadcrumbs_selector).text() ).string( $context.spec_ini )