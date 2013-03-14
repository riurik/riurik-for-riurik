describe 'create new suite', ->

    before (done)->
        $context.path = create_folder($context.cwd, $context._root_)
        $.when( frame.go( $context.path ) ).then ->
            done()
        
    after ->
        delete_folder $context.path
        
    it 'title should be name of the current folder', ->
        
        expect( frame.document().title ).to.eql( $context.cwd )
  
    describe 'should be possible to create folder or script', ->
        
        before ->
            $context.hmenu = _$( 'ul.horizontal-menu' )
            
        it 'create suite', ->
            expect( _$( 'a#new-suite', $context.hmenu ) ).to.not.be.empty
            
        it 'create test', ->
            expect( _$( 'a#new-test', $context.hmenu ) ).to.not.be.empty
    
        it 'Run button is NOT visible', ->
            expect( _$('a#run', $context.hmenu) ).to.not.be.visible