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
            id := "reindeer" + i.out
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
                say ("Awaken, let's go!")
                go_to_santas (santa)
                say ("Waiting to get hitched...")
                get_hitched (santa)
            end
        end

    wake_up: BOOLEAN
        do
            Result := choice
        end

    go_to_santas (s: separate SANTA)
        do
            s.enqueue_reindeer
            at_santas := true
        end

    get_hitched (s: separate SANTA)
        require
            s.is_ready
        do
            s.hitch
        end

feature {NONE}
    at_santas: BOOLEAN

end
