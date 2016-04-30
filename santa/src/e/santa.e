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

feature {ELF}
    no_elves: INTEGER
    max_elves: INTEGER

    enqueue_elf
        require
            no_elves < max_elves
        do
            no_elves := no_elves + 1

            if no_reindeers = max_reindeers then
                -- should never happen
                say ("ONCE IN A BLUE MOON")
            elseif no_elves = max_elves then
                help_elves
            end
        end

    dequeue_elf
        require
            no_elves > 0
        do
            no_elves := no_elves - 1

			say ("An elf helped!")
            if no_elves = 0 then
            	is_busy := FALSE
                say ("no more elves to help...")
                if is_xmas then
					say ("Let's go!")
                else
                	say ("Back to sleep...")
                end
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
                is_ready := true
            end
        end

    hitch
        do
            say ("hitching reindeer...")
            no_hitched_reindeers := no_hitched_reindeers + 1

            if no_hitched_reindeers = max_reindeers then
                is_xmas := true
                say ("Let's go and spread some gifts guys!")
                if no_elves > 0 then
                	say ("But first, let me help those fuckin' remaining " + no_elves.out + " elves outside...")
                	help_elves
                end
            end
        end

feature {NONE}
    help_elves
        do
            is_busy := true
            say ("helping elves!")
        end

    prepare_sleigh
        do
            say ("sleigh prepared!")
        end

    say (sentence: STRING)
        do
            io.put_string ("SANTA -- Oh oh oh, " + sentence + "%N")
        end

invariant
    no_elves >= 0 and no_elves <= max_elves
    no_reindeers >= 0 and no_reindeers <= max_reindeers

end
