local phys
local trans

Speed = 5.0

function on_init()
    phys = get_physicsbody(scene, this)
    trans = get_transform(scene, this)
end


function get_dir(angle)
    return vec3:new(math.sin(angle), 0, math.cos(angle))
end


function on_update(dt)
    -- get input
    local f = Is_key(util.KeyboardKey.UP) - Is_key(util.KeyboardKey.DOWN)
    local r = Is_key(util.KeyboardKey.RIGHT) - Is_key(util.KeyboardKey.LEFT)

    -- jump when grounded
    if is_key_down(util.KeyboardKey.SPACE) and phys.move_delta.y == 0.0 then
        local jump_force = 5.0
        phys.velocity.y = jump_force
    end

    local angle = math.rad(trans:rotation().y)
    local right_angle = math.rad(trans:rotation().y + 90)

    local forward = get_dir(angle)
    local right =   get_dir(right_angle)


    local move = (forward * f) + (right * -r)

    if is_key_down(util.KeyboardKey.D) then
        phys.is_solid = false
        phys.gravity = phys.gravity * 5
        return
    end

    if is_key_clicked(util.KeyboardKey.P) then
        log_info("Pos: {}", trans:position())
    end


    phys.velocity = phys.velocity +  move * Speed * dt
end


-- convert from bool to int
function Is_key(key)
    return is_key_down(key) and 1 or 0
end

