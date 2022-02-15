local state = require "state"
local entities = require "entities"

require "physics"

local sim = {}

function sim.update(dt)
    -- Check collision for all pairs of particles
    for i=1,#entities-1 do
        for j=i+1,#entities do
            if checkCollision(entities[i], entities[j]) then
                resolveCollision(entities[i], entities[j])
            end
        end
    end

    -- Update particles
    for i,v in ipairs(entities) do
        v:update(dt)
    end
end

function sim.draw()
    -- Draw particles
    for i,v in ipairs(entities) do
        v:draw()
    end
end

return sim