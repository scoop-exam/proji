deferred class
    PROCESS

feature {NONE}

feature
    live
        do
            from until
                over
            loop
                step
            end
            wrapup
        end

feature {NONE} -- Lifecycle
    setup
        local
            l_time: TIME
            l_seed: INTEGER
        do
            create l_time.make_now
            l_seed := l_time.milli_second
            create rnd_seq.set_seed (l_seed)
        end

    over: BOOLEAN
            -- Should execution terminate now?
        deferred
        end

    step
    	require
			check_application(application)
        deferred
        end

    wrapup
        do
        end

feature
	check_application (a: separate APPLICATION) : BOOLEAN
		do
			rESULT := a.is_launched
		end

feature {NONE}
    rnd_seq: RANDOM
    id: STRING
    application: separate APPLICATION

    say (sentence: STRING)
        do
            io.put_string (id + " -- " + sentence + "%N")
        end

    choice: BOOLEAN
            -- Use this feature to perform
            -- random choices.
        local
            l_res: INTEGER
        do
            rnd_seq.forth
            l_res := rnd_seq.item \\ 2

            -- TODO find a more Eiffel idiomatic way, please
            if l_res = 0 then
                Result := false
            else
                Result := true
            end
        end

invariant
    rnd_seq_attached: rnd_seq /= Void
    id_attached: id /= Void

end
