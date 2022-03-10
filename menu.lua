local state = require "state"
local Textbox = require "entities/textbox"
local Button = require "entities/button"

local ww, wh = love.window.getMode()

function LoadMenu()
   local menu = {}

   menu.textboxes = {
      Textbox((ww / 2) - 100, 200, 200, 100, "Numero de particulas:")
   }

   menu.buttons = {
      Button((ww / 2) - 100, 50, 200, 100, "SIMULATE",
      function()
         state.number_of_particles = tonumber(menu.textboxes[1].text)
         love.load()
      end)
   }

   function menu.update()
      ww, wh = love.window.getMode()
   end

   function menu:draw()
      for i,v in ipairs(self.buttons) do
         v:draw()
      end

      for i,v in ipairs(self.textboxes) do
         v:draw()
      end
   end

   function menu:ProcessMouse(x, y)
      for i,v in ipairs(self.buttons) do
         if x >= v.x and
            x <= v.x + v.width and
            y >= v.y and
            y <= v.y + v.height
         then
            v.callback()
         end
   end

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

   function menu:processTextInput(t)
      for i,v in ipairs(self.textboxes) do
         if v.active then
            v.text = v.text .. t
         end
      end
   end

   return menu
end