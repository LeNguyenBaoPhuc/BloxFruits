local setting = {
	['Distance'] = 60,
	['Height'] = 250
}

local ScreenGui = Instance.new("ScreenGui")
local strafeToggle = Instance.new("Frame")
local TextButton = Instance.new("TextButton")

ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

strafeToggle.Name = "strafeToggle"
strafeToggle.Parent = ScreenGui
strafeToggle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
strafeToggle.BorderColor3 = Color3.fromRGB(0, 0, 0)
strafeToggle.BorderSizePixel = 0
strafeToggle.Position = UDim2.new(0.899999976, 0, 0.300000012, 0)
strafeToggle.Size = UDim2.new(0, 75, 0, 75)

TextButton.Parent = strafeToggle
TextButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextButton.BorderSizePixel = 0
TextButton.Size = UDim2.new(1, 0, 1, 0)
TextButton.Font = Enum.Font.SourceSans
TextButton.Text = "Off"
TextButton.TextColor3 = Color3.fromRGB(0, 0, 0)
TextButton.TextSize = 14.000

local function IFIGMQ_fake_script()
	local script = Instance.new('LocalScript', TextButton)

	local parent = script.Parent
	local lp = game.Players.LocalPlayer
	local tween
	
	local currentAngle = 1
	
	local config_distance = setting.Distance
	local config_height = setting.Height	
	
	
	local seaFolder = workspace.SeaBeasts
	local function TP(P1)
		local Distance = (P1.Position - lp.Character:FindFirstChild("HumanoidRootPart").Position).Magnitude
		tween = game:GetService("TweenService"):Create(
			lp.Character:FindFirstChild("HumanoidRootPart"),
			TweenInfo.new(Distance/350, Enum.EasingStyle.Linear),
			{CFrame = P1}
		)
		tween:Play()
	end
	
	local function bodyMover()
		local has_bodyVelocity = lp.Character.HumanoidRootPart:FindFirstChild("SexyBody")
		if has_bodyVelocity then
			if parent.Text == "Off" then
				has_bodyVelocity:Destroy()
			end
		else
			if parent.Text == "On" then
				local bodyMover = Instance.new("BodyVelocity", lp.Character.HumanoidRootPart)
				bodyMover.Name = "SexyBody"
				bodyMover.Velocity = Vector3.new(0, 0, 0);
				bodyMover.MaxForce = Vector3.new(9e9, 9e9, 9e9)
			end
		end
	end
	
	local function circular(cf)
		local angle = math.rad(currentAngle)
		TP(cf * CFrame.new(config_distance * math.cos(angle), config_height , config_distance * math.sin(angle)))
		currentAngle = currentAngle + 15
		if currentAngle >= 360 then
			currentAngle = 1
		end
	end
	
	parent.MouseButton1Click:Connect(function()
		if parent.Text == "Off" then
			parent.Text = "On"
			bodyMover()
			repeat
				task.wait()
				local leviathan = seaFolder:FindFirstChild("Leviathan") 
				if leviathan and (leviathan.Hitbox13.Position - lp.Character.HumanoidRootPart.Position).Magnitude <= 100000 and leviathan.Hitbox13.Position.Y >= 50 then
					circular(leviathan.Hitbox13.CFrame)
				end
			until parent.Text ~= "On"
		elseif parent.Text == "On" then
			parent.Text = "Off"
			if tween then
				tween:Cancel()
			end
			bodyMover()
		else
			parent.Text = "Off"
		end
	end)
end

coroutine.wrap(IFIGMQ_fake_script)()

local Part = Instance.new("Part", game:GetService("Workspace"))
Part.Transparency = 1
Part.Anchored = true
Part.CanCollide = true
Part.Size = Vector3.new(2500, 100, 2500)

spawn(function()
	while wait() do
        Part.Position = Vector3.new(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position.X, -((Part.Size.Y / 2) + 4), game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position.Z)
	end
end)
