class CUSTOMER

create
    make

feature
    make (i, iter: INTEGER; b: separate SUSHIBAR)
        require
            i >= 0
            b /= Void
        do
            id := "c" + i.out
            max_iter := iter
            sushibar := b
        end

feature
    run
        do
            from
                sushibar_open (sushibar)
            until
                over
            loop
                -- acquire exclusive access
                -- to the sushibar and decide
                -- the different precondition
                separate sushibar as sb do
                    if sb.is_full then
                        go_eat_when_empty (sb)
                    else
                        go_eat_now (sb)
                    end
                end
                come_back (sushibar)
                no_iter := no_iter + 1
            end
        end

feature {NONE} -- Lifecycle
    id: STRING
    no_iter, max_iter: INTEGER
    sushibar: separate SUSHIBAR
    at_bar: BOOLEAN

    sushibar_open (sb: separate SUSHIBAR)
        require
            sb.is_open
        do
            -- does nothing
        end

    over: BOOLEAN
            -- Finish execution?
        do
            Result := no_iter >= max_iter
        end

    go_eat_when_empty (sb: separate SUSHIBAR)
            -- Goes to eat only when the bar
            -- is totally empty.
            -- This should be called when the bar
            -- is found totally full
        require
            not at_bar
            sb.is_empty
        do
            eat (sb)
        end

    go_eat_now (sb: separate SUSHIBAR)
            -- Goes to eat immediately.
            -- This should be called only
            -- when the bar is not totally full
        require
            not at_bar
            not sb.is_full
        do
            eat (sb)
        end

    come_back (sb: separate SUSHIBAR)
            -- Leaves the sushibar.
        require
            at_bar
        do
            sb.leave
            at_bar := false
            log (at_bar)
        end

feature {NONE} -- Utils
    log (sl: BOOLEAN)
        do
            if sl then
                io.put_string (id + "." + "seat%N")
            else
                io.put_string (id + "." + "leave%N")
            end
        end

    eat (sb: separate SUSHIBAR)
            -- Accessor to have a seat at
            -- the sushibar
        do
            sb.have_a_seat
            at_bar := true
            log (at_bar)
        end

invariant
    no_iter >= 0 and no_iter <= max_iter

end
