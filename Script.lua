local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer

for _, guiName in ipairs({"DeltaBringMobGUI", "DeltaSafeBringGUI", "DeltaExtendedHitboxBringGUI", "DeltaInvisibleHitboxGUI", "DeltaGiveToolsGUI", "unlock fragment badge", "DeltaAutoBuyToolsGUI"}) do
    local oldGui = CoreGui:FindFirstChild(guiName)
    if oldGui then
        oldGui:Destroy()
    end
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "UNLOCK FARGMENT BADGE"
ScreenGui.ResetOnSpawn = false

if gethui then
    ScreenGui.Parent = gethui()
elseif syn and syn.protect_gui then
    syn.protect_gui(ScreenGui)
    ScreenGui.Parent = CoreGui
else
    ScreenGui.Parent = CoreGui
end

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 180, 0, 110)
MainFrame.Position = UDim2.new(0.5, -90, 0.4, -55)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 8)
MainCorner.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 30)
Title.BackgroundTransparency = 1
Title.Text = "UNLOCK FARGMENT BADGE"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 13
Title.Font = Enum.Font.SourceSansBold
Title.Parent = MainFrame

local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Size = UDim2.new(0.85, 0, 0, 35)
ToggleBtn.Position = UDim2.new(0.075, 0, 0, 35)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(40, 120, 220)
ToggleBtn.Text = "UNLOCK FARGMENT BADGE"
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.TextSize = 14
ToggleBtn.Font = Enum.Font.SourceSansBold
ToggleBtn.Parent = MainFrame

local BtnCorner = Instance.new("UICorner")
BtnCorner.CornerRadius = UDim.new(0, 6)
BtnCorner.Parent = ToggleBtn

local MinBtn = Instance.new("TextButton")
MinBtn.Size = UDim2.new(0, 24, 0, 24)
MinBtn.Position = UDim2.new(1, -28, 0, 3)
MinBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
MinBtn.Text = "-"
MinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinBtn.TextSize = 18
MinBtn.Font = Enum.Font.SourceSansBold
MinBtn.Parent = MainFrame

local MinCorner = Instance.new("UICorner")
MinCorner.CornerRadius = UDim.new(0, 4)
MinCorner.Parent = MinBtn

local OpenBtn = Instance.new("TextButton")
OpenBtn.Size = UDim2.new(0, 80, 0, 30)
OpenBtn.Position = UDim2.new(0, 10, 0, 10)
OpenBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
OpenBtn.Text = "Open"
OpenBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
OpenBtn.TextSize = 14
OpenBtn.Font = Enum.Font.SourceSansBold
OpenBtn.Visible = false
OpenBtn.Active = true
OpenBtn.Draggable = true
OpenBtn.Parent = ScreenGui

local OpenCorner = Instance.new("UICorner")
OpenCorner.CornerRadius = UDim.new(0, 6)
OpenCorner.Parent = OpenBtn

local function buyAndFireAll()
    for _, obj in ipairs(game:GetDescendants()) do
        if obj:IsA("RemoteEvent") or obj:IsA("RemoteFunction") then
            local name = obj.Name:lower()
            if name:find("buy") or name:find("item") or name:find("shop") or name:find("purchase") or name:find("gear") or name:find("weapon") then
                pcall(function()
                    if obj:IsA("RemoteEvent") then
                        obj:FireServer()
                        obj:FireServer(true)
                        obj:FireServer("All")
                    elseif obj:IsA("RemoteFunction") then
                        obj:InvokeServer()
                        obj:InvokeServer(true)
                        obj:InvokeServer("All")
                    end
                end)
            end
        end
    end

    for _, v in ipairs(workspace:GetDescendants()) do
        if v:IsA("ClickDetector") or v:IsA("ProximityPrompt") then
            pcall(function()
                if v:IsA("ClickDetector") then
                    fireclickdetector(v)
                elseif v:IsA("ProximityPrompt") then
                    fireproximityprompt(v)
                end
            end)
        end
    end
end

ToggleBtn.MouseButton1Click:Connect(function()
    buyAndFireAll()
end)

MinBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    OpenBtn.Visible = true
end)

OpenBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = true
    OpenBtn.Visible = false
end)
