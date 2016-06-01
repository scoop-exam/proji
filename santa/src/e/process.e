note
    description : "[
        Class that represents an iterative process.
        A process inits and lives until a stopping condition is reached.
        The implementation is inpired by the one of
        Volkan Arslan, Yann Mueller, Piotr Nienaltowski.
    ]"
    author      : "Michele Guerriero and Lorenzo Affetti"

deferred class
    PROCESS

inherit
    EXECUTION_ENVIRONMENT


feature -- Access
    live
        do
            from until
                over
            loop
                step
            end
            wrapup
        end

feature {NONE} -- Lifecycle
    setup
        local
            l_time: TIME
            l_seed: INTEGER
        do
            create l_time.make_now
            l_seed := l_time.milli_second
            create rnd_seq.set_seed (l_seed)


            l_seed := l_time.hour
            l_seed := l_seed * 60 + l_time.minute
            l_seed := l_seed * 60 + l_time.second
            l_seed := l_seed * 60 + l_time.milli_second
            create rnd_waiting_seq.set_seed (l_seed)
        end

    over: BOOLEAN
            -- Should execution terminate now?
        deferred
        end

    step
        deferred
        end

    wrapup
        do
        end

feature {NONE} -- Utils
    rnd_seq: RANDOM
    rnd_waiting_seq: RANDOM
    id: INTEGER

    choice: BOOLEAN
            -- Use this feature to perform
            -- random choices.
            -- Returns a random boolean.
        local
            l_res: INTEGER
        do
            rnd_seq.forth
            l_res := rnd_seq.item \\ 2

            -- TODO find a more Eiffel idiomatic way, please
            if l_res = 0 then
                Result := false
            else
                Result := true
            end
        end

    random_sleep ( max : INTEGER_64 )
            -- sleeps for a random number of seconds
            -- between 1 and max
        require
            max >= 1
        local
            time: INTEGER_64
            rnd_fact: REAL
        do
            rnd_waiting_seq.forth
            time := ((rnd_waiting_seq.item \\ max) + 1) * 1_000_000_000
            sleep(time)
        end
end
