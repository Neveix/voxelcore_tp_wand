local utils = {}

utils.raycast_max_length = 512

-- returns x, y, z
function utils.player_get_rot_vector(playerid) 
    local yaw, pitch, roll = player.get_rot(playerid)
    local yaw = math.rad(yaw + 90)
    local pitch = math.rad(pitch)

    local y = math.sin(pitch)

    local x, z = 1, 0

    local nx = ( x * math.cos(yaw) - z * math.sin(yaw) ) * math.cos(pitch)
    local nz = -( x * math.sin(yaw) + z * math.cos(yaw) ) * math.cos(pitch)
    x, z = nx, nz

    return x, y, z
end

-- returns result: vec3, err: true | nil
function utils.raycast_from_player(playerid)
    local x, y, z = player.get_pos(playerid)

    rx, ry, rz = utils.player_get_rot_vector(playerid)

    local raycast_result = block.raycast({x, y, z}, {rx, ry, rz}, 
                                            utils.raycast_max_length, 
                                            {nil, nil, nil, nil, nil, nil})
    if raycast_result == nil then return nil, true end

    return raycast_result.iendpoint, nil
end

return utils