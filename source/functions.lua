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