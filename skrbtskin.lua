-- سكربت تغيير المظهر المحلي عبر اسم المستخدم (يعمل لـ Delta)
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- استبدل "اسم_اللاعب_هنا" باسم اليوزر الذي تريد نسخ شكله
local targetUsername = "اسم_اللاعب_هنا" 

pcall(function()
    local targetUserId = Players:GetUserIdFromNameAsync(targetUsername)
    if targetUserId then
        local appearanceModel = Players:GetCharacterAppearanceAsync(targetUserId)
        local character = LocalPlayer.Character
        
        if character then
            -- إزالة الملابس الحالية
            for _, v in ipairs(character:GetChildren()) do
                if v:IsA("Clothing") or v:IsA("Accessory") or v:IsA("ShirtGraphic") then
                    v:Destroy()
                end
            end
            
            -- تطبيق المظهر الجديد (يظهر لديك فقط)
            for _, v in ipairs(appearanceModel:GetChildren()) do
                if v:IsA("Clothing") or v:IsA("Accessory") or v:IsA("ShirtGraphic") then
                    v:Clone().Parent = character
                elseif v:IsA("Model") then
                    for _, accessory in ipairs(v:GetChildren()) do
                        accessory:Clone().Parent = character
                    end
                end
            end
        end
    end
end)
