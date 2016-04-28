class EMPLOYEE

inherit
    EXECUTION_ENVIRONMENT

create
    make

feature
    make (s: BOOLEAN; b: separate BATHROOM)
            -- True for woman, false for man
        require
            b /= Void
        local
            l_time: TIME
            l_seed: INTEGER
        do
            sex := s
            bathroom := b

            create l_time.make_now
            l_seed := l_time.milli_second
            create rnd.set_seed (l_seed)
        end

feature
    run
        do
            can_start (bathroom)

            enter (bathroom)
            xxx
            leave (bathroom)
        end

feature {NONE} -- Lifecycle
    sex: BOOLEAN
    bathroom: separate BATHROOM
    at_bath: BOOLEAN

    rnd: RANDOM

    can_start (b: separate BATHROOM)
        require
            b.is_open
        do
            -- does nothing
        end

    enter (b: separate BATHROOM)
        require
            not at_bath
            b.can_enter (sex)
        do
            b.enter (sex)
            at_bath := true
        end

    xxx
        -- Does what the employee wants to do at bathroom
        do
            rnd.forth
            sleep ((rnd.item \\ 10) * 1000)
        end

    leave (b: separate BATHROOM)
            -- Leaves the bathroom.
        require
            at_bath
        do
            b.leave (sex)
            at_bath := false
        end

invariant
    rnd /= Void
    bathroom /= Void

end
