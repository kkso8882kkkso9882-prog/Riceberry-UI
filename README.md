# 🍓 Riceberry UI Library — คู่มือการใช้งาน

Riceberry UI เป็น UI Library สำหรับ Roblox Lua/Luau  
รองรับ Window, Button, Toggle, Textbox, Label, Section, Paragraph,  
Dropdown, Slider, Keybind, Divider, Spacer, IconButton, Status,  
Progress, Tabs, Notification, Theme และ Animation

> คู่มือนี้ตรงกับเวอร์ชันที่แก้ bug แล้ว (Window.Content, Slider, Dropdown:Refresh, Tabs:Select, CreateToast)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## 📥 โหลด Library

```lua
local Riceberry = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/kkso8882kkkso9882-prog/Riceberry-UI/refs/heads/main/LibraryUI.lua"
))()
```

หรือใช้ไฟล์ที่แก้ bug แล้วจาก local / artifact ของคุณ

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## 🪟 CreateWindow

ใช้ **Name** และ **Ability** เท่านั้น (ไม่มี Title / Subtitle)

```lua
local Window = Riceberry:CreateWindow({
    Name = "My Window",
    Ability = "My Script"
})
```

- มีปุ่ม Minimize / Maximize / Close ในตัว
- Close จะมี Confirmation Dialog ก่อนปิด
- `Window.Content`, `Window.Main`, `Window.Gui` ถูกแนบให้อัตโนมัติ (ใช้กับ Extended API ได้)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## 🔘 CreateButton

```lua
Window:CreateButton({
    Name = "กดฉัน",
    Callback = function()
        print("Button Clicked!")
    end
})
```

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## 🔄 CreateToggle

```lua
local Toggle = Window:CreateToggle({
    Name = "เปิดใช้งาน",
    Default = false,          -- true / false
    Callback = function(Value)
        print(Value)          -- ได้ Boolean
    end
})

Toggle:Set(true)
print(Toggle:Get())           -- true / false
```

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## 📝 CreateTextbox

Callback ทำงานเมื่อ **FocusLost** (เสียโฟกัส)

```lua
local Box = Window:CreateTextbox({
    Default = "",
    Placeholder = "พิมพ์ข้อความ...",
    Callback = function(Text)
        print(Text)
    end
})
```

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## 🏷️ CreateLabel

รับ **String โดยตรง** (ไม่ใช่ Table)

```lua
Window:CreateLabel("ข้อความของฉัน")
```

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## 📌 CreateSection

```lua
Window:CreateSection("Main")
```

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## 📄 CreateParagraph

ใช้ **Title**, **Content**, **Height**

```lua
Window:CreateParagraph({
    Title = "ข้อมูล",
    Content = "รายละเอียดของสคริปต์",
    Height = 68                 -- optional (default 68)
})
```

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## 📋 CreateDropdown

รองรับทั้ง `Options` และ `Values`

```lua
local Dropdown = Window:CreateDropdown({
    Name = "เลือกโหมด",
    Options = {                 -- หรือใช้ Values ก็ได้
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

-- Refresh สร้างปุ่ม Option ใหม่จริง (rebuild)
Dropdown:Refresh({
    "Mode 1",
    "Mode 2"
})
```

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## 🎚️ CreateSlider

- มี hit area กว้างขึ้น กดง่าย (เมาส์ + ทัช)
- ตอนลากอัปเดตทันที ไม่กระตุก
- รองรับ `Rounding` สำหรับทศนิยม

```lua
local Slider = Window:CreateSlider({
    Name = "ความแรง",
    Min = 1,
    Max = 100,
    Default = 50,
    Rounding = 0,               -- จำนวนทศนิยม (0 = จำนวนเต็ม)
    Callback = function(Value)
        print(Value)
    end
})

Slider:Set(75)
print(Slider:Get())
```

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## ⌨️ CreateKeybind

รองรับ Keyboard KeyCode  
กด **Escape** ระหว่าง rebind = ยกเลิกโดยไม่เปลี่ยนคีย์

```lua
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
print(Keybind:Get())            -- ได้ Enum.KeyCode
```

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## ➖ CreateDivider

```lua
Window:CreateDivider()
```

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## ↕️ CreateSpacer

```lua
Window:CreateSpacer(10)         -- ความสูง (default 8)
```

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## 🔳 CreateIconButton

รองรับ Size, Background, Icon, Color, TextSize, Callback  
**ไม่มี Tooltip**

```lua
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
```

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## 🟢 CreateStatus

```lua
local Status = Window:CreateStatus({
    Text = "Connected",
    Color = Color3.fromRGB(0, 255, 0)
})

Status:Set("Running", Color3.fromRGB(255, 200, 0))
```

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## 📊 CreateProgress

ค่าอยู่ระหว่าง **0–100** เท่านั้น ใช้ `Default`

```lua
local Progress = Window:CreateProgress({
    Name = "Progress",
    Default = 50
})

Progress:Set(80)
print(Progress:Get())
```

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## 🔔 CreateNotification / Notify

ใช้ **Message** (ไม่ใช่ Text)

```lua
Riceberry:CreateNotification({
    Title = "แจ้งเตือน",
    Message = "ทำงานเรียบร้อยแล้ว!",
    Duration = 3,               -- วินาที
    Color = Color3.fromRGB(180, 50, 100)  -- optional
})

-- หรือแบบสั้น
Riceberry:Notify("Riceberry", "ทำงานเรียบร้อยแล้ว!", 3)
```

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## 🎨 SetAccent / GetAccent

```lua
Riceberry:SetAccent(Color3.fromRGB(180, 50, 100))
local Accent = Riceberry:GetAccent()
```

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## 🎨 CreateTheme

ต้องส่ง **2 Arguments**: ชื่อ Theme + Table

```lua
Riceberry:CreateTheme("MyTheme", {
    Background = Color3.fromRGB(20, 20, 20),
    Surface    = Color3.fromRGB(30, 30, 30),
    Element    = Color3.fromRGB(38, 38, 45),
    Accent     = Color3.fromRGB(180, 50, 100),
    Text       = Color3.fromRGB(240, 240, 245),
    Muted      = Color3.fromRGB(155, 155, 165)
})

Riceberry:ApplyTheme("MyTheme")
```

**หมายเหตุ:** `ApplyTheme` ตอนนี้เปลี่ยน Accent เป็นหลัก (ยังไม่เปลี่ยนสี Background / Element ของทุก element ใน Window)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## 🎨 CreateSimpleTheme

**ไม่รับ Argument**

```lua
Riceberry:CreateSimpleTheme()   -- สร้าง Theme ชื่อ "Riceberry" อัตโนมัติ
Riceberry:ApplyTheme("Riceberry")
```

(เรียกให้อัตโนมัติตอนโหลด Library แล้ว)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## ✨ Animate

```lua
Riceberry:Animate(Instance, {
    BackgroundTransparency = 0
}, 0.3)

-- ระบุ Style + Direction ได้
Riceberry:Animate(Instance, {
    Size = UDim2.fromOffset(300, 200)
}, 0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
```

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## 💥 Pulse

```lua
Riceberry:Pulse(Instance, 1.04, 0.18)   -- scale, duration
```

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## 📳 Shake

```lua
Riceberry:Shake(Instance, 5, 0.25)      -- intensity, duration
```

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## 🗂️ CreateTabs

```lua
local Tabs = Window:CreateTabs()

local Tab1 = Tabs:AddTab("Main")
local Tab2 = Tabs:AddTab("Settings")

Tabs:Select("Main")
```

**พฤติกรรมปัจจุบัน:**
- แท็บแรกถูกเลือกอัตโนมัติ
- สลับแท็บแล้วรีเซ็ตสีปุ่มก่อนหน้าถูกต้อง
- `Tabs:Select(name)` ทำงานได้ (ไม่เรียก `:Activate()` อีกแล้ว)
- รองรับ `tab.Container` ใน logic แต่ **ยังไม่มี API สร้าง Content Container ต่อแท็บ**  
  (ถ้าต้องการ content แยกแท็บ ต้องสร้าง Frame เองแล้วใส่ใน `tab.Container`)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## 🍞 CreateToast

```lua
Window:CreateToast("ข้อความสั้น ๆ")
```

ใช้ชื่อหน้าต่างเป็น Title ของ notification

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## 🧹 Destroy

```lua
Window:Destroy()
```

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## ⚡ Short Aliases

สามารถใช้ชื่อสั้นแทนได้ (ถูกแนบให้ Window อัตโนมัติ)

```lua
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

Window:Dropdown("Mode", {"A", "B", "C"}, function(Value)
    print(Value)
end)

Window:Slider("Power", 1, 100, 50, function(Value)
    print(Value)
end)

Window:Keybind("Toggle", Enum.KeyCode.RightShift, function(Key)
    print(Key.Name)
end)

Window:Divider()
Window:Spacer(10)
```

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## ✅ สถานะหลังแก้ Bug

| รายการ | สถานะ |
|--------|--------|
| `Window.Content` ไม่ถูกเซ็ต | ✅ แก้แล้ว (`Content`, `Main`, `Gui`) |
| Slider ลากกระตุก / ยาก | ✅ แก้แล้ว (hit area + อัปเดตทันที) |
| `Dropdown:Refresh()` ไม่สร้างปุ่มใหม่ | ✅ แก้แล้ว (rebuild) |
| `CreateToast` อ้าง `Config` นอก scope | ✅ แก้แล้ว |
| `Tabs:Select()` เรียก `:Activate()` | ✅ แก้แล้ว |
| สีปุ่ม Tab ค้าง | ✅ แก้แล้ว |
| Keybind กด Escape ยกเลิก rebind | ✅ เพิ่มแล้ว |
| `ApplyTheme` เปลี่ยนแค่ Accent | ⚠️ ยังจำกัด (ตั้งใจไว้) |
| Tabs ไม่มี API สร้าง Container ต่อแท็บ | ⚠️ ยังไม่มี (ต้องสร้างเอง) |
| IconButton ไม่มี Tooltip | ⚠️ ยังไม่มี |

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## 🍓 ตัวอย่างรวม (ใช้ได้จริง)

```lua
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

local Slider = Window:CreateSlider({
    Name = "Speed",
    Min = 0,
    Max = 100,
    Default = 50,
    Callback = function(v)
        print("Speed:", v)
    end
})

local Dropdown = Window:CreateDropdown({
    Name = "Mode",
    Options = {"A", "B", "C"},
    Default = "A",
    Callback = function(v)
        print("Mode:", v)
    end
})

Window:CreateLabel("Riceberry UI")

Window:CreateTextbox({
    Placeholder = "พิมพ์อะไรสักอย่าง...",
    Callback = function(Text)
        print(Text)
    end
})

Riceberry:Notify("Riceberry", "UI Loaded!", 3)
```

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

# 🍓 END คู่มือการใช้งานนี้ถูกสร้างโดยAI อาจจะไม่ตรง 100% ต้องไปดึงจากhttps://raw.githubusercontent.com/kkso8882kkkso9882-prog/Riceberry-UI/refs/heads/main/LibraryUI.lua มันจะตรงแน่นอน 100%  
ถ้าเกิดใช้ AI ให้ใช้คำสั่งนี้ 
```Lua
ถ้าเกิดมีการให้สร้าง ui ให้สร้างแต่ถ้าเกิดมีการบอกว่าให้ใช้ uiให้ไปดึงจากhttps://github.com/kkso8882kkkso9882-prog/Riceberry-UI/tree/main มีทั้งคู่มือและ ui จริงๆคู่มือhttps://raw.githubusercontent.com/kkso8882kkkso9882-prog/Riceberry-UI/refs/heads/main/README.md
Uiตัวจริงhttps://raw.githubusercontent.com/kkso8882kkkso9882-prog/Riceberry-UI/refs/heads/main/LibraryUI.luaแนะนำให้เช็คทั้ง 2 ตัวอย่าเดามั่วนะ เพราะว่าerror
```
