-- Roblox Delta Skin Copier (Local / Client-Side)
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- إنشاء الواجهة (ScreenGui)
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SkinCopierGui"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- إطار القائمة الصغيرة (Main Frame)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 250, 0, 150)
MainFrame.Position = UDim2.new(0.5, -125, 0.4, -75)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true -- يمكنك تحريك القائمة في الشاشة
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = MainFrame

-- العنوان (Title)
local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, 0, 0, 35)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "ناسخ السكنات (خاص بك)"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 16
TitleLabel.Font = Enum.Font.SourceSansBold
TitleLabel.Parent = MainFrame

-- حقل إدخال اسم اليوزر (TextBox)
local UsernameInput = Instance.new("TextBox")
UsernameInput.Size = UDim2.new(0.85, 0, 0, 35)
UsernameInput.Position = UDim2.new(0.075, 0, 0.3, 0)
UsernameInput.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
UsernameInput.TextColor3 = Color3.fromRGB(255, 255, 255)
UsernameInput.PlaceholderText = "اكتب اليوزر هنا..."
UsernameInput.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
UsernameInput.Text = ""
UsernameInput.TextSize = 14
UsernameInput.Font = Enum.Font.SourceSans
UsernameInput.Parent = MainFrame

local InputCorner = Instance.new("UICorner")
InputCorner.CornerRadius = UDim.new(0, 6)
InputCorner.Parent = UsernameInput

-- زر النسخ (Copy Button)
local CopyButton = Instance.new("TextButton")
CopyButton.Size = UDim2.new(0.85, 0, 0, 35)
CopyButton.Position = UDim2.new(0.075, 0, 0.62, 0)
CopyButton.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
CopyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CopyButton.Text = "نسخ السكن"
CopyButton.TextSize = 15
CopyButton.Font = Enum.Font.SourceSansBold
CopyButton.Parent = MainFrame

local ButtonCorner = Instance.new("UICorner")
ButtonCorner.CornerRadius = UDim.new(0, 6)
ButtonCorner.Parent = CopyButton

-- دالة نسخ السكن
local function copySkin()
    local targetUsername = UsernameInput.Text
    if targetUsername == "" then return end

    local success, targetUserId = pcall(function()
        return Players:GetUserIdFromNameAsync(targetUsername)
    end)

    if success and targetUserId then
        local myCharacter = LocalPlayer.Character
        if myCharacter and myCharacter:FindFirstChild("Humanoid") then
            -- جلب المظهر المعتمد لليوزر المطلوب
            local humanoidDescription = Players:GetHumanoidDescriptionFromUserId(targetUserId)
            -- تطبيق المظهر على شخصيتك محلياً
            myCharacter.Humanoid:ApplyDescription(humanoidDescription)
            CopyButton.Text = "تم النسخ بنجاح!"
            task.wait(1.5)
            CopyButton.Text = "نسخ السكن"
        end
    else
        CopyButton.Text = "اليوزر غير صحيح!"
        task.wait(1.5)
        CopyButton.Text = "نسخ السكن"
    end
end

CopyButton.MouseButton1Click:Connect(copySkin)
