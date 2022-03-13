function love.conf(t)
    t.window.title = "Particle Sim"
    t.window.icon = nil

    -- Set window settings
    t.window.width = 800
    t.window.height = 800
    t.window.fullscreen = false
    t.window.resizable = false
    t.window.fullscreentype = "desktop"

    -- Disable unused modules for performance
    t.modules.audio = false
    t.modules.image = false
    t.modules.joystick = false
    t.modules.physics = false
    t.modules.sound = false
    t.modules.system = false
    t.modules.thread = false
    t.modules.touch = false
    t.modules.video = false
end