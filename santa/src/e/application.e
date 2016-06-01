note
    description : "System's root class."
    author      : "Michele Guerriero and Lorenzo Affetti"

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
            create santa.make (elves_batch_size, no_reindeers)

                -- make all reindeers and launch them
            from
                i := 1
            until
                i > no_reindeers
            loop
                create r.make (i, santa)
                separate r as sr do
                    sr.live
                end
                i := i + 1
            end

                -- make all elves and launch them
            from
                i := 1
            until
                i > no_elves
            loop
                create e.make (i, no_failures, santa)
                separate e as se do
                    se.live
                end
                i := i + 1
            end
        end

feature {NONE} -- Configuration parameters

    santa: separate SANTA
        -- The instance of SANTA which serves elves and reindeers

    no_reindeers: INTEGER = 9
        -- The number of reindeers in the system

    no_elves: INTEGER = 20
        -- The number of elves in the system

    elves_batch_size: INTEGER = 3
        -- The number of elves to reach to make
        -- santa wake up and help them

    no_failures: INTEGER = 2
        -- How many times an elf can fail while
        -- building a toy build and ask Santa to help him/her

end
