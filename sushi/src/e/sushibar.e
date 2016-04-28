class SUSHIBAR

create
    make

feature
    make (seats: INTEGER)
        require
            seats >= 0
        do
            no_seats := seats
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

    is_empty: BOOLEAN
        do
            Result := no_customers = 0
        end

    is_full: BOOLEAN
        do
            Result := no_customers = no_seats
        end

    have_a_seat
        require
            no_customers < no_seats
        do
            no_customers := no_customers + 1
        ensure
            no_customers > old no_customers
        end

    leave
        require
            no_customers > 0
        do
            no_customers := no_customers - 1
        ensure
            no_customers < old no_customers
        end

invariant
    no_customers >= 0 and no_customers <= no_seats

end
