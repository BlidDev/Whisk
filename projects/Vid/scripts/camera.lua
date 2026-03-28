Speed = 1.0

local trans
local cam

local forward = vec3:new(0,0, 1)
local right   = vec3:new(-1,0, 0)
local up   = vec3:new(0,1, 0)

function on_init()
    trans = get_transform(scene, this)
    cam = get_camera(scene, this)

    forward = get_camera_forward(cam)
    right = get_camera_right(cam)
    up = cam.up
end


function on_update(dt)
    if not is_key_down(util.KeyboardKey.LEFT_CONTROL) then return end
    if this ~= scene:get_main_camera() then return end


    local f = Is_key(util.KeyboardKey.UP) - Is_key(util.KeyboardKey.DOWN)
    local r = Is_key(util.KeyboardKey.RIGHT) - Is_key(util.KeyboardKey.LEFT)
    local vec = is_key_down(util.KeyboardKey.LEFT_SHIFT) and up or forward
    local move = ((right * r) + (vec * f)) * dt
  

    trans:translate(move)

end

-- convert from bool to int
function Is_key(key)
    return is_key_down(key) and 1 or 0
end