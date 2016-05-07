class HANDLER1

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
    no_calls: INTEGER

    f (id: INTEGER)
        local
            l_strat: HANDLER2
        do
            log(id, "f_handler1")
            no_calls := no_calls + 1

            if no_calls = 10 then
                -- changing strategy
                create l_strat.make (father)
                father.set_strategy (l_strat)
                log(id, "strategy_change")
            end
        end

    f_cond (id: INTEGER): BOOLEAN
        do
            Result := id \\ 2 = 0
        end

end
