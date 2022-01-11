
local player = {}
player.x = 0
player.y = 67
player.sprite = 0
player.speed = 2
player.jumping = false
player.jumpingup = false

local badguy = {}
badguy.x = 64;
badguy.y = 67;
badguy.sprite = 9;
badguy.speed = 2;

local badguy2 = {}
badguy2.x = 64;
badguy2.y = 67;
badguy2.sprite = 22;
badguy2.speed = 2;

local startscreen = true
local gameover = false

function moveanim()
    player.sprite += 1
    if player.sprite > 3 then
        player.sprite = 0
    end
end

function jumpanim()
    if player.jumpingup then -- on his way up
        player.y -= 2
    else
        player.y += 2 -- on his way down
    end
    if player.y < 59 then
        player.jumpingup = false -- reached the top, head back down
    end
    if player.y > 65 then
        player.jumping = false -- we've reached the ground
    end
end

function badguyanim()
    badguy.sprite += 1
    if badguy.sprite > 11 then
        badguy.sprite = 9 -- loop through animation
    end

    badguy.x += badguy.speed -- continually loop around screen
    if badguy.x > 128 then
        badguy.x = -10
    end

    badguy2.sprite += 1
    if badguy2.sprite > 25 then
        badguy2.sprite = 22 -- loop through animation
    end

    badguy2.x -= badguy2.speed -- continually loop around screen
    if badguy2.x < -10 then
        badguy2.x = 128
    end
end

function drawstartscreen()
    local xpos = 20
    for x=64,74 do
        spr(x, xpos, 45)
        xpos += 8
    end

    xpos = 20
    for x=80,90 do
        spr(x, xpos, 53)
        xpos += 8
    end
    print("press ❎ to start", 30, 65, 0)
end

function drawgameover()
    local xpos = 30
    for x=13,21 do
        spr(x, xpos, 45)
        xpos += 8
    end
end

function _draw()
    cls() -- clear screen
    map(0,0,0,20,124,124) -- draw background

    if startscreen then
        drawstartscreen()
    elseif gameover then
        drawgameover() -- draw gameover screen
    else
        spr(player.sprite, player.x, player.y) -- draw sprite
        spr(badguy.sprite, badguy.x, badguy.y)    
        spr(badguy2.sprite, badguy2.x, badguy2.y)
    end
end

function _update()
    if (btn(0)) then
        player.x -= player.speed -- move left
        if player.x < -10 then
            player.x = 128 -- wrap screen
        end
        moveanim()
    end

    if (btn(1)) then
        player.x += player.speed -- move right
        if player.x > 128 then
            player.x = -10 -- wrap screen
        end
        moveanim()
    end

    if (btn(5)) then
        if startscreen then
            startscreen = false
        end
        player.jumping = true -- enter jump sequence
        player.jumpingup = true
    end

    if player.jumping then
        jumpanim()
    end

    badguyanim()

    -- if player.x == badguy.x and player.y == badguy.y then
    --     gameover = true -- TODO: better collision detection
    -- end
end