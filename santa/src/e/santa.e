note
    description : "[
        Class that represents the behavior of Santa Claus.
        Santa represents the shared resource among elves and
        reindeers. It passes through different states that can be
        derived from the composition of boolean variables
        in SANTA's internal state.
    ]"
    author      : "Michele Guerriero and Lorenzo Affetti"

class
    SANTA

create
    make

feature -- Santa initialization

    make (e, r: INTEGER)
            -- Creation procedure.
        do
            max_elves := e
            max_reindeers := r
        end

feature {ELF} -- Elf-accessible commands

    enqueue_elf (eid: INTEGER)
            -- Adds an elf to the ones waiting on the threshold.
            -- If the number reaches the batch size, Santa wakes up.
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
            -- This command has to be invoked by an ELF when
            -- he/she wants to go back (after being helped).
            -- When the last elf has been dequeued, Santa is no
            -- more "busy".
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

feature {REINDEER} -- Reindeer-accessible commands

    enqueue_reindeer (rid: INTEGER)
            -- Adds a reindeer to the ones waiting in the hut.
            -- If all the reindeers have arrived, Santa prepares the sleigh.
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
            -- Command invoked by a REINDEER when all of them are at Santa's.
            -- After all of the reindeers have been hitched, Santa leaves
            -- and starts distributing awesome presents to children.
        require
            is_ready
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

feature {NONE} -- Internal behavior

    help_elves
            -- Santa helps the batch of waiting elves.
            -- This makes Santa "busy".
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
            -- Prepare the sleigh when all the reindeers arrived.
            -- This makes Santa "ready" to hitch reindeers.
        do
            is_ready := true
        ensure
            is_ready
        end

feature {NONE} -- Logging

    trace (actor, event: STRING)
            -- Prints log traces.
        do
            io.put_string (actor + "." + event + "%N")
        end
feature
    -- Attributes used to query Santa's state
    -- (to be used in waiting conditions).

    is_busy: BOOLEAN
        -- Santa is busy in helping a elves.

    is_xmas: BOOLEAN
        -- It is Christmas or not, i.e. everything is over.

    is_ready: BOOLEAN
        -- Says is santa is ready to start hitching reindeers.

feature -- Access

    no_reindeers: INTEGER
        -- How many reindeers have been enqueued.

    no_hitched_reindeers: INTEGER
        -- How many reindeers have been hitched.

    max_reindeers: INTEGER

    no_elves: INTEGER
        -- How many elves are waiting to be helped.

    max_elves: INTEGER

invariant
    no_elves >= 0 and no_elves <= max_elves
    no_reindeers >= 0 and no_reindeers <= max_reindeers

end
