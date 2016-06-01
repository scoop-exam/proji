note
    description : "Class that represents the behavior of a reindeer."
    author      : "Michele Guerriero and Lorenzo Affetti"

class
    REINDEER

inherit
    PROCESS

create
    make

feature -- Reindeer initialization

    make (i: INTEGER; s: separate SANTA)
            -- Creation procedure
        do
            id := i
            santa := s
            setup
        end

feature {NONE} -- Reindeer's lifecycle implementation

    over: BOOLEAN
        do
            Result := at_santas
        end

    step
            -- Reindeer's lifecycle:
            --   a) go to santa;
            --   b) when the last reindeer comes,
            --      get hitched to the sleigh;
            --   c) help Santa in making kids happy.
        do
            if wake_up then
                random_sleep (10) -- the reindeer is sunbathing
                go_to_santas (santa)
                get_hitched (santa)
            end
        end

    wake_up: BOOLEAN
        do
            Result := choice
        end

    go_to_santas (s: separate SANTA)
            -- After waking up, a reindeer goes to santa.
        require
            not at_santas
        do
            s.enqueue_reindeer (id)
            at_santas := true
        ensure
            at_santas
        end

    get_hitched (s: separate SANTA)
            -- A reindeer asks Santa to be hitched.
            -- First it has to wait for Santa to be ready,
            -- i.e. for all the other reindeers to be at Santa's.
        require
            s.is_ready
        do
            s.hitch (id)
        end

feature {NONE} -- Reindeer's internal state

    santa : separate SANTA

    at_santas: BOOLEAN

end
