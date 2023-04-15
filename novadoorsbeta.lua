local library = loadstring(game:GetObjects("rbxassetid://7657867786")[1].Source)()
local Wait = library.subs.Wait

local nod = library:CreateWindow({Name = "NovaDoors", Themeable = {Info = "Made By CCdev#8836 & shiba inu#2346"}})

local GeneralTab = nod:CreateTab({Name = "General"})
local FunTab = nod:CreateTab({Name = "Fun"})
local FarmingSection = GeneralTab:CreateSection({Name = "Farming"})
local MovementSection = GeneralTab:CreateSection({Name = "Movment"})
local ItemSection = FunTab:CreateSection({Name = "Items (not FE)"})
local MiscSection = GeneralTab:CreateSection({Name = "Misc",Side = "Right"})

_G.walktp = false
_G.noclip = false

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
	Name = "tpwalk",
	Callback = function(Value)
		_G.walktp = Value
		spawn(function()
		local player = game.Players.LocalPlayer
		local character = player.Character or player.CharacterAdded:Wait()
		local humanoid = character:WaitForChild("Humanoid")
		print(_G.walktp)
		while _G.walktp == true do
			local direction = character.Humanoid.MoveDirection
			if direction.Magnitude > 0 then
				local newPosition = character.HumanoidRootPart.Position + direction.Unit * 3.8
				if _G.walktp then
					player.Character:SetPrimaryPartCFrame(CFrame.new(newPosition))
				else
					player.Character:SetPrimaryPartCFrame(CFrame.new(newPosition, newPosition + Vector3.new(0, -1, 0)))
				end
			end
			wait(0.2)

			local ray = Ray.new(character.HumanoidRootPart.Position, Vector3.new(0, -1, 0))
			local hit, position = workspace:FindPartOnRay(ray, character)
			if hit then
				if _G.walktp then
					player.Character:SetPrimaryPartCFrame(CFrame.new(position))
				else
					player.Character:SetPrimaryPartCFrame(CFrame.new(position, position + Vector3.new(0, 1, 0)))
				end
			end
		end
	end)
end    
})

MovementSection:AddToggle({
    Name = "noclip",
    Parent = MovementSection,
    Callback = function(Value)
        _G.noclip = Value
        spawn(function()
            local character = game.Players.LocalPlayer.Character

            while true do
                for i,v in pairs(character:GetDescendants()) do
                    pcall(function()
                        if v:IsA("BasePart") then
                            if _G.noclip == true then
                                v.CanCollide = false
                            else
                                wait()
                            end
                        end
                    end)
                end
                task.wait()
            end
        end)
    end
})

MiscSection:AddButton({
	Name = "Revive",
	Callback = function()
		game:GetService("ReplicatedStorage")EntityInfo.Revive:FireServer()	
	end
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
	Name = "Crucifix on anything",
	Color = Color3.fromRGB(255,255,255),
	Callback = function()
		_G.Uses = 100
		_G.Range = 30
		_G.OnAnything = true
		_G.Fail = false
		loadstring(game:HttpGet('https://raw.githubusercontent.com/PenguinManiack/Crucifix/main/Crucifix.lua'))()
	end
})
