-- By StormWare

-- Instances:

local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local framE = Instance.new("Frame")
local StormWare = Instance.new("TextLabel")
local Toggle = Instance.new("TextButton")
local TextLabel = Instance.new("TextLabel")
local Toggle2 = Instance.new("TextButton")
local TextLabel_2 = Instance.new("TextLabel")

--Properties:

ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(65, 65, 65)
Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
Frame.BorderSizePixel = 0
Frame.Position = UDim2.new(0.37823835, 0, 0.286008239, 0)
Frame.Size = UDim2.new(0, 217, 0, 56)
Frame.Draggable = true
Frame.Active = true

framE.Name = "framE"
framE.Parent = Frame
framE.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
framE.BorderColor3 = Color3.fromRGB(0, 0, 0)
framE.BorderSizePixel = 0
framE.Size = UDim2.new(0, 217, 0, 19)

StormWare.Name = "StormWare"
StormWare.Parent = Frame
StormWare.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
StormWare.BackgroundTransparency = 1.000
StormWare.BorderColor3 = Color3.fromRGB(0, 0, 0)
StormWare.BorderSizePixel = 0
StormWare.Position = UDim2.new(0.170506909, 0, -0.0178571437, 0)
StormWare.Size = UDim2.new(0, 143, 0, 20)
StormWare.Font = Enum.Font.SourceSansBold
StormWare.Text = "StormWare | Mobile Aimbot"
StormWare.TextColor3 = Color3.fromRGB(255, 255, 255)
StormWare.TextSize = 14.000

Toggle.Name = "Toggle"
Toggle.Parent = Frame
Toggle.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Toggle.BorderColor3 = Color3.fromRGB(0, 0, 0)
Toggle.BorderSizePixel = 0
Toggle.Position = UDim2.new(0.0737327188, 0, 0.5, 0)
Toggle.Size = UDim2.new(0, 21, 0, 17)
Toggle.Font = Enum.Font.SourceSans
Toggle.Text = ""
Toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
Toggle.TextSize = 14.000

TextLabel.Parent = Frame
TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.BackgroundTransparency = 1.000
TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextLabel.BorderSizePixel = 0
TextLabel.Position = UDim2.new(0.129032254, 0, 0.5, 0)
TextLabel.Size = UDim2.new(0, 85, 0, 19)
TextLabel.Font = Enum.Font.SourceSansBold
TextLabel.Text = "Aimbot"
TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.TextSize = 14.000

Toggle2.Name = "Toggle2"
Toggle2.Parent = Frame
Toggle2.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Toggle2.BorderColor3 = Color3.fromRGB(0, 0, 0)
Toggle2.BorderSizePixel = 0
Toggle2.Position = UDim2.new(0.49308756, 0, 0.5, 0)
Toggle2.Size = UDim2.new(0, 21, 0, 17)
Toggle2.Font = Enum.Font.SourceSans
Toggle2.Text = ""
Toggle2.TextColor3 = Color3.fromRGB(255, 255, 255)
Toggle2.TextSize = 14.000

TextLabel_2.Parent = Frame
TextLabel_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_2.BackgroundTransparency = 1.000
TextLabel_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextLabel_2.BorderSizePixel = 0
TextLabel_2.Position = UDim2.new(0.56221199, 0, 0.5, 0)
TextLabel_2.Size = UDim2.new(0, 85, 0, 19)
TextLabel_2.Font = Enum.Font.SourceSansBold
TextLabel_2.Text = "TeamCheck"
TextLabel_2.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_2.TextSize = 14.000

-- Scripts:

local function SMRSUOV_fake_script() -- Toggle.LocalScript 
	local script = Instance.new('LocalScript', Toggle)

	local players = game:GetService("Players")
	local localPlayer = players.LocalPlayer
	local mouse = localPlayer:GetMouse()
	local runService = game:GetService("RunService")
	
	local aimAssistEnabled = false
	local aimButton = script.Parent -- Assuming the script is a child of the button
	
	local function isVisible(target)
		-- Perform a raycast to check if the target is visible
		local origin = localPlayer.Character.Head.Position
		local direction = (target.Position - origin).unit * 1000
		local raycastParams = RaycastParams.new()
		raycastParams.FilterDescendantsInstances = {localPlayer.Character}
		raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
	
		local result = workspace:Raycast(origin, direction, raycastParams)
		if result and result.Instance:IsDescendantOf(target.Parent) then
			return true
		end
		return false
	end
	
	local function getClosestTarget()
		local closestTarget = nil
		local shortestDistance = math.huge
	
		for _, player in pairs(players:GetPlayers()) do
			if player ~= localPlayer and player.Character and player.Character:FindFirstChild("Head") then
				local targetHead = player.Character.Head
				if isVisible(targetHead) then
					local distance = (targetHead.Position - localPlayer.Character.Head.Position).magnitude
					if distance < shortestDistance then
						closestTarget = targetHead
						shortestDistance = distance
					end
				end
			end
		end
	
		return closestTarget
	end
	
	local function aimAt(target)
		local camera = workspace.CurrentCamera
		camera.CFrame = CFrame.new(camera.CFrame.Position, target.Position)
	end
	
	local function onRenderStep()
		if aimAssistEnabled then
			local closestTarget = getClosestTarget()
			if closestTarget then
				aimAt(closestTarget)
			end
		end
	end
	
	aimButton.MouseButton1Click:Connect(function()
		aimAssistEnabled = not aimAssistEnabled
		aimButton.Text = aimAssistEnabled and "x" or " "
	end)
	
	runService.RenderStepped:Connect(onRenderStep)
	
end
coroutine.wrap(SMRSUOV_fake_script)()
local function QCECC_fake_script() -- Toggle2.LocalScript 
	local script = Instance.new('LocalScript', Toggle2)

	local players = game:GetService("Players")
	local localPlayer = players.LocalPlayer
	local mouse = localPlayer:GetMouse()
	local runService = game:GetService("RunService")
	
	local aimAssistEnabled = false
	local aimButton = script.Parent -- Assuming the script is a child of the button
	
	-- Create the FOV circle
	local screenGui = Instance.new("ScreenGui", localPlayer:WaitForChild("PlayerGui"))
	local fovCircle = Instance.new("Frame", screenGui)
	fovCircle.Size = UDim2.new(0, 140, 0, 140) -- Diameter of the circle (2 * 70 + padding)
	fovCircle.Position = UDim2.new(0.5, -70, 0.5, -70) -- Center on screen
	fovCircle.BackgroundColor3 = Color3.new(1, 0, 0) -- Red color for the circle
	fovCircle.BackgroundTransparency = 0.5 -- Set a transparency level
	fovCircle.AnchorPoint = Vector2.new(0.5, 0.5) -- Anchor to the center of the circle
	fovCircle.BorderSizePixel = 0 -- No border
	
	-- Set circular shape by using a mask (optional for true circular look)
	local circleMask = Instance.new("ImageLabel", fovCircle)
	circleMask.Size = UDim2.new(1, 0, 1, 0)
	circleMask.BackgroundColor3 = Color3.new(1, 1, 1)
	circleMask.Image = "rbxassetid://someCircleImage" -- Replace with a circular image asset
	circleMask.ImageTransparency = 0.2
	
	local function isVisible(target)
		-- Perform a raycast to check if the target is visible
		local origin = localPlayer.Character.Head.Position
		local direction = (target.Position - origin).unit * 1000
		local raycastParams = RaycastParams.new()
		raycastParams.FilterDescendantsInstances = {localPlayer.Character}
		raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
	
		local result = workspace:Raycast(origin, direction, raycastParams)
		if result and result.Instance:IsDescendantOf(target.Parent) then
			return true
		end
		return false
	end
	
	local function getClosestTarget()
		local closestTarget = nil
		local shortestDistance = math.huge
	
		for _, player in pairs(players:GetPlayers()) do
			if player ~= localPlayer and player.Character and player.Character:FindFirstChild("Head") then
				-- Check if the player is on the same team
				if player.Team ~= localPlayer.Team then
					local targetHead = player.Character.Head
					if isVisible(targetHead) then
						local distance = (targetHead.Position - localPlayer.Character.Head.Position).magnitude
						if distance < shortestDistance and distance <= 70 then -- Check if within FOV radius
							closestTarget = targetHead
							shortestDistance = distance
						end
					end
				end
			end
		end
	
		return closestTarget
	end
	
	local function aimAt(target)
		local camera = workspace.CurrentCamera
		camera.CFrame = CFrame.new(camera.CFrame.Position, target.Position)
	end
	
	local function onRenderStep()
		if aimAssistEnabled then
			local closestTarget = getClosestTarget()
			if closestTarget then
				aimAt(closestTarget)
			end
		end
	end
	
	aimButton.MouseButton1Click:Connect(function()
		aimAssistEnabled = not aimAssistEnabled
		aimButton.Text = aimAssistEnabled and "x" or " "
	end)
	
	runService.RenderStepped:Connect(onRenderStep)
end
coroutine.wrap(QCECC_fake_script)()
