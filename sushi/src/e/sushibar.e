class SUSHIBAR

create
    make

feature
    make (seats: INTEGER)
        require
            seats >= 0
        do
            no_seats := seats
            can_seat := true
        end

feature
    is_open: BOOLEAN

feature {APPLICATION}
    open
        require
            not is_open
        do
            is_open := true
        end

feature {CUSTOMER}
    no_customers: INTEGER
    no_seats: INTEGER
    can_seat: BOOLEAN

    is_empty: BOOLEAN
        do
            Result := no_customers = 0
        end

    is_full: BOOLEAN
        do
            Result := no_customers = no_seats
        end

    have_a_seat (cid: INTEGER)
        require
            can_seat
        do
            no_customers := no_customers + 1
            log (cid, "seat(" + no_customers.out + ")")

            if is_full then
                log (cid, "FULL")
                can_seat := false
            end
        ensure
            no_customers > old no_customers
        end

    leave (cid: INTEGER)
        require
            no_customers > 0
        do
            no_customers := no_customers - 1
            log (cid, "leave(" + no_customers.out + ")")

            if not can_seat and is_empty then
                can_seat := true
            end
        ensure
            no_customers < old no_customers
        end

feature {NONE} -- Utils
    log (id: INTEGER; event: STRING)
        do
            io.put_string (id.out + "." + event + "%N")
        end

invariant
    no_customers >= 0 and no_customers <= no_seats

end
