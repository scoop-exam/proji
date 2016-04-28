class APPLICATION

create
    make

feature
    make
        local
            i: INTEGER
            l_b: separate BATHROOM
            l_e: separate EMPLOYEE
        do
            create l_b.make (capacity)

            from
                i := 0
            until
                i > no_women - 1
            loop
                create l_e.make (true, l_b)
                separate l_e as e do
                    e.run
                end
                i := i + 1
            end

            from
                i := 0
            until
                i > no_men - 1
            loop
                create l_e.make (false, l_b)
                separate l_e as e do
                    e.run
                end
                i := i + 1
            end

            -- start the program
            separate l_b as b do
                b.open
            end
        end

feature {NONE}
    capacity: INTEGER = 3
    no_men: INTEGER = 10
    no_women: INTEGER = 10

end
