if game.CoreGui:FindFirstChild("ui") then
    game.CoreGui["ui"]:Destroy()
end


local autoDunk = false
local autoHatch = false
local autoRebirth = false 
local eggs = {}
local selectedEgg = {}
for i = 1, #game:GetService("Workspace").Eggs:GetChildren() do
    table.insert(eggs, i)
end

local function rebirth()
    spawn(function()
        while autoRebirth == true do
            task.wait()
            game:GetService("ReplicatedStorage").Remotes.RequestRebirth:FireServer()
            if not autoRebirth then
                break
            end
        end
    end)
end

local function hatch()
    spawn(
        function()
            while autoHatch == true do
                task.wait()
                local args = {
                    [1] = selectedEgg,
                    [2] = {}
                }

                game:GetService("ReplicatedStorage").Remotes.BuyEgg:InvokeServer(unpack(args))
                if not autoHatch then
                    break
                end
            end
        end
    )
end

local function dunk()
    spawn(
        function()
            while autoDunk == true do
                task.wait()
                game:GetService("ReplicatedStorage").Remotes.DunkRequest:FireServer()
                if not autoDunk then
                    break
                end
            end
        end
    )
end

local lib = loadstring(game:HttpGet "https://raw.githubusercontent.com/dawid-scripts/UI-Libs/main/Vape.txt")()

local win =
    lib:Window(
    game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name,
    Color3.fromRGB(44, 120, 224),
    Enum.KeyCode.RightControl
)

local tab = win:Tab("Main")

tab:Toggle(
    "Auto Dunk",
    false,
    function(t)
        autoDunk = t
        if autoDunk then
            dunk()
        end
    end
)

tab:Toggle(
    "Auto Rebirth",
    false,
    function(t)
        autoRebirth = t
        if autoRebirth then
            rebirth()
        end
    end
)

tab:Toggle(
    "Auto Hatch",
    false,
    function(t)
        autoHatch = t
        if autoHatch then
            hatch()
        end
    end
)
tab:Dropdown(
    "Select Egg",
    eggs,
    function(t)
        selectedEgg = t
    end
)
