function love.load()
    sim = require "simulation"
    state = require "state"
end

function love.update(dt)
    if state.paused then
    else
        sim.update(dt)
    end
end

function love.draw()
    if state.paused then
    else
        sim.draw()
    end
end