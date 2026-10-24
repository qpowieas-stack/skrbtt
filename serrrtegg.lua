-- Roblox Delta Script: Steal The Egg (Custom Speed & Anti-Kick Update)
-- Executor: Delta Executor

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

-- 1. واجهة المستخدم الكلاسيكية (UI)
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local ToggleBtn = Instance.new("TextButton")
local UICorner = Instance.new("UICorner")

if gethui then
    ScreenGui.Parent = gethui()
elseif syn and syn.protect_gui then
    syn.protect_gui(ScreenGui)
    ScreenGui.Parent = game:GetService("CoreGui")
else
    ScreenGui.Parent = game:GetService("CoreGui")
end

ScreenGui.Name = "StealEggCustomSpeedUI"

-- القائمة الرئيسية
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BorderColor3 = Color3.fromRGB(255, 215, 0)
MainFrame.BorderSizePixel = 2
MainFrame.Position = UDim2.new(0.35, 0, 0.08, 0)
MainFrame.Size = UDim2.new(0, 260, 0, 480)
MainFrame.Active = true
MainFrame.Draggable = true

-- العنوان
Title.Name = "Title"
Title.Parent = MainFrame
Title.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
Title.BorderSizePixel = 0
Title.Size = UDim2.new(1, 0, 0, 38)
Title.Font = Enum.Font.SourceSansBold
Title.Text = "🥚 Steal The Egg (Classic Pro)"
Title.TextColor3 = Color3.fromRGB(255, 215, 0)
Title.TextSize = 18

-- زر الإخفاء (-) في الزاوية
ToggleBtn.Name = "ToggleBtn"
ToggleBtn.Parent = ScreenGui
ToggleBtn.BackgroundColor3 = Color3.fromRGB(200, 40, 40)
ToggleBtn.Position = UDim2.new(0.85, 0, 0.08, 0)
ToggleBtn.Size = UDim2.new(0, 38, 0, 38)
ToggleBtn.Font = Enum.Font.SourceSansBold
ToggleBtn.Text = "-"
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.TextSize = 24
ToggleBtn.Active = true
ToggleBtn.Draggable = true

UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = ToggleBtn

local menuVisible = true
ToggleBtn.MouseButton1Click:Connect(function()
    menuVisible = not menuVisible
    MainFrame.Visible = menuVisible
    ToggleBtn.Text = menuVisible and "-" or "+"
    ToggleBtn.BackgroundColor3 = menuVisible and Color3.fromRGB(200, 40, 40) or Color3.fromRGB(40, 200, 40)
end)

-- دالة إنشاء الأزرار
local function createButton(name, text, pos, color)
    local btn = Instance.new("TextButton")
    btn.Name = name
    btn.Parent = MainFrame
    btn.BackgroundColor3 = color
    btn.Position = pos
    btn.Size = UDim2.new(0.88, 0, 0, 30)
    btn.Font = Enum.Font.SourceSansBold
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 12
    return btn
end

-- إعدادات وتحديد السرعة المخصصة
local SpeedBox = Instance.new("TextBox")
SpeedBox.Name = "SpeedBox"
SpeedBox.Parent = MainFrame
SpeedBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
SpeedBox.BorderColor3 = Color3.fromRGB(255, 215, 0)
SpeedBox.Position = UDim2.new(0.06, 0, 0.10, 0)
SpeedBox.Size = UDim2.new(0.88, 0, 0, 30)
SpeedBox.Font = Enum.Font.SourceSansBold
SpeedBox.PlaceholderText = "اكتب رقم السرعة هنا (مثال: 50)"
SpeedBox.Text = ""
SpeedBox.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedBox.TextSize = 12

-- الأزرار
local SetSpeedBtn = createButton("SetSpeedBtn", "تفعيل السرعة المخصصة ⚡: OFF", UDim2.new(0.06, 0, 0.17, 0), Color3.fromRGB(60, 60, 60))
local AutoFarmBtn = createButton("AutoFarmBtn", "تجميع بيض تلقائي 🔄: OFF", UDim2.new(0.06, 0, 0.24, 0), Color3.fromRGB(60, 60, 60))
local FarmBtn     = createButton("FarmBtn", "سرقة أقرب بيضة ⚡", UDim2.new(0.06, 0, 0.31, 0), Color3.fromRGB(40, 120, 200))
local InfJumpBtn  = createButton("InfJumpBtn", "قفز لانهائي في الهواء ☁️: OFF", UDim2.new(0.06, 0, 0.38, 0), Color3.fromRGB(60, 60, 60))
local FlyBtn      = createButton("FlyBtn", "طيران فوق الخريطة 🚀: OFF", UDim2.new(0.06, 0, 0.45, 0), Color3.fromRGB(60, 60, 60))
local BrightBtn   = createButton("BrightBtn", "إزالة الضباب وتوضيح الرؤية 💡: OFF", UDim2.new(0.06, 0, 0.52, 0), Color3.fromRGB(60, 60, 60))
local SpawnTpBtn  = createButton("SpawnTpBtn", "انتقال فوراً للسبون 🏠", UDim2.new(0.06, 0, 0.59, 0), Color3.fromRGB(180, 100, 30))
local StealthBtn  = createButton("StealthBtn", "وضع التخفي والحماية: OFF", UDim2.new(0.06, 0, 0.66, 0), Color3.fromRGB(60, 60, 60))
local JumpBtn     = createButton("JumpBtn", "قفز مرتفع: OFF", UDim2.new(0.06, 0, 0.73, 0), Color3.fromRGB(60, 60, 60))
local EspBtn      = createButton("EspBtn", "كشف البيض والوحوش (ESP): OFF", UDim2.new(0.06, 0, 0.80, 0), Color3.fromRGB(60, 60, 60))

-----------------------------------------------------
-- البرمجة والأنظمة التشغيلية
-----------------------------------------------------

local customSpeed = 16
local customSpeedToggle = false
local autoFarm = false
local flying = false
local stealth = false
local jumpToggle = false
local espToggle = false
local infJumpToggle = false
local brightToggle = false
local bodyVel

-- 1. نظام السرعة المخصصة بدون طرد (Custom WalkSpeed + Anti-Kick Bypass)
SetSpeedBtn.MouseButton1Click:Connect(function()
    customSpeedToggle = not customSpeedToggle
    local inputVal = tonumber(SpeedBox.Text)
    if inputVal then
        customSpeed = inputVal
    else
        customSpeed = 50 -- السرعة الافتراضية إذا لم يتم إدخال رقم
    end

    SetSpeedBtn.Text = customSpeedToggle and ("تفعيل السرعة المخصصة (" .. tostring(customSpeed) .. ") ⚡: ON") or "تفعيل السرعة المخصصة ⚡: OFF"
    SetSpeedBtn.BackgroundColor3 = customSpeedToggle and Color3.fromRGB(40, 180, 40) or Color3.fromRGB(60, 60, 60)
end)

-- حلقة تكرار لمنع حماية اللعبة من تصفير السرعة أو الطرد
RunService.Stepped:Connect(function()
    local char = LocalPlayer.Character
    if char and char:FindFirstChildOfClass("Humanoid") then
        local hum = char:FindFirstChildOfClass("Humanoid")
        if customSpeedToggle then
            hum.WalkSpeed = customSpeed
        end
    end
end)

-- 2. القفز اللانهائي في الهواء (Infinite Jump)
InfJumpBtn.MouseButton1Click:Connect(function()
    infJumpToggle = not infJumpToggle
    InfJumpBtn.Text = infJumpToggle and "قفز لانهائي في الهواء ☁️: ON" or "قفز لانهائي في الهواء ☁️: OFF"
    InfJumpBtn.BackgroundColor3 = infJumpToggle and Color3.fromRGB(40, 180, 40) or Color3.fromRGB(60, 60, 60)
end)

UserInputService.JumpRequest:Connect(function()
    if infJumpToggle then
        local char = LocalPlayer.Character
        if char and char:FindFirstChildOfClass("Humanoid") then
            char:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end)

-- 3. إزالة الضباب ووضوح الرؤية (FullBright)
BrightBtn.MouseButton1Click:Connect(function()
    brightToggle = not brightToggle
    BrightBtn.Text = brightToggle and "إزالة الضباب وتوضيح الرؤية 💡: ON" or "إزالة الضباب وتوضيح الرؤية 💡: OFF"
    BrightBtn.BackgroundColor3 = brightToggle and Color3.fromRGB(40, 180, 40) or Color3.fromRGB(60, 60, 60)
    
    local lighting = game:GetService("Lighting")
    if brightToggle then
        lighting.GlobalShadows = false
        lighting.Brightness = 3
        lighting.FogEnd = 9e9
    else
        lighting.GlobalShadows = true
        lighting.Brightness = 1
        lighting.FogEnd = 1000
    end
end)

-- 4. تجميع البيض التلقائي (Auto Farm Loop)
AutoFarmBtn.MouseButton1Click:Connect(function()
    autoFarm = not autoFarm
    AutoFarmBtn.Text = autoFarm and "تجميع بيض تلقائي 🔄: ON" or "تجميع بيض تلقائي 🔄: OFF"
    AutoFarmBtn.BackgroundColor3 = autoFarm and Color3.fromRGB(40, 180, 40) or Color3.fromRGB(60, 60, 60)
end)

task.spawn(function()
    while task.wait(1.5) do
        if autoFarm then
            local char = LocalPlayer.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            if hrp then
                local savedPos = hrp.CFrame
                for _, v in pairs(Workspace:GetDescendants()) do
                    if v:IsA("Model") or v:IsA("BasePart") then
                        local name = string.lower(v.Name)
                        if string.find(name, "egg") then
                            local target = v:IsA("Model") and (v.PrimaryPart or v:FindFirstChildWhichIsA("BasePart")) or v
                            if target then
                                hrp.CFrame = target.CFrame * CFrame.new(0, 3, 0)
                                task.wait(0.3)
                                hrp.CFrame = savedPos
                                break
                            end
                        end
                    end
                end
            end
        end
    end
end)

-- 5. سرقة أقرب بيضة مرة واحدة
FarmBtn.MouseButton1Click:Connect(function()
    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if hrp then
        local savedPos = hrp.CFrame
        for _, v in pairs(Workspace:GetDescendants()) do
            if v:IsA("Model") or v:IsA("BasePart") then
                local name = string.lower(v.Name)
                if string.find(name, "egg") then
                    local target = v:IsA("Model") and (v.PrimaryPart or v:FindFirstChildWhichIsA("BasePart")) or v
                    if target then
                        hrp.CFrame = target.CFrame * CFrame.new(0, 3, 0)
                        task.wait(0.25)
                        hrp.CFrame = savedPos
                        break
                    end
                end
            end
        end
    end
end)

-- 6. الطيران فوق الخريطة
FlyBtn.MouseButton1Click:Connect(function()
    flying = not flying
    FlyBtn.Text = flying and "طيران فوق الخريطة 🚀: ON" or "طيران فوق الخريطة 🚀: OFF"
    FlyBtn.BackgroundColor3 = flying and Color3.fromRGB(40, 180, 40) or Color3.fromRGB(60, 60, 60)
    
    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if flying and hrp then
        bodyVel = Instance.new("BodyVelocity")
        bodyVel.MaxForce = Vector3.new(0, 1e9, 0)
        bodyVel.Velocity = Vector3.new(0, 0, 0)
        bodyVel.Parent = hrp
        hrp.CFrame = hrp.CFrame * CFrame.new(0, 12, 0)
    else
        if bodyVel then bodyVel:Destroy() end
    end
end)

-- 7. الانتقال للسبون (Spawn)
SpawnTpBtn.MouseButton1Click:Connect(function()
    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if hrp then
        local spawnLocation = Workspace:FindFirstChild("SpawnLocation") or Workspace:FindFirstChildWhichIsA("SpawnLocation", true)
        if spawnLocation then
            hrp.CFrame = spawnLocation.CFrame * CFrame.new(0, 4, 0)
        else
            hrp.CFrame = CFrame.new(0, 50, 0)
        end
    end
end)

-- 8. وضع التخفي والحماية
StealthBtn.MouseButton1Click:Connect(function()
    stealth = not stealth
    StealthBtn.Text = stealth and "وضع التخفي والحماية: ON" or "وضع التخفي والحماية: OFF"
    StealthBtn.BackgroundColor3 = stealth and Color3.fromRGB(40, 180, 40) or Color3.fromRGB(60, 60, 60)
end)

RunService.Stepped:Connect(function()
    if stealth then
        local char = LocalPlayer.Character
        if char then
            for _, p in pairs(char:GetDescendants()) do
                if p:IsA("BasePart") then
                    p.CanTouch = false
                end
            end
        end
    end
end)

-- 9. القفز المرتفع
JumpBtn.MouseButton1Click:Connect(function()
    jumpToggle = not jumpToggle
    JumpBtn.Text = jumpToggle and "قفز مرتفع: ON" or "قفز مرتفع: OFF"
    JumpBtn.BackgroundColor3 = jumpToggle and Color3.fromRGB(40, 180, 40) or Color3.fromRGB(60, 60, 60)
    
    local char = LocalPlayer.Character
    if char and char:FindFirstChildOfClass("Humanoid") then
        local hum = char:FindFirstChildOfClass("Humanoid")
        hum.UseJumpPower = true
        hum.JumpPower = jumpToggle and 130 or 50
    end
end)

-- 10. كشف البيض والوحوش (ESP)
EspBtn.MouseButton1Click:Connect(function()
    espToggle = not espToggle
    EspBtn.Text = espToggle and "كشف البيض والوحوش (ESP): ON" or "كشف البيض والوحوش (ESP): OFF"
    EspBtn.BackgroundColor3 = espToggle and Color3.fromRGB(40, 180, 40) or Color3.fromRGB(60, 60, 60)
end)

task.spawn(function()
    while task.wait(1) do
        if espToggle then
            for _, v in pairs(Workspace:GetDescendants()) do
                if v:IsA("Model") or v:IsA("BasePart") then
                    local name = string.lower(v.Name)
                    if string.find(name, "egg") or string.find(name, "pet") or string.find(name, "lion") then
                        if not v:FindFirstChild("ProHighlight") then
                            local hl = Instance.new("Highlight")
                            hl.Name = "ProHighlight"
                            hl.Parent = v
                            hl.FillColor = string.find(name, "egg") and Color3.fromRGB(255, 215, 0) or Color3.fromRGB(255, 0, 0)
                            hl.OutlineColor = Color3.fromRGB(255, 255, 255)
                        end
                    end
                end
            end
        else
            for _, v in pairs(Workspace:GetDescendants()) do
                if v:FindFirstChild("ProHighlight") then
                    v.ProHighlight:Destroy()
                end
            end
        end
    end
end)
