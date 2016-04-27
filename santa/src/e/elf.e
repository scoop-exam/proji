class
    ELF

-- inherit
--    PROCESS

create
    make

feature
    make (name: STRING)
        do
            id := name
        end

    hello
        do
            io.put_string (id + " -- Hello world!%N")
        end

feature {NONE}
    id: STRING

end
