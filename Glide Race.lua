if game.CoreGui:FindFirstChild("ui") then
    game.CoreGui["ui"]:Destroy()
end

local autoFarm = false
local autoRebirth = false
local autoEgg = false
local autoSpeed = false
local Player = game.Players.LocalPlayer

local eggs = {}
local selectedEgg = {}
for i, v in next, game:GetService("Workspace").Huan:GetChildren() do
    table.insert(eggs, v.Name)
end

local function tpToEgg()
    game.Players.LocalPlayer.Character:PivotTo(game:GetService("Workspace").Huan[selectedEgg].CFrame)
end

local function giveSpeed()
    game:GetService("ReplicatedStorage").Remote.Event.Game:FindFirstChild("[C-S]PlayerPick"):FireServer(9e07)
end

local function farm()
    spawn(
        function()
            while autoFarm == true do
                pcall(
                    function()
                        task.wait()
                        firetouchinterest(
                            game.Players.LocalPlayer.Character:WaitForChild("Head"),
                            game:GetService("Workspace").Launch.Lunch,
                            0
                        )
                        firetouchinterest(
                            game.Players.LocalPlayer.Character:WaitForChild("Head"),
                            game:GetService("Workspace").Launch.Lunch,
                            1
                        )
                    end
                )
                if not autoFarm then
                    break
                end
            end
        end
    )
end

local function rebirth()
    spawn(
        function()
            while autoRebirth == true do
                task.wait()
                game:GetService("ReplicatedStorage").Remote.Event.Rebirth:FindFirstChild("[C-S]TryBuyRebirth"):FireServer(

                )
                if not autoRebirth then
                    break
                end
            end
        end
    )
end

local function hatch()
    spawn(
        function()
            while autoEgg == true do
                task.wait()
                game:GetService("ReplicatedStorage").Remote.Function.Luck:FindFirstChild("[C-S]DoLuck"):InvokeServer(
                    selectedEgg
                )
                if not autoEgg then
                    break
                end
            end
        end
    )
end

local rebirths = game:GetService("Players").LocalPlayer.leaderstats["Rebirth"]

local function getSpeed()
    spawn(
        function()
            if autoSpeed == true then
                rebirths:GetPropertyChangedSignal("Value"):Connect(
                    function()
                        print("Rebirthed")
                        giveSpeed()
                    end
                )
            else
                return
            end
        end
    )
end

spawn(
    function()
        game.Players.LocalPlayer.leaderstats["Speed"]:GetPropertyChangedSignal("Value"):Connect(
            function()
                if game.Players.LocalPlayer.leaderstats["Speed"].Value < 0 then
                    for i = 1, 80 do
                        local args = {
                            [1] = 9e16
                        }

                        game:GetService("ReplicatedStorage").Remote.Event.Game:FindFirstChild("[C-S]PlayerPick"):FireServer(
                            unpack(args)
                        )
                    end
                end
            end
        )
    end
)

local lib = loadstring(game:HttpGet "https://raw.githubusercontent.com/dawid-scripts/UI-Libs/main/Vape.txt")()

local win =
    lib:Window(
    game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name,
    Color3.fromRGB(44, 120, 224),
    Enum.KeyCode.RightControl
)

local tab = win:Tab("Main")

tab:Toggle(
    "Auto Win",
    false,
    function(t)
        autoFarm = t
        if autoFarm then
            farm()
        end
    end
)

tab:Button(
    "Give Speed",
    function()
        giveSpeed()
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
    "Auto Get Speed After Rebirth",
    false,
    function(t)
        getSpeed()
    end
)

tab:Toggle(
    "Auto Hatch",
    false,
    function(t)
        autoEgg = t
        if autoEgg then
            hatch()
        end
    end
)

tab:Button(
    "Teleport To Egg",
    function()
        tpToEgg()
    end
)

tab:Dropdown(
    "Select Egg",
    eggs,
    function(t)
        selectedEgg = t
    end
)
