class HANDLER2

inherit STRATEGY

create
    make

feature
    make (r: RESOURCE)
        require
            r /= Void
        do
            father := r
        end

feature
    father: RESOURCE
    no_call: INTEGER

    f (id: INTEGER)
        local
            l_strat: HANDLER1
        do
            log(id, "f_handler2")
            no_call := no_call + 1

            if no_call = 5 then
                -- changing strategy
                create l_strat.make (father)
                father.set_strategy (l_strat)
                log(id, "strategy_change")
            end
        end

    f_cond (id: INTEGER): BOOLEAN
        do
            Result := id \\ 2 = 1
        end

end
