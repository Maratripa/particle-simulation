local particle = require "entities/particle"
local state = require "state"

local window_width = love.window.getMode() - 20

function LoadEntities()
    local entities = {}

    -- Number of particles to spawn, min and max radius for particles
    local num = state.number_of_particles
    local minrad = 15
    local maxrad = 25

    -- Spawn particles apart from each other
    for i=0,(num - 1) do
        local px = ((i * 60) % window_width) + 40
        local py = (math.floor((i * 60) / window_width) * 100) + 80
        -- Random angle of velocity
        local radians = love.math.random(-math.pi, math.pi)
        local radius = math.floor(love.math.random(minrad, maxrad))

        entities[#entities + 1] = particle(px, py, radians, radius)
    end

    -- Return all particles
    return entities
end