local str = "SpawnRarity"

for i, v in pairs(getgc(true)) do
    if type(v) == 'table' and rawget(v, str) then
        v[str] = 1
    end
end
