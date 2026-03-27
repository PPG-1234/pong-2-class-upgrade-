local ball={}
directions={-1,1}
ball.__index=ball
function ball:new(x, y, dx, dy)
    local self=setmetatable({}, ball)
    self.w=25
    self.h=25
    self.x=x
    self.y=y
    self.dx=dx
    self.dy=dy
    return self
end
function ball:update(dt)
    self.x=self.x+self.dx*dt
    self.y=self.y+self.dy*dt
end
function ball:limits()
    if self.y<0 then
        self.y=0
        self.dy=-self.dy
    elseif self.y+self.h>love.graphics.getHeight() then
        self.y=love.graphics.getHeight()-self.h
        self.dy=-self.dy
    end
end

object=new(ball, love.graphics.getWidth()/2-25/2,
 love.graphics.getHeight()/2-25/2,
 200*(directions[math.random(1,2)]),
 200*(directions[math.random(1,2)]))