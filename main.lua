local Ball=require ('ball')
local Paddle=require ('paddle')

height=700
width=1200

--all local
local obj
local left
local right
local leftScore=0
local rightScore=0
local freeze=3
local paused=false
local npoint=0
local font

function love.load()
    math.randomseed(os.time())
    font=love.graphics.newFont(50)
    love.window.setMode(width,height,{resizable=false, vsync=true, borderless=true, centered=true})
    
    obj=Ball:new(width/2-12.5,height/2-12.5,200,200)
    left=Paddle:new(0,height/2-50,15,100,300,'w','s')
    right=Paddle:new(width-15,height/2-50,15,100,300,'up','down')
    
    leftScore=0
    rightScore=0
    freeze=3
    paused=false
    npoint=0
end
--MAIN pause
function love.keypressed(key)
    if key=="escape" then
        paused=not paused
    end
end
--AABB collision
function collision()
    if obj.x<left.x+left.w and obj.y<left.y+left.h and obj.y+obj.h>left.y then
        obj.dx=-obj.dx
    elseif obj.x+obj.w>right.x and obj.y<right.y+right.h and obj.y+obj.h>right.y then
        obj.dx=-obj.dx
    end
end
--reseting ball after scoring
function reset()
    if obj.x<0 then rightScore=rightScore+1 obj:reset(obj.dx,obj.dy) freeze=2
    elseif obj.x+obj.w>width then leftScore=leftScore+1 obj:reset(obj.dx,obj.dy) freeze=2 end
end
--main update loop
function love.update(dt)
    local total=leftScore+rightScore
    local point=math.floor(total/10)
    --increasing ball speed every 10 points i.e., every time the total score reaches a multiple of 10, increasing difficulty
    if point>npoint then
        obj.dx = obj.dx + (obj.dx<0 and -100 or 100)
        obj.dy = obj.dy + (obj.dy<0 and -100 or 100)
        npoint=point
    --caping the speed to 550
        if math.abs(obj.dx)>550 then obj.dx=(obj.dx<0 and -550 or 550) end
        if math.abs(obj.dy)>550 then obj.dy=(obj.dy<0 and -550 or 550) end
    end
    --freezing the ball for players to prepare after scoring
    if paused then return end
    if freeze>0 then
        freeze=freeze-dt
    else
        obj:update(dt)
    end
--functions in classes in ball and paddle
    obj:limits()
    left:update(dt)
    left:limits()
    right:update(dt)
    right:limits()
    collision()
    reset()
end
--making the objects and scores visible
function love.draw()
    love.graphics.rectangle('fill',obj.x,obj.y,obj.w,obj.h)
    love.graphics.rectangle('fill',left.x,left.y,left.w,left.h)
    love.graphics.rectangle('fill',right.x,right.y,right.w,right.h)
    love.graphics.setFont(font)
    love.graphics.print(leftScore, 300, height/15)
    love.graphics.print(rightScore, width - 300, height/15)
    love.graphics.setColor(1,1,1,0.5)
    for i=0,14 do love.graphics.rectangle("fill",width/2-5,height/15*i,10,25) end
    love.graphics.setColor(1,1,1)
end