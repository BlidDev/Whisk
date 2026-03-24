
local material = nil
local default_mode  = vec2:new(0,0)

local modes = {
    [util.KeyboardKey.Q] = vec2:new(0,1), -- neutral
    [util.KeyboardKey.W] = vec2:new(0,2), -- right hand
}


function on_init()
    if has_modelcomp(scene, this) then
        material = get_modelcomp(scene, this).material
    end
end


function on_update(dt)
    if material == nil then return end
    for key, value in pairs(modes) do
        if (is_key_down(key)) then
            material.tex_offset = value
            return
        end
    end
   
    material.tex_offset = default_mode
end