class APPLICATION

create
    make

feature
    no_cli: INTEGER = 100

    make
        local
            i: INTEGER
            res: separate RESOURCE
            cli: separate CLIENT
        do
            create res.make

            from
                i := 0
            until
                i > no_cli - 1
            loop
                create cli.make (i, res)
                separate cli as c do
                    c.run
                end

                i := i + 1
            end

            separate res as r do
                r.start
            end
        end

end
