class CUSTOMER

inherit
    EXECUTION_ENVIRONMENT

create
    make

feature
    make (i, iter: INTEGER; b: separate SUSHIBAR)
        require
            i >= 0
            b /= Void
        local
            l_time: TIME
            l_seed: INTEGER
        do
            id := i
            sushibar := b

            create l_time.make_now
            l_seed := l_time.milli_second
            create rnd.set_seed (l_seed)
        end

feature
    run
        do
            sushibar_open (sushibar)

            go_eat (sushibar)
            eat
            come_back (sushibar)
        end

feature {NONE} -- Lifecycle
    id: INTEGER
    sushibar: separate SUSHIBAR
    at_bar: BOOLEAN

    rnd: RANDOM

    sushibar_open (sb: separate SUSHIBAR)
        require
            sb.is_open
        do
            -- does nothing
        end

    go_eat (sb: separate SUSHIBAR)
        require
            not at_bar
            sb.can_seat
        do
            sb.have_a_seat (id)
            at_bar := true
        end

    eat
        -- eats
        do
            rnd.forth
            sleep ((rnd.item \\ 10) * 1000)
        end

    come_back (sb: separate SUSHIBAR)
            -- Leaves the sushibar.
        require
            at_bar
        do
            sb.leave (id)
            at_bar := false
        end

invariant
    rnd /= Void
    sushibar /= Void

end
