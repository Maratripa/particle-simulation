return function(pos_x, pos_y, width, height, display_text)
    -- Create a textbox entity, you can create multiple textboxes if needed
    local entity = {}

    -- Textbox properties
    entity.x = pos_x
    entity.y = pos_y
    entity.width = width
    entity.height = height

    -- Placeholder_text is not mutable, text is used for text input
    entity.placeholder_text = display_text .. " "
    entity.text = ""

    -- Used for enabling text input
    entity.active = false

    -- Textbox colors
    entity.colors = {
        background = {1, 1, 1, 1},
        text = {0.05, 0.05, 0.05, 1}
    }

    function entity:draw()
        love.graphics.setColor(self.colors.background)
        love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)

        love.graphics.setColor(self.colors.text)
        love.graphics.printf(self.placeholder_text .. self.text, self.x, self.y + self.height/3, self.width, "center")
    end

    return entity
end