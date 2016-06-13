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
            -- Starts the lifecycle
        do
            from
                setup
            until
                over
            loop
                step
            end
        end

feature {NONE} -- Lifecycle
    setup
            -- Sets internal attributes accordingly
        local
            l_time: TIME
            l_seed: INTEGER
        do
            create l_time.make_now
            l_seed := l_time.hour
            l_seed := l_seed * 60 + l_time.minute
            l_seed := l_seed * 60 + l_time.second
            l_seed := l_seed * 60 + l_time.milli_second
            create rnd_seq.set_seed (l_seed)
        ensure
            rnd_seq /= Void
        end

    over: BOOLEAN
            -- Should execution terminate now?
        deferred
        end

    step
            -- Core of the lifecycle.
            -- Called at each iteration.
        deferred
        end

feature {NONE} -- Utils
    rnd_seq: detachable RANDOM
    id: INTEGER

    choice: BOOLEAN
            -- Use this feature to perform
            -- random choices.
            -- Returns a random boolean.
        local
            l_res: INTEGER
        do
            if attached rnd_seq as r then
                r.forth
                l_res := r.item \\ 2
                Result := l_res = 0
            else
                Result := False
            end
        end

    random_sleep (max : INTEGER_64)
            -- Sleeps for a random number of seconds
            -- between 1 and max.
        require
            max >= 1
        local
            time: INTEGER_64
        do
            if attached rnd_seq as r then
                r.forth
                time := ((r.item \\ max) + 1) * 1_000_000_000
            else
                time := 1_000_000_000
            end
            sleep(time)
        end
end
