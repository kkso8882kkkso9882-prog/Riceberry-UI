# 🍓 Riceberry UI Library — คู่มือการใช้งาน

Riceberry UI เป็น UI Library สำหรับ Roblox Lua/Luau
ใช้สำหรับสร้างหน้าต่าง UI และองค์ประกอบต่าง ๆ เช่น Button, Toggle, Textbox, Dropdown, Slider, Keybind, Notification, Theme และอื่น ๆ

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## 📥 โหลด Library

local Riceberry = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/kkso8882kkkso9882-prog/Riceberry-UI/refs/heads/main/LibraryUI.lua"
))()

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## 🪟 CreateWindow

ใช้สร้างหน้าต่างหลักของ UI

local Window = Riceberry:CreateWindow({
    Name = "My Window",
    Title = "My Script",
    Subtitle = "Riceberry UI"
})

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## 🔘 CreateButton

สร้างปุ่ม

Window:CreateButton({
    Name = "กดฉัน",
    Callback = function()
        print("Button Clicked!")
    end
})

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## 🔄 CreateToggle

สร้าง Toggle เปิด/ปิด

Window:CreateToggle({
    Name = "เปิดใช้งาน",
    Default = false,
    Callback = function(Value)
        print("Toggle:", Value)
    end
})

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## 📝 CreateTextbox

สร้างช่องกรอกข้อความ

Window:CreateTextbox({
    Name = "ใส่ข้อความ",
    Placeholder = "พิมพ์ที่นี่...",
    Default = "",
    Callback = function(Text)
        print(Text)
    end
})

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## 🏷️ CreateLabel

สร้างข้อความ

Window:CreateLabel({
    Text = "ข้อความของฉัน"
})

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## 📌 CreateSection

สร้างหัวข้อแบ่งหมวด

Window:CreateSection("Main")

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## 📄 CreateParagraph

สร้างข้อความรายละเอียด

Window:CreateParagraph({
    Title = "ข้อมูล",
    Text = "รายละเอียดของสคริปต์"
})

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## 📋 CreateDropdown

สร้าง Dropdown

Window:CreateDropdown({
    Name = "เลือกโหมด",
    Values = {
        "Mode 1",
        "Mode 2",
        "Mode 3"
    },
    Default = "Mode 1",
    Callback = function(Value)
        print("Selected:", Value)
    end
})

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## 🎚️ CreateSlider

สร้าง Slider

Window:CreateSlider({
    Name = "ความแรง",
    Min = 1,
    Max = 100,
    Default = 50,
    Callback = function(Value)
        print("Value:", Value)
    end
})

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## ⌨️ CreateKeybind

สร้างปุ่มลัด

Window:CreateKeybind({
    Name = "เปิด/ปิด",
    Default = Enum.KeyCode.RightShift,
    Callback = function()
        print("Key pressed")
    end
})

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## ➖ CreateDivider

สร้างเส้นแบ่ง

Window:CreateDivider()

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## ↕️ CreateSpacer

สร้างพื้นที่ว่าง

Window:CreateSpacer(10)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## 🔳 CreateIconButton

สร้างปุ่มไอคอน

Window:CreateIconButton({
    Icon = "⚙",
    Tooltip = "Settings",
    Callback = function()
        print("Icon clicked")
    end
})

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## 🟢 CreateStatus

แสดงสถานะ

Window:CreateStatus({
    Text = "Connected",
    Color = Color3.fromRGB(0, 255, 0)
})

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## 📊 CreateProgress

สร้าง Progress Bar

Window:CreateProgress({
    Name = "Progress",
    Value = 50,
    Max = 100
})

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## 🔔 CreateNotification

สร้าง Notification

Riceberry:CreateNotification({
    Title = "แจ้งเตือน",
    Text = "ทำงานเรียบร้อยแล้ว!",
    Duration = 3
})

หรือใช้แบบย่อ:

Riceberry:Notify(
    "Riceberry",
    "ทำงานเรียบร้อยแล้ว!",
    3
)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## 🎨 SetAccent

เปลี่ยนสีหลักของ UI

Riceberry:SetAccent(
    Color3.fromRGB(180, 50, 100)
)

ดูสี Accent ปัจจุบัน:

local Accent = Riceberry:GetAccent()

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## 🎨 CreateTheme

สร้าง Theme

local Theme = Riceberry:CreateTheme({
    Background = Color3.fromRGB(20, 20, 20),
    Surface = Color3.fromRGB(30, 30, 30),
    Accent = Color3.fromRGB(180, 50, 100),
    Text = Color3.fromRGB(255, 255, 255)
})

ใช้ Theme:

Riceberry:ApplyTheme(Theme)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## 🎨 CreateSimpleTheme

สร้าง Theme แบบง่าย

local Theme = Riceberry:CreateSimpleTheme(
    Color3.fromRGB(180, 50, 100)
)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## ✨ Animate

สร้าง Tween Animation

Riceberry:Animate(
    Instance,
    {
        BackgroundTransparency = 0
    },
    0.3
)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## 💥 Pulse

สร้าง Animation แบบ Pulse

Riceberry:Pulse(Instance)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## 📳 Shake

สร้าง Animation แบบ Shake

Riceberry:Shake(Instance)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## 🗂️ CreateTabs

สร้างระบบ Tabs

local Tabs = Window:CreateTabs({
    "Main",
    "Settings"
})

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## 🍞 CreateToast

สร้าง Toast

Window:CreateToast({
    Title = "สำเร็จ",
    Text = "ทำงานเรียบร้อยแล้ว!",
    Duration = 3
})

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## 🎨 Window:ApplyTheme

ใช้ Theme กับ Window

Window:ApplyTheme(Theme)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## ❌ Destroy

ลบ Window และ UI

Window:Destroy()

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

# 🔗 Aliases

คำสั่งเหล่านี้เป็นชื่อย่อของคำสั่งหลัก

Button = CreateButton
Toggle = CreateToggle
Textbox = CreateTextbox
Label = CreateLabel
Section = CreateSection
Dropdown = CreateDropdown
Slider = CreateSlider
Keybind = CreateKeybind
Divider = CreateDivider
Spacer = CreateSpacer

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

# 🧩 ตัวอย่างใช้งานแบบเต็ม

local Riceberry = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/kkso8882kkkso9882-prog/Riceberry-UI/refs/heads/main/LibraryUI.lua"
))()

local Window = Riceberry:CreateWindow({
    Name = "My Script",
    Title = "Riceberry UI",
    Subtitle = "Example"
})

Window:CreateSection("Main")

Window:CreateButton({
    Name = "Test Button",
    Callback = function()
        print("Hello World!")
    end
})

Window:CreateToggle({
    Name = "Enable",
    Default = false,
    Callback = function(Value)
        print("Enabled:", Value)
    end
})

Window:CreateSlider({
    Name = "Power",
    Min = 1,
    Max = 100,
    Default = 50,
    Callback = function(Value)
        print("Power:", Value)
    end
})

Window:CreateDropdown({
    Name = "Mode",
    Values = {
        "A",
        "B",
        "C"
    },
    Default = "A",
    Callback = function(Value)
        print("Mode:", Value)
    end
})

Riceberry:Notify(
    "Riceberry",
    "UI Loaded!",
    3
)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

# 📚 API ทั้งหมด

CreateWindow       = สร้างหน้าต่าง UI
CreateButton       = สร้างปุ่ม
CreateToggle       = สร้าง Toggle
CreateTextbox      = สร้างช่องกรอกข้อความ
CreateLabel        = สร้างข้อความ
CreateSection      = สร้างหัวข้อ
CreateParagraph    = สร้าง Paragraph
CreateDropdown     = สร้าง Dropdown
CreateSlider       = สร้าง Slider
CreateKeybind      = สร้าง Keybind
CreateDivider      = สร้างเส้นแบ่ง
CreateSpacer       = สร้างพื้นที่ว่าง
CreateIconButton   = สร้างปุ่มไอคอน
CreateStatus       = แสดงสถานะ
CreateProgress     = แสดง Progress Bar
CreateTabs         = สร้าง Tabs
CreateToast        = สร้าง Toast
CreateNotification  = สร้าง Notification
Notify             = Notification แบบย่อ
SetAccent          = เปลี่ยนสี Accent
GetAccent          = อ่านสี Accent
CreateTheme        = สร้าง Theme
ApplyTheme         = ใช้ Theme
CreateSimpleTheme  = สร้าง Theme แบบง่าย
Animate             = Tween Animation
Pulse               = Pulse Animation
Shake               = Shake Animation
Destroy             = ลบ UI

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

# ⚠️ หมายเหตุ

ควรโหลด Riceberry UI ก่อนสร้าง Window และควรสร้างองค์ประกอบ UI หลังจากสร้าง Window แล้ว

Riceberry UI รองรับ API หลักและ Alias ตามที่ระบุไว้ในคู่มือนี้
