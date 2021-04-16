local str = 'KickUpCameraInfluence'
local str2 = 'ShiftGunInfluence'
local str3 = 'ShiftCameraInfluence'
local str4 = 'RaiseInfluence'
local str5 = 'KickUpSpeed'

for i, v in pairs(getgc(true)) do
    if type(v) == 'table' and rawget(v, str) then
        v[str] = 0
        v[str2] = 0
        v[str3] = 0
        v[str4] = 0
        v[str5] = 10000000
    end
end
