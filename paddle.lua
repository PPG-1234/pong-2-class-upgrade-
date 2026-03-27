local Paddle={}
Paddle.__index=Paddle
function Paddle:new(x, y, w, h, speed)
    local self=setmetatable({}, Paddle)
    self.x=x
    self.y=y
    self.w=w
    self.h=h
    self.speed=speed
    return self
end
function Paddle:update(dt)
    if love.keyboard.isDown(up) then
        self.y=self.y-self.speed*dt
    elseif love.keyboard.isDown(downKey) then
        self.y=self.y+self.speed*dt
    end
end