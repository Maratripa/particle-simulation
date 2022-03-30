local utf8 = require "utf8"

local state = require "state"
local Textbox = require "entities/textbox"
local Button = require "entities/button"

local ww, wh = love.window.getMode()

function LoadMenu()
   -- Menu table
   local menu = {}

   -- Code requires this textbox to be the first one
   menu.textboxes = {
      Textbox((ww / 2) - 100, 200, 200, 100, "PARTICLE NUMBER:")
   }

   -- Buttons table, anonymous functions for buttons
   menu.buttons = {
      Button((ww / 2) - 100, 50, 200, 100, "SIMULATE",
      function()
         if tonumber(menu.textboxes[1].text) ~= nil then
            state.number_of_particles = tonumber(menu.textboxes[1].text)
         end
         
         love.load()
      end)
   }

   function menu:update()
   end

   -- Draw menu objects
   function menu:draw()
      for i,v in ipairs(self.buttons) do
         v:draw()
      end

      for i,v in ipairs(self.textboxes) do
         v:draw()
      end
   end

   
   function menu:ProcessMouse(x, y)
      -- Check mouse click on buttons
      for i,v in ipairs(self.buttons) do
         if x >= v.x and
            x <= v.x + v.width and
            y >= v.y and
            y <= v.y + v.height
         then
            v.callback()
         end
      end

      -- Change active state for textboxes
      for i,v in ipairs(self.textboxes) do
         if x >= v.x and
            x <= v.x + v.width and
            y >= v.y and
            y <= v.y + v.height
         then
            v.active = true
         elseif v.active then
            v.active = false
         end
      end
   end

   -- Update text on textboxes
   function menu:processTextInput(t)
      for i,v in ipairs(self.textboxes) do
         if v.active then
            v.text = v.text .. t
         end
      end
   end

   -- Backspace
   function menu:ProcessKeyboard(k)
      if k == "backspace" then
         for i,v in ipairs(self.textboxes) do
            local byteoffset = utf8.offset(v.text, -1)
            if byteoffset then
               v.text = string.sub(v.text, 1, byteoffset - 1)
            end
         end
      end
   end
   
   return menu
end