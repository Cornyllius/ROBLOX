local a1 = loadstring(game:HttpGet("link here", true))()
local a2 = syn.request({
    Url = 'https://httpbin.org/get',
    Method = 'GET'
}).Body;
local a3 = game:GetService("HttpService"):JSONDecode(a2)
local a4 = a3.headers["Syn-Fingerprint"]
local a5 = "key_"..a4

if a1[a5] ~= nil and a1[a5] == true then
    print("Whitelisted")
else 
    print("Not whitelisted, copied key to clipboard")
    setclipboard(a5)
end
