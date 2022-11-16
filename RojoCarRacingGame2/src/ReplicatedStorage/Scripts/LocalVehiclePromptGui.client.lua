local ProximityPromptService = game:GetService("ProximityPromptService")
local screenGui = script.Parent
local CarValue = script:WaitForChild("CarValue")
local Car = CarValue.Value
local Keymap = require(Car.Scripts.Keymap)
local InputImageLibrary = require(Car.Scripts.InputImageLibrary)

local MIN_FLIP_ANGLE = 70 --degrees from vertical

--Tell if a seat is flipped
local function isFlipped(Seat)
	local UpVector = Seat.CFrame.upVector
	local Angle = math.deg(math.acos(UpVector:Dot(Vector3.new(0, 1, 0))))
	return Angle >= MIN_FLIP_ANGLE
end

local function createPrompt(prompt, inputType)
	local seat = prompt.Parent.Parent
	local buttonGui = script:WaitForChild("ButtonGuiPrototype")
	local promptUI = buttonGui:Clone()
	promptUI.Name = "ButtonGui"
	promptUI.Enabled = true
	promptUI.Adornee = prompt.Parent
	
	
	local FlipImageButton = promptUI:WaitForChild("FlipImage")
	local BackgroundConsole = promptUI:WaitForChild("BackgroundConsole")

	--Switch button type
	local DriverButtonId
	local DriverButtonPressedId
	local PassengerButtonId
	local PassengerButtonPressedId
	if inputType == Enum.ProximityPromptInputType.Keyboard then
		DriverButtonId = "rbxassetid://2848250902"
		DriverButtonPressedId = "rbxassetid://2848250902"
		PassengerButtonId = "rbxassetid://2848251564"
		PassengerButtonPressedId = "rbxassetid://2848251564"
		FlipImageButton.Image = "rbxassetid://2848307983"
		FlipImageButton:WaitForChild("Pressed").Image = "rbxassetid://2848307983"
		FlipImageButton.Size = UDim2.new(0, 44, 0, 44)

		BackgroundConsole.Visible = false


		--Display the correct key

	elseif inputType == Enum.ProximityPromptInputType.Gamepad then
		DriverButtonId = "rbxassetid://2848635029"
		DriverButtonPressedId = "rbxassetid://2848635029"
		PassengerButtonId = "rbxassetid://2848636545"
		PassengerButtonPressedId = "rbxassetid://2848636545"
		FlipImageButton.Image = "rbxassetid://2848307983"
		FlipImageButton:WaitForChild("Pressed").Image = "rbxassetid://2848307983"
		FlipImageButton.Size = UDim2.new(0, 44, 0, 44)

		BackgroundConsole.Visible = true
		BackgroundConsole.Size =  UDim2.new(0, 136, 0, 66)
		BackgroundConsole.Position = UDim2.new(0.5, 40, 0.5, 0)


		--Set the correct image for the gamepad button prompt
		local template = InputImageLibrary:GetImageLabel(Keymap.EnterVehicleGamepad, "Light")
	elseif inputType == Enum.ProximityPromptInputType.Touch then
		BackgroundConsole.Visible = false

		DriverButtonId = "rbxassetid://2847898200"
		DriverButtonPressedId = "rbxassetid://2847898354"
		PassengerButtonId = "rbxassetid://2848217831"
		PassengerButtonPressedId = "rbxassetid://2848218107"
		FlipImageButton.Image = "rbxassetid://2848187559"
		FlipImageButton:WaitForChild("Pressed").Image = "rbxassetid://2848187982"
		FlipImageButton.Size = UDim2.new(0, 44, 0, 44)
		
		FlipImageButton.InputBegan:Connect(function(input)
			prompt:InputHoldBegin()
		end)
		FlipImageButton.InputEnded:Connect(function(input)
			prompt:InputHoldEnd()
		end)

		promptUI.Active = true
	end
	
	if isFlipped(seat) then
		FlipImageButton.Visible = true
	else
		FlipImageButton.Visible = false
	end

	return promptUI
end

ProximityPromptService.PromptShown:Connect(function(prompt, inputType)
	if prompt.Name == "EndorsedVehicleProximityPromptV1" then
		local promptUI = createPrompt(prompt, inputType)
		promptUI.Parent = screenGui
		prompt.PromptHidden:Wait()
		promptUI.Parent = nil
	end
end)
