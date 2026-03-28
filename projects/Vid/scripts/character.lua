local phys
local trans

Speed = 5.0
StraightCam = UUID:new(0)
SideCam = UUID:new(0)

local original_rot = vec3:new()
local billboard_rot = nil

function on_init()
    phys = get_physicsbody(scene, this)
    trans = get_transform(scene, this)

    original_rot = trans:rotation()
    billboard_rot = vec3:new(original_rot.x, 0.0, original_rot.z)
end



function on_update(dt)
    if is_key_down(util.KeyboardKey.LEFT_CONTROL) then return end
    
    -- get input
    local f = Is_key(util.KeyboardKey.UP) - Is_key(util.KeyboardKey.DOWN)
    local r = Is_key(util.KeyboardKey.RIGHT) - Is_key(util.KeyboardKey.LEFT)

    -- jump when grounded
    if is_key_down(util.KeyboardKey.SPACE) and phys.move_delta.y == 0.0 then
        local jump_force = 5.0
        phys.velocity.y = jump_force
    end

    if is_key_clicked(util.KeyboardKey.k2) and StraightCam:valid()  then
        scene:set_main_camera(StraightCam)
        trans:set_rotation(billboard_rot)
    end

    if is_key_clicked(util.KeyboardKey.k1) and SideCam:valid() then
        scene:set_main_camera(SideCam)
        trans:set_rotation(original_rot)
    end

    if is_key_clicked(util.KeyboardKey.TAB) then 
        trans:rotate_y(180)
    end


    local forward = vec3:new(0,0, 1)
    local right   = vec3:new(-1,0, 0)


    local move = (forward * f) + (right * r)

    phys.velocity = phys.velocity +  move * Speed * dt
end


-- convert from bool to int
function Is_key(key)
    return is_key_down(key) and 1 or 0
end

