local Ball={}
local directions={-1,1}
Ball.__index=Ball
--making the Ball and updates
function Ball:new(x, y, dx, dy)
    local self=setmetatable({}, Ball)
    self.w=25
    self.h=25
    self.x=x
    self.y=y
    self.dx=dx
    self.dy=dy
    return self
end
function Ball:update(dt)
    self.x=self.x+self.dx*dt
    self.y=self.y+self.dy*dt
end
--sets limits up and down
function Ball:limits()
    if self.y<0 then
        self.y=0
        self.dy=-self.dy
    elseif self.y+self.h>love.graphics.getHeight() then
        self.y=love.graphics.getHeight()-self.h
        self.dy=-self.dy
    end
end
--setting the ball to the middle of the screen and giving it a random direction
function Ball:reset(dx,dy)
    self.x=love.graphics.getWidth()/2-12.5
    self.y=love.graphics.getHeight()/2-12.5
    self.dx=dx*directions[math.random(1,2)]
    self.dy=dy*directions[math.random(1,2)]
end
return Ball
