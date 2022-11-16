local ReplicatedStorage = game:GetService("ReplicatedStorage")
--local ReplicatedFirst = game:GetService("ReplicatedFirst")
--local Players = game:GetService("Players")

--while #Players:GetChildren() == 0 do
--	wait()
--end

--Player = Players:GetChildren()

local ScriptFolder = ReplicatedStorage:FindFirstChild("Scripts")
--local GuiScript = ReplicatedFirst:FindFirstChild("gameStart")

for _,CarName in pairs(workspace.Cars:GetChildren()) do
	local ScriptFolderClone = ScriptFolder:Clone()
	ScriptFolderClone.Parent = workspace.Cars:WaitForChild(CarName.Name)
	ScriptFolderClone.Driver.CarValue.Value = CarName
end

--for _,player in pairs(Player) do
--	local GuiScriptClone = GuiScript:Clone()
--	GuiScriptClone.Parent = player.PlayerGui:WaitForChild("ShopGUI")
--end
--코멘트 토글 전부 Gui관련