class RESOURCE

inherit
    STRATEGY

create
    make

feature
    make
        local
            l_s: HANDLER1
        do
            -- pass current object
            -- to enable the setting of current strategy
            create l_s.make (Current)
            strategy := l_s
        end

feature -- Accessibility
    can_start: BOOLEAN

    start
        do
            can_start := true
        end

feature
    strategy: STRATEGY -- a reference to the current strategy

    set_strategy (s: STRATEGY)
        require
            s /= Void
        do
            strategy := s
        end

    -- delegation to current strategy
    f (id: INTEGER)
        do
            strategy.f (id)
        end

    f_cond (id: INTEGER): BOOLEAN
        do
            Result := strategy.f_cond (id)
        end

end
