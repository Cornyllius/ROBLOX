local str2 = 'SpreadAddTPSHip'
local str3 = 'SpreadAddTPSZoom'
local str4 = 'SpreadAddFPSHip'
local str5 = 'RollRightBias'
local str6 = 'RollLeftBias'
local str7 = 'ShiftRoll'
local str8 = 'ShiftForce'
local str9 = 'SlideForce'

for i, v in pairs(getgc(true)) do
    if type(v) == 'table' and rawget(v, str) then
        v[str2] = 0
        v[str3] = 0
        v[str4] = 0
        v[str5] = 0
        v[str6] = 0
        v[str7] = 0
        v[str8] = 0
        v[str9] = 0
    end
end
