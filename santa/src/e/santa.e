class
    SANTA

create
    make

feature -- Santa Initialization.

    make (e, r: INTEGER)
            -- Creation Procedure.
        do
            max_elves := e
            max_reindeers := r
        end

feature
        -- Makes santa available to start serving elves and reindeers.
    open
        do
            is_open := TRUE
        end

feature {ELF} -- Elf Consumed Procedures.

    enqueue_elf (eid: INTEGER)
        require
            no_elves < max_elves
        do
            no_elves := no_elves + 1
            trace ("elf" + eid.out, "in")

            if is_xmas or no_elves = max_elves then
                help_elves
            end
        ensure
        	no_elves = old no_elves + 1
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
        ensure
        	no_elves = old no_elves - 1
        end

feature {REINDEER} -- Reindeer Comsumed Procedures

    enqueue_reindeer (rid: INTEGER)

            -- Santa adds the reindeer identified by "rid" to the set of arrived reindeers. 
            -- If all the reindeers arrived, santa prepares the sliegh.
        require
            no_reindeers < max_reindeers
        do
            no_reindeers := no_reindeers + 1
            trace ("rnd" + rid.out, "in")

            if no_reindeers = max_reindeers then
                trace ("santa", "prepare_sleigh")
                prepare_sleigh
            end
        ensure
        	no_reindeers = old no_reindeers + 1
        end

    hitch (rid: INTEGER)

            -- Santa hitch the reindeer identified by "rid". After all the reindeers has been hitched santa leaves.
        do
            no_hitched_reindeers := no_hitched_reindeers + 1
            trace ("rnd" + rid.out, "hitched")

            if no_hitched_reindeers = max_reindeers then
                is_xmas := true
                trace ("santa", "xmas")
                help_elves
            end
        ensure
        	no_hitched_reindeers = old no_hitched_reindeers + 1
        end

feature {NONE} -- Internal Procedures

    help_elves

            -- Santa helps the set of waiting elves. While heling santa appears as budy to toher incoming elves.
        do
            if is_xmas then
                trace ("santa", "force_help")
            else
                trace ("santa", "help")
            end

            is_busy := true
        ensure
            is_busy
        end

    prepare_sleigh

            -- Prepare the sleigh when all the running reindeers arrived. After that santa is "ready" to start hitching reindeers.
        do
            is_ready := true
        ensure
            is_ready
        end

feature {NONE} -- Logging 

    trace (actor, event: STRING)
            -- Util procedure to print log traces.
        do
            io.put_string (actor + "." + event + "%N")
        end

feature -- Santa's status

        -- Says if santa is busy in helping a batch of elves.
    is_busy: BOOLEAN

        -- Says if is Christmas or not according to the number of arrived reindeers.
    is_xmas: BOOLEAN

        -- Says if santa is available to start serving elves and reindeers.
    is_open: BOOLEAN

        -- During the execution says how  many reindeers arrived.
    no_reindeers: INTEGER

        -- During the execution says how many reindeers have been hitched.
    no_hitched_reindeers: INTEGER

        -- Says how many reindeers are running in the system.
    max_reindeers: INTEGER

        -- Says is santa is ready to start hitching reindeers.
    is_ready: BOOLEAN

        -- During the execution says how many elves are waiting to be helped.
    no_elves: INTEGER

        -- Says the maximum number of elves to be waiting before santa starts helping them.
    max_elves: INTEGER

invariant
    no_elves >= 0 and no_elves <= max_elves
    no_reindeers >= 0 and no_reindeers <= max_reindeers

end
