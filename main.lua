require "simulation"
require "menu"
local state = require "state"

function love.load()
    -- Create variables in load() to reset game with button
    sim = LoadSimulation()
    menu = LoadMenu()
    state.paused = false
end

function love.update(dt)
    -- Update menu or simulation
    if state.paused then
        menu.update()
    else
        sim.update(dt)
    end
end

function love.keypressed(k)
    -- Enter menu
    if k == "escape" then
        state.paused = not state.paused
    end

    if state.paused then
        menu:ProcessKeyboard(k)
    end
end

function love.mousepressed(x, y)
    if state.paused then
        menu:ProcessMouse(x, y)
    end
end

function love.textinput(t)
    if state.paused then
        menu:processTextInput(t)
    end
end

function love.draw()
    -- Show menu or simulation
    if state.paused then
        menu:draw()
    else
        sim.draw()
    end
end