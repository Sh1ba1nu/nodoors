local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()

OrionLib:MakeNotification({
	Name = "nodoors",
	Content = "made by ccdev and a guy",
	Image = "rbxassetid://4483345998",
	Time = 5
})


local Window = OrionLib:MakeWindow({Name = "nodoors", HidePremium = false, SaveConfig = true, ConfigFolder = "Orion"})

local PlayerTab = Window:MakeTab({
	Name = "Player",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

local FunTab = Window:MakeTab({
	Name = "Fun",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

local PlayerSection = PlayerTab:AddSection({
	Name = "Player"
})

local MovementSection = PlayerTab:AddSection({
	Name = "Movment"
})


local ItemSection = FunTab:AddSection({
	Name = "Items (not FE)"
})

ItemSection:AddButton({
	Name = "Shears",
	Color = Color3.fromRGB(255,255,255),
	Callback = function()
		local Tool = game:GetObjects("rbxassetid://12685165702")[1]
		local Humanoid = game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
		local Sound = Instance.new("Sound")

		Tool.Parent = game.Players.LocalPlayer.Backpack

		Sound.PlaybackSpeed = 1.25
		Sound.SoundId = "rbxassetid://9118823101"
		Sound.Parent = Tool

		Tool.Activated:Connect(function()
			local Use = Tool.Animations.use
			local UseTrack = Humanoid:LoadAnimation(Use)

			UseTrack:Play()
			Sound:Play()
			wait(0.25)
			Sound:Play()
			game:GetService("Players").LocalPlayer:GetMouse().Target:FindFirstAncestorOfClass("Model"):Destroy()
		end)

		Tool.Equipped:Connect(function()
			local Idle = Tool.Animations.idle
			local IdleTrack = Humanoid:LoadAnimation(Idle)

			IdleTrack:Play()
		end)
		Tool.Unequipped:Connect(function()
			for _,anim in pairs(Humanoid.Animator:GetPlayingAnimationTracks()) do
				anim:Stop()
			end
		end)
	end
})

ItemSection:AddButton({
	Name = "Crusifix on anything",
	Color = Color3.fromRGB(255,255,255),
	Callback = function()
		_G.Uses = 100
		_G.Range = 30
		_G.OnAnything = true
		_G.Fail = false
		loadstring(game:HttpGet('https://raw.githubusercontent.com/PenguinManiack/Crucifix/main/Crucifix.lua'))()
	end
})

MovementSection:AddSlider({
	Name = "speed",
	Min = 1,
	Max = 21,
	Default = 16,
	Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	ValueName = "speed",
	Callback = function(Value)
		getgenv().WalkSpeedValue = Value;
		local Player = game:service'Players'.LocalPlayer;
			Player.Character.Humanoid:GetPropertyChangedSignal'WalkSpeed':Connect(function()
			Player.Character.Humanoid.WalkSpeed = getgenv().WalkSpeedValue;
		end)
		Player.Character.Humanoid.WalkSpeed = getgenv().WalkSpeedValue;
	end    
})

MovementSection:AddToggle({
    Name = "noclip",
    Default = false,
    Callback = function(Value)
        local Noclip = nil
        local Clip = true -- set the initial state to "enabled"

        function noclip()
            Clip = false
            local function Nocl()
                if Clip == false and game.Players.LocalPlayer.Character ~= nil then
                    for _,v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                        if v:IsA('BasePart') and v.CanCollide and v.Name ~= floatName then
                            v.CanCollide = false
                        end
                    end
                end
                wait(0.21)
            end
            Noclip = game:GetService('RunService').Stepped:Connect(Nocl)
        end

        function clip()
            if Noclip then Noclip:Disconnect() end
            Clip = true
        end

        -- toggle the state based on the current value
        if Value ~= Clip then
            Clip = Value
            if Clip then
                clip()
            else
                noclip()
            end
        end
    end
})

local SettingsTab = Window:MakeTab({
	Name = "Settings",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

local SettingsSection = SettingsTab:AddSection({
	Name = "Settings"
})

SettingsSection:AddButton({
	Name = "Destroy UI",
	Callback = function()
        OrionLib:Destroy()
  	end    
})

OrionLib:Init()
