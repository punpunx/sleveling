local DiscordLib =
    loadstring(game:HttpGet "https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/discord")()

local win = DiscordLib:Window("Arise Crossover By Pixie")

local serv = win:Server("Sung jin woo", "")

local btns = serv:Channel("Farming")
--[[
btns:Button(
    "Kill all",
    function()
        DiscordLib:Notification("Notification", "Killed everyone!", "Okay!")
    end
)btns:Button(
    "Kill all",
    function()
        DiscordLib:Notification("Notification", "Killed everyone!", "Okay!")
    end
)


btns:Toggle(
    "Auto-Arise",
    false,
    function(bool)
        _G.target = bool
        while _G.target do wait()
            
        end
    end
)

game:GetService("TweenService"):Create(game.Players.LocalPlayer.Character.HumanoidRootPart,TweenInfo.new(6),{game.Players.KuyRichKid.Charcater.HumanoidRootPart.CFrame})


]]
--btns:Seperator()
player = game.Players
char = player.LocalPlayer.Character
human = char.Humanoid
rootpart = char.HumanoidRootPart

-------------------------

function click()
    for i,v in pairs(workspace.__Main.__Enemies.Client:GetChildren()) do
        if v.HumanoidRootPart and v.HealthBar.Main.Bar.Amount.Text ~= "0 HP" then
            local dis = (rootpart.Position - v.HumanoidRootPart.Position).Magnitude
            if dis < 10 then
                local args = {
                    [1] = {
                        [1] = {
                            ["Event"] = "PunchAttack",
                            ["Enemy"] = v.Name
                        },
                        [2] = "\4"
                    }
                }
                
                game:GetService("ReplicatedStorage"):WaitForChild("BridgeNet2"):WaitForChild("dataRemoteEvent"):FireServer(unpack(args))
            end
        end
    end
end

function arise()
    for i,v in pairs(workspace.__Main.__Enemies.Client:GetChildren()) do
        if v.HumanoidRootPart:FindFirstChild("DestroyPrompt") and v.HumanoidRootPart:FindFirstChild("ArisePrompt") then
            v.HumanoidRootPart.ArisePrompt.MaxActivationDistance = math.huge
            wait()
                fireproximityprompt(v.HumanoidRootPart.ArisePrompt)
        end
    end 
end

function gems()
    for i,v in pairs(workspace.__Main.__Enemies.Client:GetChildren()) do
        if v.HumanoidRootPart:FindFirstChild("DestroyPrompt") and v.HumanoidRootPart:FindFirstChild("ArisePrompt") then
            v.HumanoidRootPart.DestroyPrompt.MaxActivationDistance = math.huge
             wait()
            fireproximityprompt(v.HumanoidRootPart.DestroyPrompt)
        end
    end 
end

function tp(x,y,z)
    char:SetPrimaryPartCFrame(CFrame.new(x, y, z))
end

function tween(x,y)
    if char and char.PrimaryPart then
        local TweenService = game:GetService("TweenService")
        local tweenInfo = TweenInfo.new(y)
        local tween = TweenService:Create(char.PrimaryPart, tweenInfo, {CFrame = x.CFrame * CFrame.new(0,0,5)})
        tween:Play()
    end
end

function attackEnemy(v, vv)
    local dis = (rootpart.Position - v.HumanoidRootPart.Position).Magnitude
    if dis < 20 then
        local args = {
            [1] = {
                [1] = {
                    ["PetPos"] = {
                        [vv] = v.HumanoidRootPart.Position
                    },
                    ["AttackType"] = "All",
                    ["Event"] = "Attack",
                    ["Enemy"] = v.Name
                },
                [2] = "\t"
            }
        }

        game:GetService("ReplicatedStorage"):WaitForChild("BridgeNet2"):WaitForChild("dataRemoteEvent"):FireServer(unpack(args))    
        repeat 
            wait() 
            dis = (rootpart.Position - v.HumanoidRootPart.Position).Magnitude 
        until v.HealthBar.Main.Bar.Amount.Text == "0 HP" or dis > 20
    end
end

-------------------------



btns:Toggle(
    "Auto-Click",
    false,
    function(bool)
        _G.click = bool
        while _G.click do wait()
            click()
        end
    end
)

btns:Seperator()
targetdis = 20
local sldr =
    btns:Slider(
    "Distance",
    0,
    60,
    20,
    function(t)
        targetdis = t
    end
)

btns:Toggle(
    "Auto-Target",
    false,
    function(bool)
        _G.target = bool
        while _G.target do wait()
            for _, pet in pairs(game:GetService("Players").LocalPlayer.leaderstats.Equips.Pets:GetAttributes()) do
                for i,v in pairs(workspace.__Main.__Enemies.Client:GetChildren()) do
                    if v.HumanoidRootPart and v.HealthBar.Main.Bar.Amount.Text ~= "0 HP" then
                        local dis = (rootpart.Position - v.HumanoidRootPart.Position).Magnitude
                        if dis < targetdis then
                            wait(0.5)
                            local args = {
                                [1] = {
                                    [1] = {
                                        ["PetPos"] = {
                                            [pet] = v.HumanoidRootPart.Position
                                        },
                                        ["AttackType"] = "All",
                                        ["Event"] = "Attack",
                                        ["Enemy"] = v.Name
                                    },
                                    [2] = "\t"
                                }
                            }
                            
                            game:GetService("ReplicatedStorage"):WaitForChild("BridgeNet2"):WaitForChild("dataRemoteEvent"):FireServer(unpack(args))    
                            repeat wait() local dis = (rootpart.Position - v.HumanoidRootPart.Position).Magnitude until v.HealthBar.Main.Bar.Amount.Text == "0 HP" or dis > targetdis
                        end
                    end
                end
            end
        end
    end
)


btns:Seperator()


btns:Label("Collect")


btns:Toggle(
    "Auto-Arise",
    false,
    function(bool)
        _G.arise = bool
        while _G.arise do wait(.5)
            arise()
        end
    end
)




btns:Toggle(
    "Auto-Gems",
    false,
    function(bool)
        _G.gems = bool
        while _G.gems do wait(.5)
           gems()
        end
    end
)
btns:Seperator()
btns:Toggle(
    "Tp Monster",
    false,
    function(bool)
        _G.tpmon = bool
        while _G.tpmon do wait(.5)
            for _, pet in pairs(game:GetService("Players").LocalPlayer.leaderstats.Equips.Pets:GetAttributes()) do
                for i,v in pairs(workspace.__Main.__Enemies.Client:GetChildren()) do
                    if v.HumanoidRootPart and v.HealthBar.Main.Bar.Amount.Text ~= "0 HP" then
                        local dis = (rootpart.Position - v.HumanoidRootPart.Position).Magnitude
                        local speed = dis/100
                        tween(v.HumanoidRootPart,speed)
                        repeat wait() local dis = (rootpart.Position - v.HumanoidRootPart.Position).Magnitude until  dis < 20 and v.HealthBar.Main.Bar.Amount.Text == "0 HP"
                    end
                end
            end
        end
    end
)



local dg = serv:Channel("Dungeon")
dg:Button(
    "Dungeon Find",
    function()
        for i,v in pairs(workspace.__Main.__Dungeon:GetDescendants()) do
            if v:isA("ProximityPrompt") then
                v.MaxActivationDistance = math.huge
                fireproximityprompt(v)
                end 
            end
    end
)


dg:Toggle(
    "Auto-Dungeon",
    false,
    function(bool)
        _G.dungeon = bool
        while _G.dungeon do wait()
            for _, pet in pairs(game:GetService("Players").LocalPlayer.leaderstats.Equips.Pets:GetAttributes()) do
                for i,v in pairs(workspace.__Main.__Enemies.Client:GetChildren()) do
                    if v.HumanoidRootPart and v.HealthBar.Main.Bar.Amount.Text ~= "0 HP" then
                        local dis = (rootpart.Position - v.HumanoidRootPart.Position).Magnitude
                        local speed = dis/80
                        tween(v.HumanoidRootPart,speed)
                        repeat wait() local dis = (rootpart.Position - v.HumanoidRootPart.Position).Magnitude until  dis < 20 and v.HealthBar.Main.Bar.Amount.Text == "0 HP"
                    end
                end
            end
        end
    end
)

targetdg = 8
local sldr =
dg:Slider(
    "Distance",
    0,
    60,
    8,
    function(t)
        targetdg = t
    end
)

dg:Toggle(
    "Auto-Click",
    false,
    function(bool)
        _G.target = bool
        while _G.target do wait()
            click()
        end
    end
)

dg:Toggle(
    "Auto-Target",
    false,
    function(bool)
        _G.target = bool
        while _G.target do wait()
            for _, pet in pairs(game:GetService("Players").LocalPlayer.leaderstats.Equips.Pets:GetAttributes()) do
                for i,v in pairs(workspace.__Main.__Enemies.Client:GetChildren()) do
                    if v.HumanoidRootPart and v.HealthBar.Main.Bar.Amount.Text ~= "0 HP" then
                        local dis = (rootpart.Position - v.HumanoidRootPart.Position).Magnitude
                        if dis < targetdg then
                            wait(0.5)
                            local args = {
                                [1] = {
                                    [1] = {
                                        ["PetPos"] = {
                                            [pet] = v.HumanoidRootPart.Position
                                        },
                                        ["AttackType"] = "All",
                                        ["Event"] = "Attack",
                                        ["Enemy"] = v.Name
                                    },
                                    [2] = "\t"
                                }
                            }
                            
                            game:GetService("ReplicatedStorage"):WaitForChild("BridgeNet2"):WaitForChild("dataRemoteEvent"):FireServer(unpack(args))    
                            repeat wait() local dis = (rootpart.Position - v.HumanoidRootPart.Position).Magnitude until v.HealthBar.Main.Bar.Amount.Text == "0 HP" or dis > targetdg
                        end
                    end
                end
            end
        end
    end
)

dg:Toggle(
    "Auto-Arise",
    false,
    function(bool)
        _G.arisedg = bool
        while _G.arisedg do wait(.5)
            arise()
            wait()
            arise()
            wait()
            arise()
        end
    end
)

local sldrs = serv:Channel("Game")










sldrs:Button(
    "Fast Mode",
    function()
        for key, object in pairs(workspace:GetDescendants()) do
            if object:IsA("Part") or object:IsA("UnionOperation") then
                 object.Material = Enum.Materal.SmoothPlastic
            end
        end
    end
)



sldrs:Button(
    "No hold CD",
    function()
        for i, v in pairs(game.workspace:GetDescendants()) do
           if v:isA("ProximityPrompt") then
            v.HoldDuration = 0 
           end
        end
    end
)




sldrs:Button(
    "Max Distance Proximity",
    function()
        for i, v in pairs(game.workspace:GetDescendants()) do
           if v:isA("ProximityPrompt") then
            v.MaxxActivationDistance = math.huge
           end
        end
    end
)

sldrs:Button(
    "Hop server",
    function()
        local Http = game:GetService("HttpService")
        local TPS = game:GetService("TeleportService")
        local Api = "https://games.roblox.com/v1/games/"

        local _place = game.PlaceId
        local _servers = Api.._place.."/servers/Public?sortOrder=Asc&limit=100"
        function ListServers(cursor)
        local Raw = game:HttpGet(_servers .. ((cursor and "&cursor="..cursor) or ""))
        return Http:JSONDecode(Raw)
        end

        local Server, Next; repeat
        local Servers = ListServers(Next)
        Server = Servers.data[1]
        Next = Servers.nextPageCursor
        until Server

        TPS:TeleportToPlaceInstance(_place,Server.id,game.Players.LocalPlayer)
    end
)


sldrs:Textbox(
    "WalkSpeed",
    "Type here!",
    true,
    function(t)
        human.WalkSpeed = t
    end
)


sldrs:Textbox(
    "JumpPower",
    "Type here!",
    true,
    function(t)
        human.JumpPower = t
    end
)


  
---------------

local tps = serv:Channel("Teleport")





tps:Label("Double Click")

tps:Button(
    "Solo-World",
    function()
        tp(578, 28, 261)
    end
)
tps:Button(
    "One-Piece",
    function()
        tp(-2851, 49, -2011)
    end
)

tps:Button(
    "Naruto",
    function()
        tp(-3380, 30, 2257)
    end
)
tps:Button(
    "Bleach",
    function()
        tp(2642, 45, -2645)
    end
)
tps:Button(
    "Black Clover",
    function()
        tp(198, 39, 4296)
    end
)

tps:Button(
    "Jeju",
    function()
        tp(3852, 60, 3087)
    end
)
tps:Button(
    "Safe Jeju",
    function()
        tp(3768, 326, 3104)
    end
)

------------
local mountain = serv:Channel("Mountain")
mountain:Button(
    "M1",
    function()
        tp(-6140, 78, 5472)
    end
)
mountain:Button(
    "M2",
    function()
        tp(-5869, 81, 388)
    end
)
mountain:Button(
    "M3",
    function()
        tp(-5427, 107, -5496)
    end
)
mountain:Button(
    "M4",
    function()
        tp(-690, 108, -3554)
    end
)
mountain:Button(
    "M5",
    function()
        tp(450, 118, 3435)
    end
)
mountain:Button(
    "M6",
    function()
        tp(3230, 78, 36)
    end
)
mountain:Button(
    "M7",
    function()
        tp(4321, 119, -4808)
    end
)








---------

local setspawn = serv:Channel("Set-Spawn")

setspawn:Button(
    "Solo World",
    function()
        local args = {
            [1] = {
                [1] = {
                    ["Event"] = "ChangeSpawn",
                    ["Spawn"] = "SoloWorld"
                },
                [2] = "\n"
            }
        }
        
        game:GetService("ReplicatedStorage"):WaitForChild("BridgeNet2"):WaitForChild("dataRemoteEvent"):FireServer(unpack(args))        
    end
)


setspawn:Button(
    "One Piece",
    function()
        local args = {
            [1] = {
                [1] = {
                    ["Event"] = "ChangeSpawn",
                    ["Spawn"] = "OPWorld"
                },
                [2] = "\n"
            }
        }
        
        game:GetService("ReplicatedStorage"):WaitForChild("BridgeNet2"):WaitForChild("dataRemoteEvent"):FireServer(unpack(args))
    end
)

setspawn:Button(
    "Naruto",
    function()
        local args = {
            [1] = {
                [1] = {
                    ["Event"] = "ChangeSpawn",
                    ["Spawn"] = "NarutoWorld"
                },
                [2] = "\n"
            }
        }
        
        game:GetService("ReplicatedStorage"):WaitForChild("BridgeNet2"):WaitForChild("dataRemoteEvent"):FireServer(unpack(args))
    end
)



setspawn:Button(
    "Bleach",
    function()
        local args = {
            [1] = {
                [1] = {
                    ["Event"] = "ChangeSpawn",
                    ["Spawn"] = "BleachWorld"
                },
                [2] = "\n"
            }
        }
        
        game:GetService("ReplicatedStorage"):WaitForChild("BridgeNet2"):WaitForChild("dataRemoteEvent"):FireServer(unpack(args))
    end
)

setspawn:Button(
    "Black Clover",
    function()
        local args = {
            [1] = {
                [1] = {
                    ["Event"] = "ChangeSpawn",
                    ["Spawn"] = "BCWorld"
                },
                [2] = "\n"
            }
        }
        
        game:GetService("ReplicatedStorage"):WaitForChild("BridgeNet2"):WaitForChild("dataRemoteEvent"):FireServer(unpack(args))
    end
)






local secondser = win:Server("Main", "http://www.roblox.com/asset/?id=6031075938")




local drops = secondser:Channel("Dropdowns")

local drop =
    drops:Dropdown(
    "Pick me!",
    {"Option 1", "Option 2", "Option 3", "Option 4", "Option 5"},
    function(bool)
        print(bool)
    end
)

drops:Button(
    "Clear",
    function()
        drop:Clear()
    end
)

drops:Button(
    "Add option",
    function()
        drop:Add("Option")
    end
)

local clrs = secondser:Channel("Colorpickers")

clrs:Colorpicker(
    "ESP Color",
    Color3.fromRGB(255, 1, 1),
    function(t)
        print(t)
    end
)

local textbs = secondser:Channel("Textboxes")

textbs:Textbox(
    "Gun power",
    "Type here!",
    true,
    function(t)
        print(t)
    end
)

local lbls = secondser:Channel("Labels")

lbls:Label("This is just a label.")

local bnds = secondser:Channel("Binds")

bnds:Bind(
    "Kill bind",
    Enum.KeyCode.RightShift,
    function()
        print("Killed everyone!")
    end
)

secondser:Channel("by dawid#7205")