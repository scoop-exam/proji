note
    description : "System's root class."
    author      : "Michele Guerriero and Lorenzo Affetti"

class
    APPLICATION

inherit
    ARGUMENTS

create
    make

feature -- System initialization

    make
            -- Creation procedure.
        do
            if parse_args then
                print_params
                init
            else
                print_help
            end
        end

    parse_args: BOOLEAN
        do
            if attached separate_character_option_value('h') as h then
                Result := False
            else
                if attached separate_character_option_value('r') as r then
                    no_reindeers := r.to_integer.abs
                else
                    no_reindeers := 9
                end

                if attached separate_character_option_value('e') as e then
                    no_elves := e.to_integer.abs
                else
                    no_elves := 20
                end

                if attached separate_character_option_value('b') as b then
                    elves_batch_size := b.to_integer.abs
                else
                    elves_batch_size := 3
                end

                if attached separate_character_option_value('f') as f then
                    no_failures := f.to_integer.abs
                else
                    no_failures := 2
                end

                Result := True
            end
        end

    init
        local
            i: INTEGER
            e: separate ELF
            r: separate REINDEER
            santa: separate SANTA
        do
            create santa.make (elves_batch_size, no_reindeers)

                -- Make all reindeers and launch them.
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

                -- Make all elves and launch them.
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

    no_reindeers: INTEGER
        -- The number of reindeers in the system (defaults to 9).

    no_elves: INTEGER
        -- The number of elves in the system (defaults to 20).

    elves_batch_size: INTEGER
        -- The number of elves to reach to make
        -- santa wake up and help them (defaults to 3).

    no_failures: INTEGER
        -- How many times an elf can fail while
        -- building a toy and ask Santa to help him/her (defaults to 2)

    print_help
        local
            help: STRING
        do
            help := "[
Launches the Santa Claus problem.
The available options are:
    -h      Displays this help message

    -r      The number of reindeers
    -e      The number of elves
    -b      The batch size for elves
    -f      The maximum number of failures for each elf
            ]"
            io.put_string(help + "%N")
        end

    print_params
        do
            io.put_string("%T#reindeers: " + no_reindeers.out + "%N")
            io.put_string("%T#elves: " + no_elves.out + "%N")
            io.put_string("%Tbatch size: " + elves_batch_size.out + "%N")
            io.put_string("%T#failures: " + no_failures.out + "%N%N")
        end

end
