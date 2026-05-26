--// SECRET FINDER MOBILE FINAL
--// UNIVERSAL SECRET DETECTOR
--// AUTO SERVER HOP
--// PERMANENT SERVER BLACKLIST
--// AUTO EXECUTE AFTER TELEPORT
--// MOBILE COMPACT UI

if getgenv().SecretFinderLoaded then
	return
end
getgenv().SecretFinderLoaded = true

--// AUTO EXECUTE AFTER TELEPORT

if queue_on_teleport then

	queue_on_teleport([[
		loadstring(game:HttpGet("https://raw.githubusercontent.com/jesusvc194-jpg/S2/refs/heads/main/New"))()
	]])

elseif syn and syn.queue_on_teleport then

	syn.queue_on_teleport([[
		loadstring(game:HttpGet("https://raw.githubusercontent.com/jesusvc194-jpg/S2/refs/heads/main/New"))()
	]])
end

repeat task.wait() until game:IsLoaded()

local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")

local LocalPlayer = Players.LocalPlayer
local PlaceID = game.PlaceId
local JobID = game.JobId

--// SERVER BLACKLIST

local serverFile = "SecretFinderServers.json"

local visitedServers = {}

pcall(function()

	if isfile(serverFile) then

		visitedServers =
			HttpService:JSONDecode(
				readfile(serverFile)
			)
	end
end)

visitedServers[JobID] = true

pcall(function()

	writefile(
		serverFile,
		HttpService:JSONEncode(visitedServers)
	)
end)

--// GUI

local gui = Instance.new("ScreenGui")
gui.Name = "SecretFinder"
gui.ResetOnSpawn = false
gui.Parent = game.CoreGui

local main = Instance.new("Frame")
main.Parent = gui
main.Size = UDim2.new(0,220,0,155)
main.Position = UDim2.new(0.72,0,0.02,0)
main.BackgroundColor3 = Color3.fromRGB(0,0,0)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true

Instance.new("UICorner",main).CornerRadius = UDim.new(0,14)

--// TOP

local top = Instance.new("Frame")
top.Parent = main
top.Size = UDim2.new(1,0,0,30)
top.BackgroundTransparency = 1

-- TITLE

local title = Instance.new("TextLabel")
title.Parent = top
title.Size = UDim2.new(0,70,1,0)
title.BackgroundTransparency = 1
title.Text = "🔥 FINDER"
title.TextColor3 = Color3.fromRGB(255,170,0)
title.Font = Enum.Font.GothamBold
title.TextSize = 15

-- NEXT

local nextBtn = Instance.new("TextButton")
nextBtn.Parent = top
nextBtn.Size = UDim2.new(0,42,0,22)
nextBtn.Position = UDim2.new(0,72,0.15,0)
nextBtn.Text = "NEXT"
nextBtn.BackgroundColor3 = Color3.fromRGB(0,170,255)
nextBtn.TextColor3 = Color3.new(1,1,1)
nextBtn.Font = Enum.Font.GothamBold
nextBtn.TextScaled = true

Instance.new("UICorner",nextBtn).CornerRadius = UDim.new(0,6)

-- AUTO

local autoJoin = true

local autoBtn = Instance.new("TextButton")
autoBtn.Parent = top
autoBtn.Size = UDim2.new(0,58,0,22)
autoBtn.Position = UDim2.new(0,118,0.15,0)
autoBtn.Text = "AUTO"
autoBtn.BackgroundColor3 = Color3.fromRGB(0,255,120)
autoBtn.TextColor3 = Color3.new(0,0,0)
autoBtn.Font = Enum.Font.GothamBold
autoBtn.TextScaled = true

Instance.new("UICorner",autoBtn).CornerRadius = UDim.new(0,6)

-- STOP

local stopBtn = Instance.new("TextButton")
stopBtn.Parent = top
stopBtn.Size = UDim2.new(0,42,0,22)
stopBtn.Position = UDim2.new(0,180,0.15,0)
stopBtn.Text = "STOP"
stopBtn.BackgroundColor3 = Color3.fromRGB(255,170,0)
stopBtn.TextColor3 = Color3.new(0,0,0)
stopBtn.Font = Enum.Font.GothamBold
stopBtn.TextScaled = true

Instance.new("UICorner",stopBtn).CornerRadius = UDim.new(0,6)

-- MIN

local minBtn = Instance.new("TextButton")
minBtn.Parent = top
minBtn.Size = UDim2.new(0,18,0,22)
minBtn.Position = UDim2.new(1,-40,0.15,0)
minBtn.Text = "-"
minBtn.BackgroundColor3 = Color3.fromRGB(180,180,180)
minBtn.TextColor3 = Color3.new(0,0,0)
minBtn.Font = Enum.Font.GothamBold
minBtn.TextScaled = true

Instance.new("UICorner",minBtn).CornerRadius = UDim.new(0,6)

-- EXIT

local exitBtn = Instance.new("TextButton")
exitBtn.Parent = top
exitBtn.Size = UDim2.new(0,18,0,22)
exitBtn.Position = UDim2.new(1,-20,0.15,0)
exitBtn.Text = "X"
exitBtn.BackgroundColor3 = Color3.fromRGB(255,80,80)
exitBtn.TextColor3 = Color3.new(1,1,1)
exitBtn.Font = Enum.Font.GothamBold
exitBtn.TextScaled = true

Instance.new("UICorner",exitBtn).CornerRadius = UDim.new(0,6)

-- CONTENT

local content = Instance.new("Frame")
content.Parent = main
content.Size = UDim2.new(1,-8,1,-38)
content.Position = UDim2.new(0,4,0,32)
content.BackgroundTransparency = 1

local status = Instance.new("TextLabel")
status.Parent = content
status.Size = UDim2.new(1,0,0,25)
status.BackgroundTransparency = 1
status.Text = "🔍 Searching..."
status.TextColor3 = Color3.fromRGB(255,255,255)
status.Font = Enum.Font.GothamBold
status.TextScaled = true

local log = Instance.new("TextLabel")
log.Parent = content
log.Size = UDim2.new(1,-5,1,-30)
log.Position = UDim2.new(0,2,0,28)
log.BackgroundTransparency = 1
log.Text = "Waiting..."
log.TextColor3 = Color3.fromRGB(255,170,0)
log.Font = Enum.Font.Code
log.TextSize = 14
log.TextWrapped = true
log.TextXAlignment = Enum.TextXAlignment.Left
log.TextYAlignment = Enum.TextYAlignment.Top

-- MINIMIZE

local minimized = false
local originalSize = main.Size

minBtn.MouseButton1Click:Connect(function()

	minimized = not minimized

	if minimized then

		content.Visible = false
		main.Size = UDim2.new(0,220,0,30)
		minBtn.Text = "+"

	else

		content.Visible = true
		main.Size = originalSize
		minBtn.Text = "-"

	end
end)

-- EXIT

exitBtn.MouseButton1Click:Connect(function()

	gui:Destroy()
	getgenv().SecretFinderLoaded = false

end)

-- STOP

local stopped = false

stopBtn.MouseButton1Click:Connect(function()

	stopped = not stopped

	if stopped then

		stopBtn.Text = "START"
		status.Text = "⏹️ Stopped"

	else

		stopBtn.Text = "STOP"
		status.Text = "🔍 Searching..."

	end
end)

-- AUTO TOGGLE

autoBtn.MouseButton1Click:Connect(function()

	autoJoin = not autoJoin

	if autoJoin then

		autoBtn.Text = "AUTO"
		autoBtn.BackgroundColor3 = Color3.fromRGB(0,255,120)

	else

		autoBtn.Text = "MANUAL"
		autoBtn.BackgroundColor3 = Color3.fromRGB(255,120,120)

	end
end)

-- SERVER HOP

local hopping = false

local function ServerHop()

	if hopping then
		return
	end

	hopping = true

	local success,err = pcall(function()

		local req = game:HttpGet(
			"https://games.roblox.com/v1/games/" ..
			PlaceID ..
			"/servers/Public?sortOrder=Asc&limit=100"
		)

		local data = HttpService:JSONDecode(req)

		if not data or not data.data then
			error("Failed to get servers")
		end

		for _,server in ipairs(data.data) do

			if server.id ~= JobID
			and server.playing < server.maxPlayers
			and not visitedServers[server.id] then

				visitedServers[server.id] = true

				pcall(function()

					writefile(
						serverFile,
						HttpService:JSONEncode(visitedServers)
					)
				end)

				log.Text =
					"🚀 Joining...\n\nPlayers: " ..
					server.playing ..
					"/" ..
					server.maxPlayers

				status.Text = "🔄 Server Hop"

				task.spawn(function()

					task.wait(1)

					TeleportService:TeleportToPlaceInstance(
						PlaceID,
						server.id,
						LocalPlayer
					)
				end)

				return
			end
		end

		log.Text = "⚠️ Resetting Servers..."

		table.clear(visitedServers)

		visitedServers[JobID] = true

		writefile(
			serverFile,
			HttpService:JSONEncode(visitedServers)
		)

		task.wait(2)
	end)

	if not success then

		log.Text = tostring(err)
		status.Text = "❌ Hop Failed"

	end

	hopping = false
end

-- NEXT BUTTON

nextBtn.MouseButton1Click:Connect(function()

	ServerHop()

end)

-- SECRET DETECTOR

task.spawn(function()

	while true do

		task.wait(6)

		if stopped then
			continue
		end

		local found = {}

		local function AddFound(name)

			if not table.find(found, name) then
				table.insert(found, name)
			end
		end

		for _,v in pairs(workspace:GetDescendants()) do

			pcall(function()

				if v:IsA("TextLabel") then

					local text = string.lower(v.Text)

					if string.find(text,"secret") then

						local model =
							v:FindFirstAncestorOfClass("Model")

						if model then
							AddFound(model.Name)
						end
					end
				end

				if v:IsA("StringValue") then

					local value = string.lower(v.Value)

					if string.find(value,"secret") then

						local model =
							v:FindFirstAncestorOfClass("Model")

						if model then
							AddFound(model.Name)
						end
					end
				end

				if v:GetAttribute("Rarity") then

					local rarity =
						string.lower(
							tostring(v:GetAttribute("Rarity"))
						)

					if string.find(rarity,"secret") then

						local model =
							v:FindFirstAncestorOfClass("Model") or v

						AddFound(model.Name)
					end
				end
			end)
		end

		if #found > 0 then

			log.Text =
				"🔥 SECRET FOUND:\n\n" ..
				table.concat(found,"\n")

			status.Text =
				"✅ FOUND " .. #found

			if autoJoin then
				stopped = true
			else
				ServerHop()
			end

		else

			log.Text =
				"❌ No Secret Found"

			status.Text = "🔍 Searching"

			ServerHop()
		end
	end
end)

print("SECRET FINDER MOBILE FINAL LOADED")
