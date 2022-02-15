local particle = require "entities/particle"

local entities = {}

local window_width = love.window.getMode() - 20

local entnum = 50
local min_radius = 15
local max_radius = 25

for n=0,entnum do
    local p_x = ((n * 60) % window_width) + 40
    local p_y = (math.floor((n * 60) / window_width) * 100) + 80
    local angle = love.math.random(-math.pi, math.pi)
    local radius = math.floor(love.math.random(min_radius, max_radius))

    entities[#entities + 1] = particle(p_x, p_y, angle, radius)
end

return entities