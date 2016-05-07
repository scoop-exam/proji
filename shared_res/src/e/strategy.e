deferred class
    STRATEGY

feature
    -- each feature has a respective
    -- waiting condition

    f (id: INTEGER)
        deferred
        end

    f_cond (id: INTEGER): BOOLEAN
        deferred
        end

    -- other features and respective conditions

feature {NONE}
    log (id: INTEGER; event: STRING)
        do
            io.put_string ("cli" + id.out + "." + event + "%N")
        end
end
