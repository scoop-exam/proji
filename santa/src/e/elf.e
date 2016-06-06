note
    description : "Class that represents the behavior of an elf."
    author      : "Michele Guerriero and Lorenzo Affetti"

class
    ELF

inherit
    PROCESS

create
    make

feature -- Elf initialization

    make (i, bf: INTEGER; s: separate SANTA)
            -- Creation procedure.
        require
            bf >= 1
        do
            id := i
            santa := s
            max_build_failures := bf
            setup
        end

feature {NONE} -- Elf's lifecycle implementation

    max_build_failures: INTEGER
            -- The maximum number of times an elf can ask for Santa's help.

    over: BOOLEAN
            -- Determines the end of this elf's lifecycle.
            -- Returns true when it is Christmas (and then Santa has left)
            -- or the elf has reached the maximum number of build failures.
        do
            separate santa as s do
                Result := served or s.is_xmas
            end
        end

    step
            -- At each iteration the elf tries to build a toy.
            -- If he/she fails:
            --   a) the elf goes to santa asking for help
            --   b) the elf receives santa's help
            --   c) the elf comes back to the warehouse and restarts working
        do
            if not build_toy then
                random_sleep (1) -- time spent to reach Santa
                go_to_santas (santa)
                get_help (santa)
                come_back (santa)
                random_sleep (1) -- time spent to come back
            end
        end

    build_toy: BOOLEAN
            -- The elf tries to build a toy.
            -- Returns true if the elf succeeds in building,
            -- false otherwise.
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
            -- The elf goes to Sants's to ask for help.
            -- The elf must wait for santa not to be busy.
        require
            not s.is_busy
        do
            s.enqueue_elf (id)
        end

    get_help (s: separate SANTA)
            -- Santa helps the elf.
            -- In order to get help, the elf must
            -- wait for Santa to be busy.
        require
            s.is_busy
        do
            served := no_build_failures = max_build_failures
        end

    come_back (s: separate SANTA)
            -- The elf comes back.
        do
            s.dequeue_elf (id)
        end

feature {NONE} -- Access

    santa : separate SANTA

feature -- Elf's internal state

    served: BOOLEAN
        -- Says if this elf has reached the maximum bumber
        -- of times he can ask Santa to help.

    no_build_failures: INTEGER
        -- How many times the elf has failed while
        -- building a toy.

invariant
    no_build_failures >= 0
    no_build_failures <= max_build_failures

end
