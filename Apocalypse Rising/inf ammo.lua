local str = 'Amount'

for i, v in pairs(getgc(true)) do
        if type(v) == 'table' and rawget(v, str) then
            coroutine.wrap(function()
                while wait() do
                    v[str] = 1000
                end
            end)()
        end
end
