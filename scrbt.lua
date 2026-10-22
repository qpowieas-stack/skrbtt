-- سكربت حركات عشوائية لشخصيتك
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local rootPart = character:WaitForChild("HumanoidRootPart")

-- جدول يحتوي على الحركات العشوائية
local actions = {
    function()
        -- قفزة مع الدوران السريع
        humanoid.Jump = true
        for i = 1, 10 do
            rootPart.CFrame = rootPart.CFrame * CFrame.Angles(0, math.rad(36), 0)
            task.wait(0.05)
        end
    end,
    function()
        -- إرسال رسالة عشوائية في الشات (اختياري، يظهر للجميع)
        game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("...شيء عشوائي يحدث هنا...", "All")
    end,
    function()
        -- تغيير سرعة الحركة بشكل مفاجئ
        humanoid.WalkSpeed = math.random(10, 40)
        task.wait(2)
        humanoid.WalkSpeed = 16 -- العودة للسرعة الطبيعية
    end,
    function()
        -- الجلوس والوقوف بسرعة
        humanoid.Sit = true
        task.wait(1)
        humanoid.Sit = false
    end
}

-- حلقة تكرارية تنفذ حركة عشوائية كل بضع ثوانٍ
while true do
    local randomAction = actions[math.random(1, #actions)]
    pcall(randomAction)
    task.wait(math.random(3, 7)) -- ينتظر وقتاً عشوائياً بين كل حركة وأخرى
end
