local Riceberry = {}

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

local function New(class, props, parent)
	local obj = Instance.new(class)

	for key, value in pairs(props or {}) do
		obj[key] = value
	end

	obj.Parent = parent
	return obj
end

local function Corner(parent, radius)
	return New("UICorner", {
		CornerRadius = UDim.new(0, radius or 8)
	}, parent)
end

local function Stroke(parent, color, thickness)
	return New("UIStroke", {
		Color = color or Color3.fromRGB(90, 90, 90),
		Thickness = thickness or 1
	}, parent)
end

local function Drag(frame, handle)
	local dragging = false
	local dragStart
	local startPos

	handle = handle or frame

	handle.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1
			or input.UserInputType == Enum.UserInputType.Touch then

			dragging = true
			dragStart = input.Position
			startPos = frame.Position

			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if not dragging then
			return
		end

		if input.UserInputType == Enum.UserInputType.MouseMovement
			or input.UserInputType == Enum.UserInputType.Touch then

			local delta = input.Position - dragStart

			frame.Position = UDim2.new(
				startPos.X.Scale,
				startPos.X.Offset + delta.X,
				startPos.Y.Scale,
				startPos.Y.Offset + delta.Y
			)
		end
	end)
end

function Riceberry:CreateWindow(Config)
	Config = Config or {}

	local Name = Config.Name or "Riceberry"
	local Ability = Config.Ability or ""

	local Gui = New("ScreenGui", {
		Name = "RiceberryUI",
		ResetOnSpawn = false,
		ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	}, PlayerGui)

	local Main = New("Frame", {
		Name = "Main",
		Size = UDim2.fromOffset(430, 320),
		Position = UDim2.new(0.5, -215, 0.5, -160),
		BackgroundColor3 = Color3.fromRGB(20, 20, 24),
		BorderSizePixel = 0
	}, Gui)

	Corner(Main, 12)
	Stroke(Main, Color3.fromRGB(70, 70, 78), 1)

	local Top = New("Frame", {
		Name = "Top",
		Size = UDim2.new(1, 0, 0, 55),
		BackgroundColor3 = Color3.fromRGB(30, 30, 36),
		BorderSizePixel = 0
	}, Main)

	Corner(Top, 12)

	local Title = New("TextLabel", {
		Size = UDim2.new(1, -70, 0, 28),
		Position = UDim2.fromOffset(16, 7),
		BackgroundTransparency = 1,
		Text = Name,
		TextColor3 = Color3.fromRGB(255, 255, 255),
		TextSize = 18,
		Font = Enum.Font.GothamBold,
		TextXAlignment = Enum.TextXAlignment.Left
	}, Top)

	local Sub = New("TextLabel", {
		Size = UDim2.new(1, -70, 0, 18),
		Position = UDim2.fromOffset(16, 31),
		BackgroundTransparency = 1,
		Text = Ability,
		TextColor3 = Color3.fromRGB(155, 155, 165),
		TextSize = 11,
		Font = Enum.Font.Gotham,
		TextXAlignment = Enum.TextXAlignment.Left
	}, Top)

	local Close = New("TextButton", {
		Size = UDim2.fromOffset(35, 35),
		Position = UDim2.new(1, -43, 0, 10),
		BackgroundTransparency = 1,
		Text = "×",
		TextColor3 = Color3.fromRGB(230, 230, 235),
		TextSize = 25,
		Font = Enum.Font.GothamBold
	}, Top)

	Close.MouseButton1Click:Connect(function()
		Gui:Destroy()
	end)

	Drag(Main, Top)

	local Content = New("ScrollingFrame", {
		Name = "Content",
		Size = UDim2.new(1, -20, 1, -70),
		Position = UDim2.fromOffset(10, 60),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		ScrollBarThickness = 4,
		CanvasSize = UDim2.fromOffset(0, 0)
	}, Main)

	local Layout = New("UIListLayout", {
		Padding = UDim.new(0, 8),
		SortOrder = Enum.SortOrder.LayoutOrder
	}, Content)

	New("UIPadding", {
		PaddingTop = UDim.new(0, 5),
		PaddingBottom = UDim.new(0, 10),
		PaddingLeft = UDim.new(0, 5),
		PaddingRight = UDim.new(0, 5)
	}, Content)

	Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		Content.CanvasSize = UDim2.fromOffset(
			0,
			Layout.AbsoluteContentSize.Y + 15
		)
	end)

	local Window = {}

	function Window:CreateButton(Config)
		Config = Config or {}

		local Button = New("TextButton", {
			Size = UDim2.new(1, 0, 0, 42),
			BackgroundColor3 = Color3.fromRGB(38, 38, 45),
			BorderSizePixel = 0,
			Text = Config.Name or "Button",
			TextColor3 = Color3.fromRGB(240, 240, 245),
			TextSize = 14,
			Font = Enum.Font.GothamMedium,
			AutoButtonColor = true
		}, Content)

		Corner(Button, 8)

		Button.MouseButton1Click:Connect(function()
			if typeof(Config.Callback) == "function" then
				Config.Callback()
			end
		end)

		return Button
	end

	function Window:CreateToggle(Config)
		Config = Config or {}

		local Enabled = Config.Default == true

		local Button = New("TextButton", {
			Size = UDim2.new(1, 0, 0, 42),
			BackgroundColor3 = Color3.fromRGB(38, 38, 45),
			BorderSizePixel = 0,
			Text = "",
			AutoButtonColor = false
		}, Content)

		Corner(Button, 8)

		local Label = New("TextLabel", {
			Size = UDim2.new(1, -65, 1, 0),
			Position = UDim2.fromOffset(14, 0),
			BackgroundTransparency = 1,
			Text = Config.Name or "Toggle",
			TextColor3 = Color3.fromRGB(240, 240, 245),
			TextSize = 14,
			Font = Enum.Font.GothamMedium,
			TextXAlignment = Enum.TextXAlignment.Left
		}, Button)

		local Switch = New("Frame", {
			Size = UDim2.fromOffset(40, 22),
			Position = UDim2.new(1, -52, 0.5, -11),
			BackgroundColor3 = Color3.fromRGB(65, 65, 72),
			BorderSizePixel = 0
		}, Button)

		Corner(Switch, 20)

		local Dot = New("Frame", {
			Size = UDim2.fromOffset(18, 18),
			Position = UDim2.fromOffset(2, 2),
			BackgroundColor3 = Color3.fromRGB(235, 235, 240),
			BorderSizePixel = 0
		}, Switch)

		Corner(Dot, 20)

		local function Update()
			if Enabled then
				Switch.BackgroundColor3 = Color3.fromRGB(180, 50, 100)
				Dot.Position = UDim2.new(1, -20, 0, 2)
			else
				Switch.BackgroundColor3 = Color3.fromRGB(65, 65, 72)
				Dot.Position = UDim2.fromOffset(2, 2)
			end

			if typeof(Config.Callback) == "function" then
				Config.Callback(Enabled)
			end
		end

		Button.MouseButton1Click:Connect(function()
			Enabled = not Enabled
			Update()
		end)

		Update()

		return {
			Set = function(_, Value)
				Enabled = Value == true
				Update()
			end,

			Get = function()
				return Enabled
			end
		}
	end

	function Window:CreateTextbox(Config)
		Config = Config or {}

		local Box = New("TextBox", {
			Size = UDim2.new(1, 0, 0, 42),
			BackgroundColor3 = Color3.fromRGB(38, 38, 45),
			BorderSizePixel = 0,
			Text = Config.Default or "",
			PlaceholderText = Config.Placeholder or "พิมพ์ข้อความ...",
			PlaceholderColor3 = Color3.fromRGB(120, 120, 130),
			TextColor3 = Color3.fromRGB(240, 240, 245),
			TextSize = 14,
			Font = Enum.Font.Gotham,
			ClearTextOnFocus = false
		}, Content)

		Corner(Box, 8)

		Box.FocusLost:Connect(function()
			if typeof(Config.Callback) == "function" then
				Config.Callback(Box.Text)
			end
		end)

		return Box
	end

	function Window:CreateLabel(Text)
		local Label = New("TextLabel", {
			Size = UDim2.new(1, 0, 0, 30),
			BackgroundTransparency = 1,
			Text = Text or "",
			TextColor3 = Color3.fromRGB(170, 170, 180),
			TextSize = 13,
			Font = Enum.Font.Gotham,
			TextXAlignment = Enum.TextXAlignment.Left
		}, Content)

		return Label
	end

	function Window:Destroy()
		if Gui then
			Gui:Destroy()
		end
	end

	return Window
end

return Riceberry
