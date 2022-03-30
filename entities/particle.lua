-- Require state for color palette
local state = require "state"

return function(pos_x, pos_y, angle, radius)
    -- Particle entity for multiple particles
    local entity = {}

    -- Particle properties
    entity.x = pos_x
    entity.y = pos_y
    entity.angle = angle
    entity.radius = radius
    -- Set mass proportional to its radius
    entity.mass = entity.radius^2 / 100
    -- Set velocity magnitude "speed"
    entity.speed = 75
    -- Velocity vector
    entity.vel = {}
    entity.vel.x = entity.speed * math.cos(angle)
    entity.vel.y = entity.speed * math.sin(angle)

    -- Random color for every particle
    entity.color = state.palette[love.math.random(2, #state.palette)]


    function entity:update(dt)
        -- check collision with window borders horizontally
        if self.x - self.radius < 0 then
            self.x = self.radius
            self.vel.x = -self.vel.x
        elseif self.x + self.radius > love.graphics.getWidth() then
            self.x = love.graphics.getWidth() - self.radius
            self.vel.x = -self.vel.x
        end
        -- check collision with window borders vertically
        if self.y - self.radius < 0 then
            self.y = self.radius
            self.vel.y = -self.vel.y
        elseif self.y + self.radius > love.graphics.getHeight() then
            self.y = love.graphics.getHeight() - self.radius
            self.vel.y = -self.vel.y
        end

        -- update position
        self.x = self.x + self.vel.x * dt
        self.y = self.y + self.vel.y * dt
    end

    function entity:draw()
        love.graphics.setColor(self.color)
        love.graphics.circle("fill", self.x, self.y, self.radius)
        -- Reset color
        love.graphics.setColor(state.palette[1])
    end

    return entity
end