seat = workspace:WaitForChild("Cars")["Car"].Chassis.VehicleSeat
Players = game:GetService("Players")
players = Players:GetChildren()

ShopGui = script.Parent
startButton = ShopGui:WaitForChild("Frame").Startbutton

function StartButtonClicked()
	ShopGui.Enabled = false
	for _, player in ipairs(players) do
		seat:Sit(player.Character.Humanoid)
	end
end

function CarSelectButtonClicked(car)
	
end

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local createPartRequest = Instance.new("RemoteFunction")
createPartRequest.Parent = ReplicatedStorage
createPartRequest.Name = "CreatePartRequest"

ShopGui.Enabled = true


startButton.Activated:Connect(StartButtonClicked)