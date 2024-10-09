-- Functions
function clearTable(t)
    for k in pairs(t) do
        t[k] = nil
    end
end

function copyTable(dest, src)
    for k, v in pairs(src) do
        dest[k] = v
    end
end

function dist(x1, y1, x2, y2)
    return math.sqrt((x2 - x1)^2 + (y2 - y1)^2)
end

function randomVector()
    local randomAngle = love.math.random() * 2 * math.pi 
    return {x = math.cos(randomAngle), y = math.sin(randomAngle)} 
end