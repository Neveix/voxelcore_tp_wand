local utils = require "tp_wand:utils"

local blocks_check_limit = 100

function on_use_on_block(x, y, z, pid)
    y = y + 2
    while not block.is_replaceable_at(x,y,z) do
        y = y + 1
        if y > blocks_check_limit then break end 
    end
    player.set_pos(playerid, x, y, z)
end


function on_use(playerid)
    local coords, err = utils.raycast_from_player(nil)
    if err then
        return
    end
    local x, y, z = coords[1], coords[2], coords[3]
    player.set_pos(playerid, x, y+2, z)
end

local players = player.get_all()
print(players)
