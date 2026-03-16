local t
local cm

local speed = initial_speed
local sensi = 0.1
local mouse_delta
local velocity

first = true

initial_speed = 3


function on_init()
    t  = get_transform(scene, this)
    cm = get_camera(scene, this)
end

function on_update(dt)
    
    speed = initial_speed
    if first then
        mouse_delta = get_mouse_delta() * -sensi; first = false
    end

    velocity = vec3.new(0.0)

    local f = is_key(util.KeyboardKey.W) - is_key(util.KeyboardKey.S)
    local r = is_key(util.KeyboardKey.D) - is_key(util.KeyboardKey.A)
    local u = is_key(util.KeyboardKey.E) - is_key(util.KeyboardKey.Q)

    -- sprint
    speed = is_key_down(util.KeyboardKey.LEFT_SHIFT) and speed * 3 or speed


    mouse_delta = get_mouse_delta() * -sensi

    handle_mouse_delta(cm, mouse_delta, true)

    local forward = get_camera_flat_forward(cm)
    local right   = get_camera_right(cm)
    local up = cm.up



    local move = (forward * f) + (right * r) + (up * u)
    velocity = velocity +  move * speed * dt

    t:translate(velocity)
end



function is_key(key)
    return is_key_down(key) and 1 or 0
end
