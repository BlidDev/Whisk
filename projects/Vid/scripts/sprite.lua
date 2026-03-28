
local material = nil

local modes = {
    ["old"] = vec2:new(0,0),
    ["cat"] = vec2:new(1,0),
    ["teacher"] = vec2:new(2,0),
    ["scawy"] = vec2:new(3,0),

    ["pointup"] = vec2:new(0,1),
    ["idk"] = vec2:new(1,1),
    ["ohno"] = vec2:new(2,1),
    ["blue"] = vec2:new(3,1),

    ["neutral"] = vec2:new(0,2),
    ["pick"] = vec2:new(1,2),
    ["hips"] = vec2:new(2,2),
    ["clap"] = vec2:new(3,2),

    ["thumb"] = vec2:new(0,3),
}

local bindings = {
    [util.KeyboardKey.Q] = modes["pointup"],
    [util.KeyboardKey.W] = modes["neutral"],
    [util.KeyboardKey.E] = modes["idk"],

    [util.KeyboardKey.A] = modes["hips"],
    [util.KeyboardKey.S] = modes["clap"],
    [util.KeyboardKey.D] = modes["thumb"],

    [util.KeyboardKey.R] = modes["pick"],
    [util.KeyboardKey.F] = modes["ohno"],
    [util.KeyboardKey.G] = modes["scawy"],
    [util.KeyboardKey.B] = modes["blue"],
}

local default_mode  = modes["teacher"]

ToggledModes = false

function on_init()
    if has_modelcomp(scene, this) then
        material = get_modelcomp(scene, this).material
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