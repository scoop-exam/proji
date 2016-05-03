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

    enqueue_elf (eid: INTEGER)
        require
            no_elves < max_elves
        do
            no_elves := no_elves + 1
            trace ("elf" + eid.out, "in")

            if is_xmas or no_elves = max_elves then
                help_elves
            end
        end

    dequeue_elf (eid: INTEGER)
        require
            no_elves > 0
        do
            no_elves := no_elves - 1
            trace ("elf" + eid.out, "out")

            if no_elves = 0 then
                is_busy := false
                trace ("santa", "sleep")
            end
        end

feature {REINDEER}
    no_reindeers: INTEGER
    no_hitched_reindeers: INTEGER
    max_reindeers: INTEGER
    is_ready: BOOLEAN

    enqueue_reindeer (rid: INTEGER)
        require
            no_reindeers < max_reindeers
        do
            no_reindeers := no_reindeers + 1
            trace ("rnd" + rid.out, "in")

            if no_reindeers = max_reindeers then
                trace ("santa", "prepare_sleigh")
                prepare_sleigh
            end
        end

    hitch (rid: INTEGER)
        do
            no_hitched_reindeers := no_hitched_reindeers + 1
            trace ("rnd" + rid.out, "hitched")

            if no_hitched_reindeers = max_reindeers then
                is_xmas := true
                trace ("santa", "xmas")
                help_elves
            end
        end

feature {NONE}
    help_elves
        do
            if is_xmas then
                trace ("santa", "force_help")
            else
                trace ("santa", "help")
            end

            is_busy := true
        end

    prepare_sleigh
        do
            is_ready := true
        end

    trace (actor, event: STRING)
        do
            io.put_string (actor + "." + event + "%N")
        end

invariant
    no_elves >= 0 and no_elves <= max_elves
    no_reindeers >= 0 and no_reindeers <= max_reindeers

end
