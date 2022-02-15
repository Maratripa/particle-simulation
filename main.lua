function love.load()
    entities = require "entities"
    state = require "state"
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

function checkCollision(p1, p2)
    if math.sqrt((p1.x - p2.x)^2 + (p1.y - p2.y)^2) < p1.radius + p2.radius then
        -- p1.overlapping = true
        -- p2.overlapping = true
        return true
    end
    return false
end

function resolveCollision2(p1, p2)
    local normal = {x = p1.x - p2.x, y = p1.y - p2.y}
    local distance = math.sqrt((normal.x)^2 + (normal.y)^2)
    local normal_n = {x = normal.x / distance, y = normal.y / distance}
    local pushback = p1.radius + p2.radius - distance

    p1.x = p1.x + pushback * normal_n.x
    p1.y = p1.y + pushback * normal_n.y

    local v1x = p1.vel.x - (2 * p2.mass / (p1.mass + p2.mass)) * ((p1.vel.x - p2.vel.x) * normal.x + (p1.vel.y - p2.vel.y) * normal.y) / distance^2 * normal.x
    local v1y = p1.vel.y - (2 * p2.mass / (p1.mass + p2.mass)) * ((p1.vel.x - p2.vel.x) * normal.x + (p1.vel.y - p2.vel.y) * normal.y) / distance^2 * normal.y

    local v2x = p2.vel.x - (2 * p1.mass / (p2.mass + p1.mass)) * ((p2.vel.x - p1.vel.x) * normal.x + (p2.vel.y - p1.vel.y) * normal.y) / distance^2 * normal.x
    local v2y = p2.vel.y - (2 * p1.mass / (p2.mass + p1.mass)) * ((p2.vel.x - p1.vel.x) * normal.x + (p2.vel.y - p1.vel.y) * normal.y) / distance^2 * normal.y

    p1.vel.x = v1x
    p1.vel.y = v1y
    p2.vel.x = v2x
    p2.vel.y = v2y
end

function totalMomentum()
    local counter = 0
    for i=1,#entities do
        local vel = math.sqrt(entities[i].vel.x^2 + entities[i].vel.y^2)
        local mass = entities[i].mass
        counter = counter + (vel * mass)
    end

    return counter
end