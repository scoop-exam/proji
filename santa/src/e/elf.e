class
    ELF

inherit
    PROCESS

create
    make

feature
    make (i, bf: INTEGER; s: separate SANTA)
        require
            bf >= 1
        do
            id := i
            santa := s
            max_build_failures := bf
            setup
        end

feature {NONE}
    no_build_failures: INTEGER
    max_build_failures: INTEGER

    over: BOOLEAN
        do
            separate santa as s do
                Result := served or s.is_xmas
            end
        end

    step
        do
            if not build_toy then
            	-- time for going to santa
            	random_sleep (1)
                go_to_santas (santa)
                get_help (santa)
                come_back (santa)
                random_sleep (1)
            end
        end

    build_toy: BOOLEAN
        local
            l_failure: BOOLEAN
        do
            l_failure := not choice

            if l_failure then
                no_build_failures := no_build_failures + 1
            end

            Result := not l_failure
        ensure
        	no_build_failures >= old no_build_failures
        end

    go_to_santas (s: separate SANTA)
        require
            not s.is_busy
        do
            s.enqueue_elf (id)
        end

    get_help (s: separate SANTA)
        require
            s.is_busy
        do
            served := no_build_failures = max_build_failures
        end

    come_back (s: separate SANTA)
        do
            s.dequeue_elf (id)
        end

feature {NONE}
    served: BOOLEAN

invariant
    no_build_failures >= 0
    no_build_failures <= max_build_failures

end
