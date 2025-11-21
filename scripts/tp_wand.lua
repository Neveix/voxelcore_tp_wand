local utils = require "tp_wand:utils"

local blocks_check_limit = 256

local final_pos_x_shift = 0.5
local final_pos_z_shift = 0.5

function on_use_on_block(x, y, z, pid)
    while not block.is_replaceable_at(x,y,z) do
        y = y + 1
        if y > blocks_check_limit then break end
    end
    player.set_pos(playerid, 
        x + final_pos_x_shift,
        y + 1,
        z + final_pos_z_shift)
    return true
end


function on_use(playerid)
    local coords, err = utils.raycast_from_player(playerid, {0, 0.7, 0})
    if err then
        return
    end
    local x, y, z = coords[1], coords[2], coords[3]
    player.set_pos(playerid,
        x + final_pos_x_shift,
        y + 2,
        z + final_pos_z_shift)
    player.set_vel(playerid, 0, 0, 0)
end
