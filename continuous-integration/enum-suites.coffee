describe 'enumirate suites', ->
    
    before ->
        $context.suite_path = create_folder( $context.cwd, $context._root_ )
        $context.URL = $.FULL_URL( "#{$context.enum_url}#{$context.suite_path}&context=#{$context.ctx_name}" )
        for num in [2..0]
            ctx_name = if num > 0 then $context.ctx_name else 'other-context'
            create_suite( "suite-#{num}", $context.suite_path, "[#{ctx_name}]" )
            
    after ->
        delete_folder( $context.suite_path )
            
    describe 'should return string by default', ->
        
        before (done)->
            $.get $context.URL, (data)->
                $context.data = data
                done()
                
        it 'should return first suite', ->
            expect( $context.data ).to.contain( "#{$context.cwd}/suite-1" )
                
        it 'should return second suite', ->
            expect( $context.data ).to.contain( "#{$context.cwd}/suite-2" )
            
        it 'should not return zero suite', ->
            expect( $context.data ).to.not.contain( "#{$context.cwd}/suite-0" )
            
    describe 'should return as json', ->
        
        before (done)->
            $.getJSON "#{$context.URL}&json=true", (data)->
                $context.data = data
                done()
                
        it 'should return only 2 suite', ->
            expect( $context.data ).length( 2 )
            
        it 'should return first suite', ->
            expect( $context.data ).to.include( "#{$context.cwd}/suite-1" )
            
        it 'should return first suite', ->
            expect( $context.data ).to.include( "#{$context.cwd}/suite-2" )
            
        it 'should not return zero suite', ->
            expect( $context.data ).to.not.include( "#{$context.cwd}/suite-0" )
            
    it 'should return empty result if no context', (done)->
        $.getJSON $.FULL_URL( "#{$context.enum_url}#{$context.suite_path}&json=true}" ), (data)->
            expect( data ).to.be.empty
            done()
        