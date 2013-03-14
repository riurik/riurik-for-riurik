describe 'editing new test', ->

    before ->
        $context.cwd_path = create_folder($context.cwd, $context._root_)
        $context.suite_path = create_folder( 'new-suite', $context.cwd_path )
        $context.test_path = create_test( 'new-test.js', $context.suite_path )
        
    after ->
        delete_folder( $context.cwd_path )

    describe 'user should be proposed to create context', ->
        
        before (done)->
            $.when( frame.go( $context.test_path + '?editor' ) ).then ->
                done()

        it 'Run test button should not be visible', ->
            expect( _$('a#run') ).to.not.be.visible
            
        it 'The Create context button should be visible', ->
            expect( _$('a#create-context') ).to.be.visible
            
        it 'The Create context button should have text', ->
            expect( _$('#create-context').text().trim() ).to.equal( 'Create context' )
            
        it 'The Create context button should have tooltip', ->
            expect( _$('#create-context').attr('title').trim() ).to.equal( 'To execute the test you have to define cotext' )
        
        it 'Spec button should be visible', ->
            expect( _$('a#spec-link') ).to.be.visible
        
        it 'Save button should be visible', ->
            expect( _$('a#save') ).to.be.visible
            
        it 'Close button should be visible', ->
            expect( _$('a#close') ).to.be.visible