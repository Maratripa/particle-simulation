local particle = require "entities/particle"
local state = require "state"

local window_width = love.window.getMode() - 20

function LoadEntities()
    local ent = {}

    local num = state.number_of_particles
    local minrad = 15
    local maxrad = 25

    for i=0,(num - 1) do
        local px = ((i * 60) % window_width) + 40
        local py = (math.floor((i * 60) / window_width) * 100) + 80
        local radians = love.math.random(-math.pi, math.pi)
        local rad = math.floor(love.math.random(minrad, maxrad))

        ent[#ent + 1] = particle(px, py, radians, rad)
    end

    return ent
end