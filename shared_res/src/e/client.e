class CLIENT

create
    make

feature
    id: INTEGER
    res: separate RESOURCE

    make (i: INTEGER; r: separate RESOURCE)
        do
            id := i
            res := r
        end

    run
        do
            wait_for_start (res)
            f (res)
        end

    wait_for_start (r: separate RESOURCE)
        require
            r.can_start
        do
            -- waits
        end

    f (r: separate RESOURCE)
        require
            r.f_cond (id)
        do
            r.f (id)
        end

end
