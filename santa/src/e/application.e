note
    description : "System's root class"
    author      : "Michele Guerriero"
    date        : "2016/05/30"
    reviewer    : "Lorenzo Affetti"
    revision    : "1.0.1"

class
    APPLICATION

create
    make

feature -- System initialization.

    make 
            -- Creation procedure.
        local
            i: INTEGER
            e: separate ELF
            r: separate REINDEER
        do
                -- make santa setting the elves batch size and the number of reindeers
            create santa.make (elves_batch_size, no_reindeers) 

                -- make all reindeers and launch them
            from 
                i := 1
            until
                i > no_reindeers
            loop
                create r.make (i, santa)
                launch_reindeer (r)
                i := i + 1
            end

                -- make all elves and launch them
            from 
                i := 1
            until
                i > no_elves
            loop
                create e.make (i, no_failures, santa)
                launch_elf (e)
                i := i + 1
            end

                -- open santa to enable reindeers and elves to start living
            separate santa as s do
                s.open
            end
        end

    launch_elf (e: separate ELF)
            -- Procedure to launch an elf in a controlled manner.
        do
            e.live
        end

    launch_reindeer (r: separate REINDEER)
            -- Procedure to launch a reindeer in a controlled manner.
        do
            r.live
        end

feature {NONE} -- Configuration parameters

    santa: separate SANTA
        -- The instance of SANTA which serves elves and reindeer

    no_reindeers: INTEGER = 9 
        -- The number of reindeers in the system

    no_elves: INTEGER = 20 -- Could be anything
        -- The number of elves in the system

    elves_batch_size: INTEGER = 3
        -- How many elves have to be waiting in order to make santa helping them

    no_failures: INTEGER = 2
        -- How many times an elf can fail a toy build and ask for santa's help

end
