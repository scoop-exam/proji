class BATHROOM

create
    make

feature
    make (capacity: INTEGER)
        require
            capacity > 0
        do
            max_people := capacity
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

feature {EMPLOYEE}
    max_people: INTEGER
    no_women, no_men: INTEGER
    no_people: INTEGER
        do
            Result := no_women + no_men
        end

    can_enter (sex: BOOLEAN): BOOLEAN
            -- True for women, false for men
        do
            Result := not is_full and ((not sex and not woman_in) or (sex and not man_in))
        end

    man_in: BOOLEAN
        do
            Result := no_men > 0
        end

    woman_in: BOOLEAN
        do
            Result := no_women > 0
        end

    is_empty: BOOLEAN
        do
            Result := no_people = 0
        end

    is_full: BOOLEAN
        do
            Result := no_people = max_people
        end

    enter (sex: BOOLEAN)
        require
            can_enter (sex)
        do
            if sex then
                no_women := no_women + 1
            else
                no_men := no_men + 1
            end

            log (sex, "in")
        ensure
            no_people > old no_people
        end

    leave (sex: BOOLEAN)
        require
            no_people > 0
        do
            if sex then
                no_women := no_women - 1
            else
                no_men := no_men - 1
            end

            log (sex, "out")
        ensure
            no_people < old no_people
        end

feature {NONE} -- Utils
    log (sex: BOOLEAN; event: STRING)
        do
            if sex then
                io.put_string ("woman." + event + "(" + no_people.out + ")%N")
            else
                io.put_string ("man." + event + "(" + no_people.out + ")%N")
            end
        end

invariant
    no_people >= 0 and no_people <= max_people
    no_same_sex: is_empty or (man_in = not woman_in)

end
