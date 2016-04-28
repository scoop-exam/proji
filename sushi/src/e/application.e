class APPLICATION

create
    make

feature
    make
        local
            i: INTEGER
            l_sb: separate SUSHIBAR
            l_c: separate CUSTOMER
        do
            create l_sb.make (no_seats)

            from
                i := 0
            until
                i >= no_customers - 1
            loop
                create l_c.make (i, max_iter, l_sb)
                separate l_c as c do
                    c.run
                end
                i := i + 1
            end

            -- start the program
            separate l_sb as sb do
                sb.open
            end
        end

feature {NONE}
    max_iter: INTEGER = 5 -- the number of times a customer will eat
    no_seats: INTEGER = 5 -- the number of seats available at the sushibar
    no_customers: INTEGER = 10 -- the number of total customers

end
