class
    APPLICATION

create
    make

feature -- Initialization

    make
        local
            i: INTEGER
            r : separate REINDEER
            e : separate ELF
            s : separate SANTA
        do
            io.put_string (">>> BEGIN%N")

            create s.make
            s.hello

            from
                i := 1
            until
                i > no_elves
            loop
                io.put_string (">>> Launching elf%N")
                create e.make ("elf" + i.out)
                e.hello
                i := i + 1
            end

            from
                i := 1
            until
                i > no_reindeers
            loop
                io.put_string (">>> Launching reindeer%N")
                create r.make ("rnd" + i.out)
                r.hello
                i := i + 1
            end

            io.put_string (">>> END%N")
        end

feature
    no_reindeers: INTEGER = 9 -- Is fixed
    no_elves: INTEGER = 20 -- Could be anything
    max_elves: INTEGER = 3

end
