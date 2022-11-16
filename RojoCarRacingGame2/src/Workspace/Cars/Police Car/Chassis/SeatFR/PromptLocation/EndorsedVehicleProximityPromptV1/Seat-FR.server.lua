local prox = script.Parent.Parent.Parent.Parent.Parent.Chassis.SeatFR.PromptLocation.EndorsedVehicleProximityPromptV1
local seat = script.Parent.Parent.Parent.Parent.Parent.Chassis.SeatFR

seat:GetPropertyChangedSignal("Occupant"):Connect(function()
	if seat.Occupant then
		prox.Enabled = false
	else
		prox.Enabled = true
	end
end)

prox.Triggered:Connect(function(player)
	seat:Sit(player.Character.Humanoid)
end)