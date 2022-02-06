function love.load()
    Object = require "classic"

    require "particle"

    -- number of particles to display
    number = 20

    -- table of particles
    particles = {}

    -- create particles with random position and angle
    for i=1,number do
        table.insert(particles, Particle(
            love.math.random(20, love.graphics.getWidth()-20),
            love.math.random(20, love.graphics.getHeight()-20),
            love.math.random(-math.pi, math.pi)))
    end
end

function love.update(dt)
    -- check collision for all pairs of particles
    for i=1,#particles-1 do
        for j=i+1,#particles do
            if particles[i]:checkCollision(particles[j]) then
                resolveCollision(particles[i], particles[j])
            end
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
end