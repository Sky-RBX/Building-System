local enterBuildMode = game.ReplicatedStorage:WaitForChild("EnterBuildMode") -- Change this if the RemoteEvent is somewhere else
local exitBuildMode = game.ReplicatedStorage:WaitForChild("ExitBuildMode") -- Change this if the RemoteEvent is somewhere else

enterBuildMode.OnServerEvent:Connect(function(player)
	enterBuildMode:FireClient(player)
end)

exitBuildMode.OnServerEvent:Connect(function(player)
	exitBuildMode:FireClient(player)
end)
