local RS = game:GetService("ReplicatedStorage")
local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local autoApply = false
local TARGET = "Hacker"

local function applyLoop()
    while autoApply do
        pcall(function()
            RS.ApplyMutation:FireServer(TARGET)
        end)
        task.wait(0.3)
    end
end

local gui = Instance.new("ScreenGui")
gui.Name = "HackerMutGUI"
gui.ResetOnSpawn = false
gui.Parent = playerGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 230, 0, 180)
frame.Position = UDim2.new(0, 10, 0.3, 0)
frame.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = gui
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 14)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 38)
title.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
title.Text = "Family Auctioner"
title.TextColor3 = Color3.fromRGB(0, 255, 100)
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.Parent = frame
Instance.new("UICorner", title).CornerRadius = UDim.new(0, 14)

local mutLabel = Instance.new("TextLabel")
mutLabel.Size = UDim2.new(0.9, 0, 0, 28)
mutLabel.Position = UDim2.new(0.05, 0, 0, 44)
mutLabel.BackgroundColor3 = Color3.fromRGB(0, 30, 0)
mutLabel.Text = "🎯 Target: HACKER"
mutLabel.TextColor3 = Color3.fromRGB(0, 255, 100)
mutLabel.TextScaled = true
mutLabel.Font = Enum.Font.GothamBold
mutLabel.Parent = frame
Instance.new("UICorner", mutLabel).CornerRadius = UDim.new(0, 6)

local mutations = {"Normal","Gold","Diamond","Rainbow","Candy","Lava","Blizzard","Lightning","Hacker"}
local colors = {
    Normal=Color3.fromRGB(150,150,150),Gold=Color3.fromRGB(255,180,0),
    Diamond=Color3.fromRGB(0,200,255),Rainbow=Color3.fromRGB(200,0,255),
    Candy=Color3.fromRGB(255,100,150),Lava=Color3.fromRGB(255,80,0),
    Blizzard=Color3.fromRGB(100,180,255),Lightning=Color3.fromRGB(255,255,0),
    Hacker=Color3.fromRGB(0,255,100),
}

local scroll = Instance.new("ScrollingFrame")
scroll.Size = UDim2.new(0.9, 0, 0, 60)
scroll.Position = UDim2.new(0.05, 0, 0, 76)
scroll.BackgroundColor3 = Color3.fromRGB(22, 22, 38)
scroll.ScrollBarThickness = 3
scroll.CanvasSize = UDim2.new(0, #mutations * 80, 0, 0)
scroll.ScrollingDirection = Enum.ScrollingDirection.X
scroll.Parent = frame
Instance.new("UICorner", scroll).CornerRadius = UDim.new(0, 6)

local ll = Instance.new("UIListLayout", scroll)
ll.FillDirection = Enum.FillDirection.Horizontal
ll.SortOrder = Enum.SortOrder.LayoutOrder

for i, mut in ipairs(mutations) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 75, 1, -4)
    btn.BackgroundColor3 = colors[mut]
    btn.Text = mut
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextScaled = true
    btn.Font = Enum.Font.GothamBold
    btn.LayoutOrder = i
    btn.Parent = scroll
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    btn.MouseButton1Click:Connect(function()
        TARGET = mut
        mutLabel.Text = "🎯 Target: " .. mut:upper()
        mutLabel.BackgroundColor3 = Color3.fromRGB(colors[mut].R*0.3,colors[mut].G*0.3,colors[mut].B*0.3)
        mutLabel.TextColor3 = colors[mut]
    end)
end

local status = Instance.new("TextLabel")
status.Size = UDim2.new(0.9, 0, 0, 20)
status.Position = UDim2.new(0.05, 0, 0, 142)
status.BackgroundTransparency = 1
status.Text = "💤 Off"
status.TextColor3 = Color3.fromRGB(150, 150, 150)
status.TextScaled = true
status.Font = Enum.Font.Gotham
status.Parent = frame

local toggleBtn = Instance.new("TextButton")
toggleBtn.Size = UDim2.new(0.9, 0, 0, 30)
toggleBtn.Position = UDim2.new(0.05, 0, 0, 144)
toggleBtn.BackgroundColor3 = Color3.fromRGB(50, 180, 80)
toggleBtn.Text = "▶ START"
toggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleBtn.TextScaled = true
toggleBtn.Font = Enum.Font.GothamBold
toggleBtn.Parent = frame
Instance.new("UICorner", toggleBtn).CornerRadius = UDim.new(0, 8)

toggleBtn.MouseButton1Click:Connect(function()
    autoApply = not autoApply
    if autoApply then
        toggleBtn.Text = "⏹ STOP"
        toggleBtn.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
        status.Text = "✅ Force " .. TARGET .. "..."
        task.spawn(applyLoop)
    else
        toggleBtn.Text = "▶ START"
        toggleBtn.BackgroundColor3 = Color3.fromRGB(50, 180, 80)
        status.Text = "💤 Off"
    end
end)
