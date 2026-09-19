# 🍓 Riceberry UI Library — คู่มือการใช้งาน

Riceberry UI เป็น UI Library สำหรับ Roblox Lua/Luau
รองรับ Window, Button, Toggle, Textbox, Label, Section, Paragraph,
Dropdown, Slider, Keybind, Divider, Spacer, IconButton, Status,
Progress, Tabs, Notification, Theme และ Animation

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## 📥 โหลด Library

local Riceberry = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/kkso8882kkkso9882-prog/Riceberry-UI/refs/heads/main/LibraryUI.lua"
))()

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## 🪟 CreateWindow

API จริงใช้ Name และ Ability

local Window = Riceberry:CreateWindow({
    Name = "My Window",
    Ability = "My Script"
})

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## 🔘 CreateButton

Window:CreateButton({
    Name = "กดฉัน",
    Callback = function()
        print("Button Clicked!")
    end
})

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## 🔄 CreateToggle

Default เป็น true/false
Callback จะได้รับค่า Boolean

local Toggle = Window:CreateToggle({
    Name = "เปิดใช้งาน",
    Default = false,
    Callback = function(Value)
        print(Value)
    end
})

Toggle:Set(true)
print(Toggle:Get())

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## 📝 CreateTextbox

Callback ทำงานเมื่อช่องเสีย Focus

local Box = Window:CreateTextbox({
    Default = "",
    Placeholder = "พิมพ์ข้อความ...",
    Callback = function(Text)
        print(Text)
    end
})

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## 🏷️ CreateLabel

รับ String โดยตรง ไม่ใช่ Table

Window:CreateLabel("ข้อความของฉัน")

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## 📌 CreateSection

Window:CreateSection("Main")

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## 📄 CreateParagraph

ใช้ Content ไม่ใช่ Text

Window:CreateParagraph({
    Title = "ข้อมูล",
    Content = "รายละเอียดของสคริปต์",
    Height = 68
})

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## 📋 CreateDropdown

รองรับ Options หรือ Values

local Dropdown = Window:CreateDropdown({
    Name = "เลือกโหมด",
    Options = {
        "Mode 1",
        "Mode 2",
        "Mode 3"
    },
    Default = "Mode 1",
    Callback = function(Value)
        print("Selected:", Value)
    end
})

Dropdown:Set("Mode 2")
print(Dropdown:Get())

Dropdown:Refresh({
    "Mode 1",
    "Mode 2"
})

หมายเหตุ:
Refresh เปลี่ยนรายการภายใน แต่โค้ดปัจจุบันไม่ได้สร้างปุ่ม Option ใหม่

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## 🎚️ CreateSlider

local Slider = Window:CreateSlider({
    Name = "ความแรง",
    Min = 1,
    Max = 100,
    Default = 50,
    Rounding = 0,
    Callback = function(Value)
        print(Value)
    end
})

Slider:Set(75)
print(Slider:Get())

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## ⌨️ CreateKeybind

รองรับ Keyboard KeyCode

local Keybind = Window:CreateKeybind({
    Name = "เปิด/ปิด",
    Default = Enum.KeyCode.RightShift,

    Callback = function(Key)
        print("Key pressed:", Key.Name)
    end,

    Changed = function(Key)
        print("Changed:", Key.Name)
    end
})

Keybind:Set(Enum.KeyCode.F)
print(Keybind:Get())

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## ➖ CreateDivider

Window:CreateDivider()

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## ↕️ CreateSpacer

Window:CreateSpacer(10)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## 🔳 CreateIconButton

API จริงรองรับ Size, Background, Icon, Color, TextSize และ Callback

Window:CreateIconButton({
    Size = 42,
    Background = Color3.fromRGB(38, 38, 45),
    Icon = "⚙",
    Color = Color3.fromRGB(180, 50, 100),
    TextSize = 17,

    Callback = function()
        print("Icon clicked")
    end
})

หมายเหตุ:
ไม่มี Tooltip ใน API ปัจจุบัน

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## 🟢 CreateStatus

local Status = Window:CreateStatus({
    Text = "Connected",
    Color = Color3.fromRGB(0, 255, 0)
})

Status:Set(
    "Running",
    Color3.fromRGB(255, 200, 0)
)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## 📊 CreateProgress

ใช้ Default และค่าจะอยู่ระหว่าง 0-100

local Progress = Window:CreateProgress({
    Name = "Progress",
    Default = 50
})

Progress:Set(80)
print(Progress:Get())

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## 🔔 CreateNotification

ใช้ Message ไม่ใช่ Text

Riceberry:CreateNotification({
    Title = "แจ้งเตือน",
    Message = "ทำงานเรียบร้อยแล้ว!",
    Duration = 3
})

หรือ

Riceberry:Notify(
    "Riceberry",
    "ทำงานเรียบร้อยแล้ว!",
    3
)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## 🎨 SetAccent / GetAccent

Riceberry:SetAccent(
    Color3.fromRGB(180, 50, 100)
)

local Accent = Riceberry:GetAccent()

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## 🎨 CreateTheme

CreateTheme ต้องใช้ 2 Arguments:
ชื่อ Theme และ Table

local Theme = Riceberry:CreateTheme("MyTheme", {
    Background = Color3.fromRGB(20, 20, 20),
    Surface = Color3.fromRGB(30, 30, 30),
    Element = Color3.fromRGB(38, 38, 45),
    Accent = Color3.fromRGB(180, 50, 100),
    Text = Color3.fromRGB(240, 240, 245),
    Muted = Color3.fromRGB(155, 155, 165)
})

Riceberry:ApplyTheme("MyTheme")

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## 🎨 CreateSimpleTheme

ไม่รับ Color เป็น Argument

Riceberry:CreateSimpleTheme()

จากนั้น Theme ชื่อ "Riceberry" จะถูกสร้างขึ้น

Riceberry:ApplyTheme("Riceberry")

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## ✨ Animate

Riceberry:Animate(
    Instance,
    {
        BackgroundTransparency = 0
    },
    0.3
)

สามารถกำหนด Style และ Direction เพิ่มได้

Riceberry:Animate(
    Instance,
    {
        Size = UDim2.fromOffset(300, 200)
    },
    0.3,
    Enum.EasingStyle.Quad,
    Enum.EasingDirection.Out
)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## 💥 Pulse

Riceberry:Pulse(
    Instance,
    1.04,
    0.18
)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## 📳 Shake

Riceberry:Shake(
    Instance,
    5,
    0.25
)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## 🗂️ CreateTabs

local Tabs = Window:CreateTabs()

local Tab1 = Tabs:AddTab("Main")
local Tab2 = Tabs:AddTab("Settings")

Tabs:Select("Main")

หมายเหตุ:
API ปัจจุบันสร้างปุ่ม Tab ได้ แต่ยังไม่มี API สำหรับสร้าง Content Container
แยกของแต่ละ Tab

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## 🧹 Destroy

Window:Destroy()

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

# ⚡ Short Aliases

สามารถใช้ชื่อสั้นแทน Create... ได้

Window:Button("กด", function()
    print("Clicked")
end)

Window:Toggle("เปิด", function(Value)
    print(Value)
end, false)

Window:Textbox("พิมพ์ข้อความ...", function(Text)
    print(Text)
end)

Window:Label("ข้อความ")

Window:Section("Main")

Window:Dropdown(
    "Mode",
    {"A", "B", "C"},
    function(Value)
        print(Value)
    end
)

Window:Slider(
    "Power",
    1,
    100,
    50,
    function(Value)
        print(Value)
    end
)

Window:Keybind(
    "Toggle",
    Enum.KeyCode.RightShift,
    function(Key)
        print(Key.Name)
    end
)

Window:Divider()
Window:Spacer(10)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

# ⚠️ หมายเหตุจาก Source Code

1. CreateWindow ใช้:
   Name
   Ability

   ไม่ใช่:
   Title
   Subtitle

2. CreateLabel รับ String โดยตรง:
   Window:CreateLabel("ข้อความ")

3. CreateParagraph ใช้:
   Title
   Content
   Height

4. CreateNotification ใช้:
   Title
   Message
   Duration
   Color

5. CreateTheme ใช้:
   Riceberry:CreateTheme("ชื่อ", Theme)

6. CreateSimpleTheme ไม่รับ Color Argument

7. CreateProgress ใช้ Default และช่วง 0-100
   ไม่มี Value/Max ตามที่คู่มือเก่าเคยเขียน

8. CreateIconButton ไม่มี Tooltip

9. CreateDropdown:Refresh() ใน Source ปัจจุบัน
   เปลี่ยนตาราง values แต่ไม่ได้สร้าง Option Button ใหม่

10. CreateToast() ใน Source ปัจจุบันมี Bug:
    อ้างถึง Config.Name แต่ Config ไม่มีอยู่ใน Function

11. สำคัญ:
    Window.Content ไม่ได้ถูกกำหนดใน CreateWindow
    แต่ Extended API หลายตัวใช้ self.Content

    ดังนั้น CreateSection, CreateParagraph, CreateDropdown,
    CreateSlider, CreateKeybind, CreateDivider, CreateSpacer,
    CreateIconButton, CreateStatus, CreateProgress และ CreateTabs
    อาจทำงานผิดพลาดจนกว่าจะเพิ่ม:

    Window.Content = Content

    ก่อน:

    return Window

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

# 🍓 ตัวอย่างรวม

local Riceberry = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/kkso8882kkkso9882-prog/Riceberry-UI/refs/heads/main/LibraryUI.lua"
))()

local Window = Riceberry:CreateWindow({
    Name = "My Script",
    Ability = "Riceberry UI"
})

Window:CreateSection("Main")

Window:CreateButton({
    Name = "กดฉัน",
    Callback = function()
        print("Clicked")
    end
})

Window:CreateToggle({
    Name = "Enabled",
    Default = false,
    Callback = function(Value)
        print("Enabled:", Value)
    end
})

Window:CreateLabel("Riceberry UI")

Window:CreateParagraph({
    Title = "Information",
    Content = "Riceberry UI Library",
    Height = 68
})

Riceberry:Notify(
    "Riceberry",
    "UI Loaded!",
    3
)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

# 🍓 END คู่มือการใช้งานนี้ถูกสร้างโดยAI อาจจะไม่ตรง 100% ต้องไปดึงจากhttps://raw.githubusercontent.com/kkso8882kkkso9882-prog/Riceberry-UI/refs/heads/main/LibraryUI.lua มันจะตรงแน่นอน 100%  
