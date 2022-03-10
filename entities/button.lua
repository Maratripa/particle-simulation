return function(pos_x, pos_y, width, height, text, callback)
    local entity = {}

    entity.x = pos_x
    entity.y = pos_y
    entity.width = width
    entity.height = height

    entity.text = text
    entity.callback = callback

    entity.colors = {
        background = {1, 1, 1, 1},
        text = {0.05, 0.05, 0.05, 1}
    }

    function entity:draw()
        love.graphics.setColor(self.colors.background)
        love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)

        love.graphics.setColor(self.colors.text)
        love.graphics.printf(self.text, self.x, self.y + self.height/3, self.width, "center")
    end

    return entity
end