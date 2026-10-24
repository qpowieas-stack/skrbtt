-- Roblox Delta Script: Steal The Egg (Server Bypass & TP Farm)
-- Executor: Delta Executor

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- 1. إنشاء واجهة المستخدم (UI)
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

ScreenGui.Name = "StealEggBypassUI"

-- القائمة الرئيسية
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.BorderColor3 = Color3.fromRGB(200, 200, 200)
MainFrame.BorderSizePixel = 2
MainFrame.Position = UDim2.new(0.35, 0, 0.2, 0)
MainFrame.Size = UDim2.new(0, 240, 0, 290)
MainFrame.Active = true
MainFrame.Draggable = true

-- العنوان
Title.Name = "Title"
Title.Parent = MainFrame
Title.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Title.BorderSizePixel = 0
Title.Size = UDim2.new(1, 0, 0, 35)
Title.Font = Enum.Font.SourceSansBold
Title.Text = "🥚 Steal The Egg (Classic)"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 17

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

-- إنشاء الأزرار
local function createButton(name, text, pos, color)
    local btn = Instance.new("TextButton")
    btn.Name = name
    btn.Parent = MainFrame
    btn.BackgroundColor3 = color
    btn.Position = pos
    btn.Size = UDim2.new(0.85, 0, 0, 36)
    btn.Font = Enum.Font.SourceSansBold
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 14
    return btn
end

local StealthBtn = createButton("StealthBtn", "حماية والتخفي: OFF", UDim2.new(0.075, 0, 0.15, 0), Color3.fromRGB(150, 50, 50))
local SpeedBtn = createButton("SpeedBtn", "سرعة مشي: OFF", UDim2.new(0.075, 0, 0.31, 0), Color3.fromRGB(60, 60, 60))
local JumpBtn = createButton("JumpBtn", "قفز عالي: OFF", UDim2.new(0.075, 0, 0.47, 0), Color3.fromRGB(60, 60, 60))
local EspBtn = createButton("EspBtn", "كشف البيض (ESP): OFF", UDim2.new(0.075, 0, 0.63, 0), Color3.fromRGB(60, 60, 60))
local FarmBtn = createButton("FarmBtn", "سرقة البيضة بسرعة ⚡", UDim2.new(0.075, 0, 0.79, 0), Color3.fromRGB(40, 100, 180))

-----------------------------------------------------
-- البرمجة المعدلة لنظام السيرفر
-----------------------------------------------------

local stealthToggle = false
local speedToggle = false
local jumpToggle = false
local espToggle = false

-- 1. وضع التخفي والحماية من الموت (Godmode/Anti-Kill)
StealthBtn.MouseButton1Click:Connect(function()
    stealthToggle = not stealthToggle
    StealthBtn.Text = stealthToggle and "حماية والتخفي: ON" or "حماية والتخفي: OFF"
    StealthBtn.BackgroundColor3 = stealthToggle and Color3.fromRGB(40, 180, 40) or Color3.fromRGB(150, 50, 50)
end)

RunService.Stepped:Connect(function()
    if stealthToggle then
        local char = LocalPlayer.Character
        if char then
            -- إلغاء كشف أجزاء الشخصية
            for _, p in pairs(char:GetDescendants()) do
                if p:IsA("BasePart") then
                    p.CanTouch = false
                end
            end
        end
    end
end)

-- 2. السرعة والقفز
local function applyStats()
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("Humanoid") then
        char.Humanoid.WalkSpeed = speedToggle and 50 or 16
        char.Humanoid.UseJumpPower = true
        char.Humanoid.JumpPower = jumpToggle and 120 or 50
    end
end

SpeedBtn.MouseButton1Click:Connect(function()
    speedToggle = not speedToggle
    SpeedBtn.Text = speedToggle and "سرعة مشي: ON" or "سرعة مشي: OFF"
    SpeedBtn.BackgroundColor3 = speedToggle and Color3.fromRGB(40, 180, 40) or Color3.fromRGB(60, 60, 60)
    applyStats()
end)

JumpBtn.MouseButton1Click:Connect(function()
    jumpToggle = not jumpToggle
    JumpBtn.Text = jumpToggle and "قفز عالي: ON" or "قفز عالي: OFF"
    JumpBtn.BackgroundColor3 = jumpToggle and Color3.fromRGB(40, 180, 40) or Color3.fromRGB(60, 60, 60)
    applyStats()
end)

LocalPlayer.CharacterAdded:Connect(function()
    task.wait(1)
    applyStats()
end)

-- 3. كشف مكان البيض (ESP)
EspBtn.MouseButton1Click:Connect(function()
    espToggle = not espToggle
    EspBtn.Text = espToggle and "كشف البيض (ESP): ON" or "كشف البيض (ESP): OFF"
    EspBtn.BackgroundColor3 = espToggle and Color3.fromRGB(40, 180, 40) or Color3.fromRGB(60, 60, 60)
end)

task.spawn(function()
    while task.wait(1) do
        if espToggle then
            for _, v in pairs(Workspace:GetDescendants()) do
                if v:IsA("Model") or v:IsA("BasePart") then
                    local name = string.lower(v.Name)
                    if string.find(name, "egg") or string.find(name, "pet") then
                        if not v:FindFirstChild("EggHighlight") then
                            local hl = Instance.new("Highlight")
                            hl.Name = "EggHighlight"
                            hl.Parent = v
                            hl.FillColor = Color3.fromRGB(255, 215, 0)
                            hl.OutlineColor = Color3.fromRGB(255, 0, 0)
                        end
                    end
                end
            end
        else
            for _, v in pairs(Workspace:GetDescendants()) do
                if v:FindFirstChild("EggHighlight") then
                    v.EggHighlight:Destroy()
                end
            end
        end
    end
end)

-- 4. سرقة البيضة السريعة جداً (الانتقال السريع وأخذ البيضة دون أن يلحق السيرفر بك)
FarmBtn.MouseButton1Click:Connect(function()
    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    
    if hrp then
        local oldCFrame = hrp.CFrame -- حفظ مكانك الآمن الحالي
        
        for _, v in pairs(Workspace:GetDescendants()) do
            if v:IsA("Model") or v:IsA("BasePart") then
                local name = string.lower(v.Name)
                if string.find(name, "egg") then
                    local target = v:IsA("Model") and (v.PrimaryPart or v:FindFirstChildWhichIsA("BasePart")) or v
                    if target then
                        -- نقل سريع جداً إلى البيضة وأخذها
                        hrp.CFrame = target.CFrame * CFrame.new(0, 2, 0)
                        task.wait(0.2)
                        
                        -- محاولة التفاعل أو الضغط
                        if firetouchinterest and target:IsA("BasePart") then
                            firetouchinterest(hrp, target, 0)
                            firetouchinterest(hrp, target, 1)
                        end
                        
                        -- الرجوع فوراً للمكان الآمن قبل أن يستوعب السيرفر
                        task.wait(0.1)
                        hrp.CFrame = oldCFrame
                        break
                    end
                end
            end
        end
    end
end)
