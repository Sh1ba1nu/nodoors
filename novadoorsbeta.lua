local library = loadstring(game:GetObjects("rbxassetid://7657867786")[1].Source)()
local Wait = library.subs.Wait

local nod = library:CreateWindow({Name = "NovaDoors", Themeable = {Info = "Made By CCdev#8836 & shiba inu#2346"}})

local GeneralTab = nod:CreateTab({Name = "General"})
local FunTab = nod:CreateTab({Name = "Fun"})
local FarmingSection = GeneralTab:CreateSection({Name = "Farming"})
local MovementSection = GeneralTab:CreateSection({Name = "Movment"})
local ItemSection = FunTab:CreateSection({Name = "Items (not FE)"})
local MiscSection = GeneralTab:CreateSection({Name = "Misc",Side = "Right"})
local VisualSection = GeneralTab:CreateSection({Name = "Visual"})

_G.walktp = false
_G.noclip = false
_G.esp = false
_G.fastuse = false


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

VisualSection:AddToggle({
    Name = "Door esp",
    Callback = function(Value)
        _G.esp = Value
        spawn(function()
            local billboardedRooms = {}
            while _G.esp == true do
                wait(0.01)
                for _, model in ipairs(game.workspace.CurrentRooms:GetChildren()) do
                    if not billboardedRooms[model] then 
                        for _, v in ipairs(model:GetDescendants()) do
                            if v.Name == "RoomExit" and v:IsA("BasePart") then
                                local gui = Instance.new("BillboardGui", v)
                                gui.Name = "esp"
                                gui.Size = UDim2.new(10, 0, 10, 0)
                                gui.AlwaysOnTop = true
                                gui.LightInfluence = 0

                                local frame = Instance.new("Frame", gui)
                                frame.Size = UDim2.new(0.5, 0, 0.5, 0)
                                frame.BackgroundTransparency = 1
                                frame.BorderSizePixel = 0
                                frame.BackgroundColor3 = Color3.new(0, 255, 0)

                                local label = Instance.new("TextLabel", frame)
                                label.Size = UDim2.new(2, 0, 2, 0)
                                label.BorderSizePixel = 0
                                label.TextSize = 20
				label.BackgroundColor3 = Color3.new(0, 255, 0)
                                
                                spawn(function()
                                    while gui.Parent == v do
                                        local distance = math.floor((v.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude)
                                        label.Text = " [ " .. tostring(distance) .. " ]"
                                        wait(0.01)
                                    end
                                end)

                                label.BackgroundTransparency = 1
                                billboardedRooms[model] = true
                            end
                        end
                    end
                end
            end     
        end)
    end
})

VisualSection:AddButton({
    Name = "clear esp",
    Callback = function()
        local function deleteDescendants(obj)
            for _, descendant in pairs(obj:GetDescendants()) do
                descendant:Destroy()
            end
        end

        local currentRooms = game.workspace.CurrentRooms
        for _, descendant in pairs(currentRooms:GetDescendants()) do
            if descendant.Name == "RoomExit" then
                deleteDescendants(descendant)
            end
        end
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

MiscSection:AddToggle({
    Name = "fast use",
    Callback = function(Value)
        _G.fastuse = Value
        spawn(function()
            while true do
                if _G.fastuse == true then
                    for _, room in pairs(workspace.CurrentRooms:GetChildren()) do
                        if room:FindFirstChild("Door") then
                            local door = room.Door

                            if door:FindFirstChild("Lock") then
                                door.Lock.UnlockPrompt.HoldDuration = 0
                            end
                        end
                    end
                else
                    for _, room in pairs(workspace.CurrentRooms:GetChildren()) do
                        if room:FindFirstChild("Door") then
                            local door = room.Door

                            if door:FindFirstChild("Lock") then
                                door.Lock.UnlockPrompt.HoldDuration = 2
                            end
                        end
                    end
                end
                wait(0.5)
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

ItemSection:AddButton({
	Name = "Shears on anything",
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
