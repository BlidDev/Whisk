
local modes = {
    ["neutral"] = vec2:new(0,0),
    ["sniff"] = vec2:new(1,0),
    ["happy"] = vec2:new(2,0),
    ["what"] = vec2:new(3,0),

    ["nothx"] = vec2:new(0,1),
    ["fall"] = vec2:new(1,1),
}

local bindings = {
    [util.KeyboardKey.Q] = modes["sniff"],
    [util.KeyboardKey.W] = modes["neutral"],
    [util.KeyboardKey.E] = modes["happy"],

    [util.KeyboardKey.A] = modes["what"],
    [util.KeyboardKey.S] = modes["nothx"],
    [util.KeyboardKey.D] = modes["fall"],

}

local default_mode  = modes["neutral"]

ToggledModes = false

local material = nil

function on_init()
    if has_modelcomp(scene, this) then
        material = get_modelcomp(scene, this).material
    end


    for _, v in pairs(modes) do
        v.x = 3 - v.x
    end
    material.tex_offset = default_mode


end


function on_update(dt)
    if material == nil then return end
    for key, value in pairs(bindings) do
        if (is_key_down(key)) then
            material.tex_offset = value
            if is_key_down(util.KeyboardKey.LEFT_SHIFT) then default_mode = value end
            return
        end
    end

    if is_key_clicked(util.KeyboardKey.T) then
        ToggledModes = not ToggledModes
        log_info("ToggledModes is now: {}", ToggledModes)
    end

    if ToggledModes then return end

    material.tex_offset = default_mode
end
