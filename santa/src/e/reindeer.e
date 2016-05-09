class
    REINDEER

inherit
    PROCESS

create
    make

feature
    make (i: INTEGER; s: separate SANTA)
        require
            s /= Void
        do
            id := i
            santa := s
            setup
        end

feature {NONE}
    over: BOOLEAN
        do
            Result := at_santas
        end

    step
        do
            if wake_up then
            	random_sleep (10)
                go_to_santas (santa)
                get_hitched (santa)
            end
        end

    wake_up: BOOLEAN
        do
            Result := choice
        end

    go_to_santas (s: separate SANTA)
    	require
    		not at_santas
        do
            s.enqueue_reindeer (id)
            at_santas := true
        ensure
        	at_santas
        end

    get_hitched (s: separate SANTA)
        require
            s.is_ready
        do
            s.hitch (id)
        end

feature {NONE}
    at_santas: BOOLEAN
end
