-- Made by Blissful#4992, you can add stuff to this here's template a1 = {<string> 'varname', <int> 10}
local list = {
    str1 = {'RecoilMult', 0},
    str2 = {'ReloadTime', 0},
    str3 = {'Spread', 0},
    str4 = {'Automatic', true},
    str5 = {'Range', 1000000},
    str6 = {'Ammo', 1000000},
    str7 = {'ClipSize', 1000001},
    str8 = {'FireRate', 0.05},
    str9 = {'EquipTime', 0}
}

local function Mod(lib, str)
    if type(lib) == 'table' and rawget(lib, str[1]) then
        coroutine.wrap(function()
            while wait() do
                lib[str[1]] = str[2]
            end
        end)()
    end
end

for i, v in pairs(getgc(true)) do
    for u, x in pairs(list) do
        Mod(v, x)
    end
end
