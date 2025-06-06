local buildingUtils = {}
buildingUtils.__index = buildingUtils

function buildingUtils:ClearAllTemporaryItems(temporaryFolder)
	for _, item in pairs(temporaryFolder:GetChildren()) do
		item:Destroy()
	end
end

function buildingUtils:PlaceItem(itemName, newParent, tempFolder, tempItem)
	local clonedItem = tempItem:Clone()
	clonedItem.Transparency = 0
	clonedItem.Name = itemName
	clonedItem.Position = tempItem.Position
	clonedItem.Parent = newParent
	buildingUtils:ClearAllTemporaryItems(tempFolder)
end

function buildingUtils:Deselect(PlacedItemsFolder)
	for _, placedItem in pairs(PlacedItemsFolder:GetChildren()) do
		local selectionbox = placedItem:FindFirstChildOfClass("SelectionBox")
		if selectionbox then
			selectionbox.Visible = false
		end
	end
end
function buildingUtils:Select(item, PlacedItemsFolder)
	buildingUtils:Deselect(PlacedItemsFolder)
	local selectionBox = item:FindFirstChildOfClass("SelectionBox")
	selectionBox.Visible = false

	selectionBox.Transparency = 0
	selectionBox.Color3 = Color3.fromRGB(25, 153, 255)
	selectionBox.LineThickness = 0.006
	selectionBox.SurfaceTransparency = 0.6
	selectionBox.Visible = true
	for _, placedItem in pairs(PlacedItemsFolder:GetChildren()) do
		if placedItem:FindFirstChildOfClass("SelectionBox") then
			local itemSelectionBox = placedItem:FindFirstChildOfClass("SelectionBox")
			if itemSelectionBox.LineThickness > 0.006 and itemSelectionBox.LineThickness < 0.006001 then
				-- This is the way we identify if an item is being hover overd
				itemSelectionBox.Visible = false
				itemSelectionBox.LineThickness = 0
			end
		end
	end
	selectionBox.Visible = true
	selectionBox.Color3 = Color3.fromRGB(25, 153, 255)
	selectionBox.LineThickness = 0.006
end

function buildingUtils:Remove(item)
	item:Destroy()
end

function buildingUtils:Resize(item, bool)
	if bool == true then
		item.Size *= 2
		item.Hitbox.Size *= 2
	else
		item.Size /= 2
		item.Hitbox.Size /= 2
	end
end

function buildingUtils:Scale(item, num, bool)
	if bool == true then
		-- Player wants to make the object bigger
		item.Size *= num
		item.Hitbox.Size *= num
	else
		item.Size /= num
		item.Hitbox.Size /= num
	end
end

return buildingUtils
