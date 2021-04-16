local str = 'FireRate'

for i, v in pairs(getgc(true)) do
    if type(v) == 'table' and rawget(v, str) then
        v[str] = 100000
    end
end
