describe 'library compile', ->

    describe 'including compiled global coffee library', ->
        
        it 'global lib compiled and global_coffee_lib is exists', ->
            expect( global_coffee_lib? ).to.be.ok
            
        it 'global_coffee_lib is executable', ->
            expect( global_coffee_lib() ).to.be.ok
            
    describe 'including compiled local coffee library', ->
        
        it 'local lib compiled and local_coffee_lib is exists', ->
            expect( local_coffee_lib? ).to.be.ok
            
        it 'local_coffee_lib is executable', ->
            expect( local_coffee_lib() ).to.be.ok
        
    

		
    	