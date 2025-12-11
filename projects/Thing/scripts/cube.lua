local ph
local id
local t

function on_init()
    t  = get_transform(scene, this)
    ph = get_physicbody(scene, this)
    id = scene:uuid_to_entt(this)
    t:translate(vec3.new(0,5,0))
end

function on_update(dt)
    rotation = t:rotation()
    rotation.y = math.sin(get_time() +  id) * 50
    t:set_rotation(rotation)
    --t.rotation.z = math.sin(get_time() +  id) * 50

    position = vec3.new(0)
    position.y = 2 + math.sin(get_time() +  id) * 0.5
    t:translate(position * 0.01)
end


