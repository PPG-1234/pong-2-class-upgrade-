local Paddle={}
Paddle.__index=Paddle
function Paddle:new(x, y, w, h, speed,up,down)
    local self=setmetatable({}, Paddle)
    self.x=x
    self.y=y
    self.w=w
    self.h=h
    self.speed=speed
    self.up=up
    self.down=down
    return self
end

function Paddle:update(dt)
    if love.keyboard.isDown(self.up) then
        self.y=self.y-self.speed*dt
    elseif love.keyboard.isDown(self.down) then
        self.y=self.y+self.speed*dt
    end
end
function Paddle:limits()
    if self.y<0 then
        self.y=0
    elseif self.y+self.h>love.graphics.getHeight() then
        self.y=love.graphics.getHeight()-self.h
    end
end
return Paddle