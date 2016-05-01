class
    ELF

inherit
    PROCESS

create
    make

feature
    make (i, bf: INTEGER; s: separate SANTA)
        require
            s /= Void
            bf >= 1
        do
            id := "elf" + i.out
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
                say ("Problem with a toy... Going to Santa's...")
                go_to_santas (santa)
                say ("Waiting for Santa's help...")
                get_help (santa)
                say ("Thank you Santa! Back to the warehouse!")
                come_back (santa)
            end
            --say ("everything ok with toys")
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
        end

    go_to_santas (s: separate SANTA)
        require
            not s.is_busy
        do
            s.enqueue_elf
        end

    get_help (s: separate SANTA)
        require
            s.is_busy
        do
            served := no_build_failures = max_build_failures
        end

    come_back (s: separate SANTA)
        do
            s.dequeue_elf
        end

feature {NONE}
    served: BOOLEAN

invariant
    no_build_failures >= 0
    no_build_failures <= max_build_failures

end
