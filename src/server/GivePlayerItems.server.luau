local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Items = ReplicatedStorage:WaitForChild("Items")
local itemLabelCloned = ReplicatedStorage:WaitForChild("ItemLabelCloned") -- Important to change if the RemotEvent is located somewhere else

game.Players.PlayerAdded:Connect(function(plr)
	local plrItems = Instance.new("Folder")
	plrItems.Name = "Items"
	plrItems.Parent = plr
	for _, item in pairs(Items:GetChildren()) do
		local newVal = Instance.new("StringValue")
		newVal.Name = item.Name
		newVal.Parent = plrItems
	end

	--[[
	Making sure that the player has the Item as an option on the client. With other words cloning the template
	]]

	local plrGui = plr.PlayerGui
	local hotbarGui = plrGui:WaitForChild("Hotbar")
	local itemTemplate = plrGui:WaitForChild("ItemTemplate")
	local GuiItems = hotbarGui:WaitForChild("GuiItems")
	for _, item in pairs(plrItems:GetChildren()) do
		if Items:FindFirstChild(item.Name) then
			-- This should run. If it doesn't then it's either caused by a bug or the player is exploiting
			print("Making a template for: " .. item.Name)
			local newItemLabel = itemTemplate:Clone()
			newItemLabel.Name = item.Name
			newItemLabel.Parent = GuiItems

			local button = newItemLabel:WaitForChild("Button")
			button.Text = item.Name
			newItemLabel.Visible = false
			itemLabelCloned:FireClient(plr, item.Name)
		else
			warn("Item in the player's ItemFolder doesn't match with the items in ReplicatedStorage")
		end
	end
end)
