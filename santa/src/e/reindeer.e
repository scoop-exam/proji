class
    REINDEER

inherit
    PROCESS

create
    make

feature -- Reindeer Initialization.

    make (i: INTEGER; s: separate SANTA)
            -- Creation procedure.
        do
            id := i
            santa := s
            setup
        end

feature {NONE} -- Reindeer's Implementation

    over: BOOLEAN
        do
            Result := at_santas
        end

    step

            -- Procedure to implement the reindeer life cycle:
            -- a) the reindeer goes to santa
            -- b) when santa is ready the reindeer is santa hitched
        do
            if wake_up then
            	random_sleep (10)
                go_to_santas (santa)
                get_hitched (santa)
            end
        end

    wake_up: BOOLEAN

            -- Procedure to determine when a reindeer goes to santa.
        do
            Result := choice
        end

    go_to_santas (s: separate SANTA)

            -- A reindeer arrives to santa.
    	require
    		not at_santas
        do
            s.enqueue_reindeer (id)
            at_santas := true
        ensure
        	at_santas
        end

    get_hitched (s: separate SANTA)

            -- A reindeer ask santa to be hitched. 
            -- First it has to wait for santa to be ready, or for all the other reindeers to be at santa.
        require
            s.is_ready
        do
            s.hitch (id)
        end

feature {NONE} -- Reindeer's status

        -- Says if the current reindeer is arrived to santa.
    at_santas: BOOLEAN

end
