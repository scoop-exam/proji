class
    SANTA

create
    make

feature
    make (e, r: INTEGER)
        do
            max_elves := e
            max_reindeers := r
        end

feature
    is_busy: BOOLEAN
    is_xmas: BOOLEAN
    is_open: BOOLEAN

feature
    open
        do
            is_open := TRUE
        end

feature {ELF}
    no_elves: INTEGER
    max_elves: INTEGER

    enqueue_elf
        require
            no_elves < max_elves
        do
            no_elves := no_elves + 1

            if is_xmas or no_elves = max_elves then
                help_elves
            end

            if is_xmas then
                say ("A fucking elf that was coming during Christmas is arrived! Let me help hime immediately...")
            end
        end

    dequeue_elf
        require
            no_elves > 0
        do
            no_elves := no_elves - 1

            if no_elves = 0 then
                is_busy := false
                say ("no more elves to help, back to sleep...")
            end
        end

feature {REINDEER}
    no_reindeers: INTEGER
    no_hitched_reindeers: INTEGER
    max_reindeers: INTEGER
    is_ready: BOOLEAN

    enqueue_reindeer
        require
            no_reindeers < max_reindeers
        do
            no_reindeers := no_reindeers + 1

            if no_reindeers = max_reindeers then
                say ("all reindeers are here, preparing sleigh...")
                prepare_sleigh
            end
        end

    hitch
        do
            say ("hitching reindeer...")
            no_hitched_reindeers := no_hitched_reindeers + 1

            if no_hitched_reindeers = max_reindeers then
                is_xmas := true
                say ("Let's go and spread some gifts guys!")
                say ("But first, let me help those fuckin' " + no_elves.out + " elves outside...and the other that are coming!")
                help_elves
            end
        end

feature {NONE}
    help_elves
        do
            say ("helping elves!")
            is_busy := true
        end

    prepare_sleigh
        do
            say ("sleigh prepared!")
            is_ready := true
        end

    say (sentence: STRING)
        do
            io.put_string ("SANTA -- Oh oh oh, " + sentence + "%N")
        end

invariant
    no_elves >= 0 and no_elves <= max_elves
    no_reindeers >= 0 and no_reindeers <= max_reindeers

end
