function love.load()
    entities = require "entities"
    state = require "state"

    require "physics"
end

function love.update(dt)
    -- check collision for all pairs of particles
    for i=1,#entities-1 do
        for j=i+1,#entities do
            if checkCollision(entities[i], entities[j]) then
                resolveCollision2(entities[i], entities[j])
            end
        end
    end

    -- update particles
    for i,v in ipairs(entities) do
        v:update(dt)
    end
end

function love.draw()
    -- draw particles
    for i,v in ipairs(entities) do
        v:draw()
    end
    -- love.graphics.print("Total momentum: " .. totalMomentum(), 10, 10)
end