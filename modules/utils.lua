local utils = {}

---@alias vec3 [number, number, number]

utils.raycast_max_length = 512

---Возвращает вектор поворота игрока
---@param playerid integer id игрока
---@param normalize boolean Нужно ли нормализовать вектор
function utils.player_get_rot_vector(playerid, normalize)
    local yaw, pitch, roll = player.get_rot(playerid)
    local yaw = math.rad(yaw + 90)
    local pitch = math.rad(pitch)

    local x = math.cos(yaw) * math.cos(pitch)
    local y = math.sin(pitch)
    local z = -math.sin(yaw) * math.cos(pitch)

    if normalize then
        local length = math.sqrt(x * x + y * y + z * z)
        if length > 0 then
            return x / length, y / length, z / length
        end
    end
    return x, y, z
end

---Проводит луч от игрока в направлении его взгляда
---@param playerid number id игрока от которого будет проводиться луч
---@param src_pos_shift vec3|nil Смещение относительно координат игрока
---@return vec3|nil (vec3, false) Целочисленная точка конца луча
---@return boolean (nil, true) В случае ошибки
function utils.raycast_from_player(playerid, src_pos_shift)
    local sx, sy, sz = 0, 0, 0
    if src_pos_shift ~= nil then
        sx = sx + src_pos_shift[1]
        sy = sy + src_pos_shift[2]
        sz = sz + src_pos_shift[3]
    end
    local x, y, z = player.get_pos(playerid)

    local rx, ry, rz = utils.player_get_rot_vector(playerid)

    local raycast_result = block.raycast(
        { x + sx, y + sy, z + sz },
        { rx, ry, rz },
        utils.raycast_max_length,
        { nil, nil, nil, nil, nil, nil })
    if raycast_result == nil then
        return nil, true
    end

    return raycast_result.iendpoint, false
end

return utils

