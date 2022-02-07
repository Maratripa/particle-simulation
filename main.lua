function love.load()
    Object = require "classic"

    require "particle"

    -- number of particles to display
    number = 100

    -- table of particles
    particles = {}

    -- create particles with random position and angle
    for i=1,number do
        table.insert(particles, Particle(
            love.math.random(20, love.graphics.getWidth()-20),
            love.math.random(20, love.graphics.getHeight()-20),
            love.math.random(-math.pi, math.pi),
            love.math.random(15, 15)))
    end
end

function love.update(dt)
    -- check collision for all pairs of particles
    for i=1,#particles-1 do
        for j=i+1,#particles do
            checkCollision(particles[i], particles[j])
        end
    end

    -- update particles
    for i,v in ipairs(particles) do
        v:update(dt)
    end
end

function love.draw()
    -- draw particles
    for i,v in ipairs(particles) do
        v:draw()
    end
    -- love.graphics.print("Total momentum: " .. totalMomentum(), 10, 10)
end

function resolveCollision(p1, p2)
    -- get normal vector and normalize it
    local normal = {x = p1.x - p2.x, y = p1.y - p2.y}
    local normal_n = {x = normal.x/math.sqrt(normal.x^2 + normal.y^2), y = normal.y/math.sqrt(normal.x^2 + normal.y^2)}

    -- relative velocity
    local rel_vel = {x = p1.vel.x - p2.vel.x, y = p1.vel.y - p2.vel.y}

    -- separation velocity along the normal vector
    local sep_vel = rel_vel.x * normal_n.x + rel_vel.y * normal_n.y
    local new_sep_vel = -sep_vel
    local sep_vel_vec = {x = normal_n.x * new_sep_vel, y = normal_n.y * new_sep_vel}

    -- apply velocity changes
    p1.vel.x = p1.vel.x + sep_vel_vec.x
    p1.vel.y = p1.vel.y + sep_vel_vec.y

    p2.vel.x = p2.vel.x - sep_vel_vec.x
    p2.vel.y = p2.vel.y - sep_vel_vec.y

    if checkCollision(p1, p2) then
        -- find time at which particles are no longer overlapping
        local time = (-(normal.x + normal.y) + math.sqrt((normal.x - normal.y)^2 - ((p1.vel.x - p2.vel.x)^2 + (p1.vel.y - p2.vel.y)^2) * (normal.x^2 + normal.y^2 - (p1.radius + p2.radius)^2))) / ((p1.vel.x - p2.vel.x)^2 + (p1.vel.y - p2.vel.y)^2)

        -- transport particles so they are not collisioning afterwards
        p1.x = p1.x + p1.vel.x * time
        p1.y = p1.y + p1.vel.y * time

        p2.x = p2.x + p2.vel.x * time
        p2.y = p2.y + p2.vel.y * time
    end
end

function checkCollision(p1, p2)
    if math.sqrt((p1.x - p2.x)^2 + (p1.y - p2.y)^2) < p1.radius + p2.radius then
        -- p1.overlapping = true
        -- p2.overlapping = true
        resolveCollision2(p1, p2)
    end
    return false
end

function resolveCollision2(p1, p2)
    local normal = {x = p1.x - p2.x, y = p1.y - p2.y}
    local distance = math.sqrt((p1.x - p2.x)^2 + (p1.y - p2.y)^2)
    local normal_n = {x = normal.x / distance, y = normal.y / distance}
    local pushback = p1.radius + p2.radius - distance

    p1.x = p1.x + pushback * normal_n.x
    p1.y = p1.y + pushback * normal_n.y

    local v1x = p1.vel.x - (2 * p2.mass / (p1.mass + p2.mass)) * ((p1.vel.x - p2.vel.x) * normal.x + (p1.vel.y - p2.vel.y) * normal.y) / math.sqrt(normal.x^2 + normal.y^2)^2 * normal.x
    local v1y = p1.vel.y - (2 * p2.mass / (p1.mass + p2.mass)) * ((p1.vel.x - p2.vel.x) * normal.x + (p1.vel.y - p2.vel.y) * normal.y) / math.sqrt(normal.x^2 + normal.y^2)^2 * normal.y

    local v2x = p2.vel.x - (2 * p1.mass / (p2.mass + p1.mass)) * ((p2.vel.x - p1.vel.x) * normal.x + (p2.vel.y - p1.vel.y) * normal.y) / math.sqrt(normal.x^2 + normal.y^2)^2 * normal.x
    local v2y = p2.vel.y - (2 * p1.mass / (p2.mass + p1.mass)) * ((p2.vel.x - p1.vel.x) * normal.x + (p2.vel.y - p1.vel.y) * normal.y) / math.sqrt(normal.x^2 + normal.y^2)^2 * normal.y

    p1.vel.x = v1x
    p1.vel.y = v1y
    p2.vel.x = v2x
    p2.vel.y = v2y
end

function totalMomentum()
    local counter = 0
    for i=1,#particles do
        local vel = math.sqrt(particles[i].vel.x^2 + particles[i].vel.y^2)
        local mass = particles[i].mass
        counter = counter + (vel * mass)
    end

    return counter
end

function transport_particles(p1, p2)
    local normal = {x = p1.x - p2.x, y = p1.y - p2.y}

    local time = (-(normal.x + normal.y) - math.sqrt((normal.x - normal.y)^2 - ((p1.vel.x - p2.vel.x)^2 + (p1.vel.y - p2.vel.y)^2) * (normal.x^2 + normal.y^2 - (p1.radius + p2.radius)^2))) / ((p1.vel.x - p2.vel.x)^2 + (p1.vel.y - p2.vel.y)^2)

    p1.x = p1.x + p1.vel.x * time
    p1.y = p1.y + p1.vel.y * time

    p2.x = p2.x + p2.vel.x * time
    p2.y = p2.y + p2.vel.y * time

end