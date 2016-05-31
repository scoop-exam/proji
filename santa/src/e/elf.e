note
    description : "System's root class"
    author      : "Michele Guerriero"
    date        : "2016/05/30"
    reviewer    : "Lorenzo Affetti"
    revision    : "1.0.1"

class
    ELF

inherit
    PROCESS

create
    make

            
feature -- Elf Initialization.

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

feature {NONE} -- Elf's implementation

        -- The maximum number of times an elf can ask for santa's help.
    max_build_failures: INTEGER

    over: BOOLEAN
            -- Procedure to decide when to kill an elf. 
            -- Returns true when is Christmas (and then santa has left) or the elf has reached the maximum number of build failures.
        do
            separate santa as s do
                Result := served or s.is_xmas
            end
        end

    step
            -- Procedure to be iterated in order to implement the elf life cycle. 
            -- At each iteration the elf tries to build a toy and if he fails:
            -- a) the elf go to santa asking for help
            -- b) the elf receive santa's help
            -- c) the elf come back to the warehouse
        do
            if not build_toy then
            	random_sleep (1)
                go_to_santas (santa)
                get_help (santa)
                come_back (santa)
                random_sleep (1)
            end
        end

    build_toy: BOOLEAN

            -- The elf try to build a toy ending in a success or a failure.
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

            -- The elf asks for santa's help. He waits for santa to not be busy in helping other elves.
        require
            not s.is_busy
        do
            s.enqueue_elf (id)
        end

    get_help (s: separate SANTA)

            -- The elf receives santa's help. He waits for the minumum waiting elves in order to make santa help them to be reached.
        require
            s.is_busy
        do
            served := no_build_failures = max_build_failures
        end

    come_back (s: separate SANTA)

            -- Procedure to dequeue an elf from santa, after the elf has been helped.
        do
            s.dequeue_elf (id)
        end

feature -- Elf's status

        -- Says if the current elf has reached the maximum bumber of times he can ask for santa's help.
    served: BOOLEAN

        -- During the execution this tells how many time the current elf has asked for santa's help.
    no_build_failures: INTEGER

invariant
    no_build_failures >= 0
    no_build_failures <= max_build_failures

end
