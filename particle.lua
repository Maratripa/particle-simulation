Particle = Object:extend()

function Particle:new(x, y, angle, radius)
    -- initialize particle attributes

    self.x = x
    self.y = y
    self.angle = angle

    self.radius = radius
    self.mass = self.radius^2 / 100

    self.speed = 75
    self.vel = {}
    self.vel.x = self.speed * math.cos(angle)
    self.vel.y = self.speed * math.sin(angle)

    self.color = random_color()

    -- self.overlapping = false
end

function Particle:update(dt)
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

function Particle:draw()
    -- draw particle red if is colliding with another one
    -- if self.overlapping then
    --     love.graphics.setColor(1,0,0)
    -- else
    --     love.graphics.setColor(1,1,1)
    -- end
    -- self.overlapping = false
    love.graphics.setColor(self.color)
    love.graphics.circle("fill", self.x, self.y, self.radius)
    
    -- draw velocity vector
    -- love.graphics.line(self.x, self.y, self.x + self.vel.x, self.y + self.vel.y)
end

function random_color()
    local possible_colors = {
        {246/255, 114/255, 128/255},
        {108/255, 86/255, 123/255},
        {255/255, 235/255, 153/255}
    }
    return possible_colors[math.random(#possible_colors)]
end