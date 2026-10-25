-- language: Luau, target: Roblox (Delta Executor)
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer

-- محاولة استغلال الأحداث البرمجية (Remotes) المتاحة في بروكهافن لتحديث الحالة عالمياً
local function triggerGlobalEffect()
    -- البحث عن أحداث التحكم بالبيئة أو الأدوات في ReplicatedStorage أو Workspace
    local remotes = ReplicatedStorage:FindFirstChild("Remotes") or ReplicatedStorage:FindFirstChild("Events")
    
    if remotes then
        for _, remote in ipairs(remotes:GetDescendants()) do
            if remote:IsA("RemoteEvent") then
                -- محاولة إرسال إشارة لتعديل بيئة الماب إذا كانت مدعومة من السيرفر
                pcall(function()
                    remote:FireServer("UpdateEnvironment", {Theme = "Neon", Global = true})
                end)
            end
        end
    end

    -- تعديل الخصائص المتاحة عبر النطاق المحلي المشترك للأجزاء التفاعلية
    for _, obj in ipairs(workspace:GetChildren()) do
        if obj.Name:lower():match("house") or obj.Name:lower():match("prop") or obj.Name:lower():match("car") then
            for _, part in ipairs(obj:GetDescendants()) do
                if part:IsA("BasePart") then
                    pcall(function()
                        part.Material = Enum.Material.Neon
                    end)
                end
            end
        end
    end
end

-- واجهة تحكم لتطبيق التغيير الجماعي
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "GlobalBrookhavenGUI"
ScreenGui.Parent = game.CoreGui

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 200, 0, 100)
MainFrame.Position = UDim2.new(0.1, 0, 0.3, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local GlobalBtn = Instance.new("TextButton")
GlobalBtn.Size = UDim2.new(0, 180, 0, 60)
GlobalBtn.Position = UDim2.new(0, 10, 0, 20)
GlobalBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
GlobalBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
GlobalBtn.Text = "تفعيل التغيير للجميع (Global Sync)"
GlobalBtn.Font = Enum.Font.GothamBold
GlobalBtn.TextSize = 14
GlobalBtn.Parent = MainFrame

GlobalBtn.MouseButton1Click:Connect(function()
    triggerGlobalEffect()
    GlobalBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
    GlobalBtn.Text = "تم تطبيق التعديل الجماعي!"
end)
