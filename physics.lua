local entities = require "entities"

-- Collision check for particles
function checkCollision(p1, p2)
    if math.sqrt((p1.x - p2.x)^2 + (p1.y - p2.y)^2) < p1.radius + p2.radius then
        -- p1.overlapping = true
        -- p2.overlapping = true
        return true
    end
    return false
end

-- Collision resolving
function resolveCollision(p1, p2)
    local normal = {x = p1.x - p2.x, y = p1.y - p2.y}
    local distance = math.sqrt((normal.x)^2 + (normal.y)^2)
    local normal_n = {x = normal.x / distance, y = normal.y / distance}
    local pushback = p1.radius + p2.radius - distance

    -- Set particles apart if colliding before updating velocity
    p1.x = p1.x + pushback * normal_n.x
    p1.y = p1.y + pushback * normal_n.y

    local v1x = p1.vel.x - (2 * p2.mass / (p1.mass + p2.mass)) * ((p1.vel.x - p2.vel.x) * normal.x + (p1.vel.y - p2.vel.y) * normal.y) / distance^2 * normal.x
    local v1y = p1.vel.y - (2 * p2.mass / (p1.mass + p2.mass)) * ((p1.vel.x - p2.vel.x) * normal.x + (p1.vel.y - p2.vel.y) * normal.y) / distance^2 * normal.y

    local v2x = p2.vel.x - (2 * p1.mass / (p2.mass + p1.mass)) * ((p2.vel.x - p1.vel.x) * normal.x + (p2.vel.y - p1.vel.y) * normal.y) / distance^2 * normal.x
    local v2y = p2.vel.y - (2 * p1.mass / (p2.mass + p1.mass)) * ((p2.vel.x - p1.vel.x) * normal.x + (p2.vel.y - p1.vel.y) * normal.y) / distance^2 * normal.y

    -- Update velocity
    p1.vel.x = v1x
    p1.vel.y = v1y
    p2.vel.x = v2x
    p2.vel.y = v2y
end

-- Unused function for debugging resolveCollision()
function totalMomentum()
    local counter = 0
    for i=1,#entities do
        local vel = math.sqrt(entities[i].vel.x^2 + entities[i].vel.y^2)
        local mass = entities[i].mass
        counter = counter + (vel * mass)
    end

    return counter
end