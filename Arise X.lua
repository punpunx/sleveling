repeat wait() until game:IsLoaded() and game.Players and game.Players.LocalPlayer and game.Players.LocalPlayer.Character
if not game.CoreGui:FindFirstChild("ScreenGui") then
    local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
    local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
    local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

    local Window = Fluent:CreateWindow({
        Title = "Arise Crossover" .. " v.1.0",
        SubTitle = "by Pixie",
        TabWidth = 160,
        Size = UDim2.fromOffset(580, 460),
        Acrylic = true, 
        Theme = "Dark",
        MinimizeKey = Enum.KeyCode.LeftControl
    })



    player = game.Players
    char = player.LocalPlayer.Character
    human = char.Humanoid
    rootpart = char.HumanoidRootPart


    -----------------------
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

    ----------------------

    local Tabs = {
        Main = Window:AddTab({ Title = "Main", Icon = "" }),
        dg = Window:AddTab({ Title = "Dungoen", Icon = "" }),
        localps = Window:AddTab({ Title = "LocalPlayer", Icon = "" }),
        tpisland = Window:AddTab({ Title = "Tp Island&Mountain", Icon = "" }),
        setsp = Window:AddTab({ Title = "Set Spawn", Icon = "" }),
        Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
    }

    local Options = Fluent.Options

    do
        Fluent:Notify({
            Title = "Pixie",
            Content = "Thank for Using",
            SubContent = "------------", -- Optional
            Duration = 5 -- Set to nil to make the notification not disappear
        })

        local autoclick = Tabs.Main:AddToggle("atclick", {Title = "Auto-Click", Default = false })

        autoclick:OnChanged(function()
            _G.click = Options.atclick.Value
            while _G.click do wait()
                click()
            end
        end)

        targetdis = 15
        local mondis = Tabs.Main:AddSlider("Slider", {
            Title = "Distance :",
            Description = "Target Distance",
            Default = 15,
            Min = 0,
            Max = 61,
            Rounding = .1,
            Callback = function(Value)
                targetdis = Value
            end
        })

    local autotarget = Tabs.Main:AddToggle("targ", {Title = "Auto-Target", Default = false })

    autotarget:OnChanged(function()
        _G.target = Options.targ.Value
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
    end)

    local autoarise = Tabs.Main:AddToggle("arisee", {Title = "Auto-Arise", Default = false })

    autoarise:OnChanged(function()
        _G.arise = Options.arisee.Value
        while _G.arise do wait(.5)
            arise()
        end
    end)

    local autodes = Tabs.Main:AddToggle("dess", {Title = "Auto-Gems", Default = false })

    autodes:OnChanged(function()
        _G.gems = Options.dess.Value
        while _G.gems do wait(.5)
            gems()
        end
    end)

        Tabs.Main:AddParagraph({
            Title = "Mons-Farm",
            Content = ""
        })

    local tpmob = Tabs.Main:AddToggle("tpmonn", {Title = "Tp-Monster", Default = false })

    tpmob:OnChanged(function()
        _G.tpmon = Options.tpmonn.Value
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
    end)


        Tabs.dg:AddButton({
            Title = "Dungeon",
            Description = "Find Dungeon",
            Callback = function()
                for i,v in pairs(workspace.__Main.__Dungeon:GetDescendants()) do
                    if v:isA("ProximityPrompt") then
                        v.MaxActivationDistance = math.huge
                        fireproximityprompt(v)
                        end 
                    end
            end
        })

        local autodun = Tabs.dg:AddToggle("autodung", {Title = "Auto-Dungeon", Default = false })

        autodun:OnChanged(function()
            _G.dungeon = Options.autodung.Value
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
        end)

        local atk = Tabs.dg:AddToggle("atc", {Title = "Auto-Click", Default = false })

        atk:OnChanged(function()
            _G.clk = Options.atc.Value
            while _G.clk do wait()
                click()
            end
        end)

        local att = Tabs.dg:AddToggle("targg", {Title = "Auto-Target", Default = false })

        att:OnChanged(function()
        _G.targett = Options.targg.Value
            while _G.targett do wait()
                for _, pet in pairs(game:GetService("Players").LocalPlayer.leaderstats.Equips.Pets:GetAttributes()) do
                    for i,v in pairs(workspace.__Main.__Enemies.Client:GetChildren()) do
                        if v.HumanoidRootPart and v.HealthBar.Main.Bar.Amount.Text ~= "0 HP" then
                            local dis = (rootpart.Position - v.HumanoidRootPart.Position).Magnitude
                            if dis < 8 then
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
                                repeat wait() local dis = (rootpart.Position - v.HumanoidRootPart.Position).Magnitude until v.HealthBar.Main.Bar.Amount.Text == "0 HP" or dis > 8
                            end
                        end
                    end
                end
            end
    end)

    local autoarisee = Tabs.dg:AddToggle("ariseee", {Title = "Auto-Arise", Default = false })

    autoarisee:OnChanged(function()
        _G.arisee = Options.ariseee.Value
        while _G.arisee do wait()
            arise()
            wait()
            arise()
        end
    end)

        Tabs.localps:AddButton({
            Title = "No Prompt Cooldown",
            Description = nil,
            Callback = function()
                for i, v in pairs(game.workspace:GetDescendants()) do
                    if v:isA("ProximityPrompt") then
                    v.HoldDuration = 0 
                    end
                end
            end
        })
        
        Tabs.localps:AddButton({
            Title = "Max Distance Proximity",
            Description = nil,
            Callback = function()
                for i, v in pairs(game.workspace:GetDescendants()) do
                    if v:isA("ProximityPrompt") then
                    v.MaxxActivationDistance = math.huge
                    end
                end
            end
        })

        Tabs.localps:AddButton({
            Title = "Hop server",
            Description = "Low Players Server",
            Callback = function()
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
        })

        Tabs.localps:AddButton({
            Title = "Hop & Rejoin",
            Description = "Many Players Server",
            Callback = function()
                local ts = game:GetService("TeleportService")
                local p = game:GetService("Players").LocalPlayer
                ts:Teleport(game.PlaceId, p)
            end
        })

        local walkspeedinput = Tabs.localps:AddInput("Input", {
            Title = "WalkSpeed",
            Default = "",
            Placeholder = "Type",
            Numeric = true, 
            Finished = true, 
            Callback = function(Value)
                human.WalkSpeed = Value
            end
        })
        local jumppowerinput = Tabs.localps:AddInput("Input", {
            Title = "JumpPwer",
            Default = "",
            Placeholder = "Type",
            Numeric = true, 
            Finished = true, 
            Callback = function(Value)
                human.JumpPower = Value
            end
        })

        Tabs.localps:AddButton({
            Title = "Admin",
            Description = "Infinite X",
            Callback = function()
                loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
            end
        })

        Tabs.tpisland:AddButton({
            Title = "SoloWorld",
            Description = nil,
            Callback = function()
                tp(578, 28, 261)
            end
        })
        
        Tabs.tpisland:AddButton({
            Title = "OnePiece",
            Description = nil,
            Callback = function()
                tp(-2851, 49, -2011)
            end
        })
        
        Tabs.tpisland:AddButton({
            Title = "Naruto",
            Description = nil,
            Callback = function()
                tp(-3380, 30, 2257)
            end
        })
        
        Tabs.tpisland:AddButton({
            Title = "Bleach",
            Description = nil,
            Callback = function()
                tp(2642, 45, -2645)
            end
        })
        
        Tabs.tpisland:AddButton({
            Title = "BlackClover",
            Description = nil,
            Callback = function()
                tp(198, 39, 4296)
            end
        })
        
        Tabs.tpisland:AddButton({
            Title = "Jeju",
            Description = nil,
            Callback = function()
                tp(3852, 60, 3087)
            end
        })
        
        Tabs.tpisland:AddButton({
            Title = "Safe Jeju",
            Description = nil,
            Callback = function()
                tp(3768, 326, 3104)
            end
        })

        Tabs.tpisland:AddParagraph({
            Title = "Mountain",
            Content = nil
        })
        Tabs.tpisland:AddButton({
            Title = "M1",
            Description = nil,
            Callback = function()
                tp(-6140, 78, 5472)
            end
        })
        
        Tabs.tpisland:AddButton({
            Title = "M2",
            Description = nil,
            Callback = function()
                tp(-5869, 81, 388)
            end
        })
        
        Tabs.tpisland:AddButton({
            Title = "M3",
            Description = nil,
            Callback = function()
                tp(-5427, 107, -5496)
            end
        })
        
        Tabs.tpisland:AddButton({
            Title = "M4",
            Description = nil,
            Callback = function()
                tp(-690, 108, -3554)
            end
        })
        
        Tabs.tpisland:AddButton({
            Title = "M5",
            Description = nil,
            Callback = function()
                tp(450, 118, 3435)
            end
        })
        
        Tabs.tpisland:AddButton({
            Title = "M6",
            Description = nil,
            Callback = function()
                tp(3230, 78, 36)
            end
        })
        
        Tabs.tpisland:AddButton({
            Title = "M7",
            Description = nil,
            Callback = function()
                tp(4321, 119, -4808)
            end
        })
        
        
        Tabs.setsp:AddButton({
            Title = "Solo World",
            Description = nil,
            Callback = function()
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
        })
        
        Tabs.setsp:AddButton({
            Title = "One Piece | Brum",
            Description = nil,
            Callback = function()
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
        })
        
        Tabs.setsp:AddButton({
            Title = "Naruto | Grass",
            Description = nil,
            Callback = function()
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
        })
        
        Tabs.setsp:AddButton({
            Title = "Bleach | ???",
            Description = nil,
            Callback = function()
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
        })
        
        Tabs.setsp:AddButton({
            Title = "Black Clover | Lucky",
            Description = nil,
            Callback = function()
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
        })
        


    end 
    --------------------

    SaveManager:SetLibrary(Fluent)
    InterfaceManager:SetLibrary(Fluent)

    SaveManager:IgnoreThemeSettings()

    SaveManager:SetIgnoreIndexes({})

    InterfaceManager:SetFolder("FluentScriptHub")
    SaveManager:SetFolder("FluentScriptHub/Arise-Crossover")

    InterfaceManager:BuildInterfaceSection(Tabs.Settings)
    SaveManager:BuildConfigSection(Tabs.Settings)

    Window:SelectTab(1)

    Fluent:Notify({
        Title = "Pixie Loaded Ui",
        Content = "The script has been loaded.",
        Duration = 8
    })

    SaveManager:LoadAutoloadConfig()



    KeepArise = true
    queueteleport = (syn and syn.queue_on_teleport) or queue_on_teleport or (fluxus and fluxus.queue_on_teleport)
    local TeleportCheck = false
    player.LocalPlayer.OnTeleport:Connect(function(State)
        if KeepArise and (not TeleportCheck) and queueteleport then
            TeleportCheck = true
            queueteleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/punpunx/sleveling/refs/heads/main/Arise%20X.lua'))()")
        end
    end)


end