local Riceberry = {}

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

local Accent = Color3.fromRGB(180, 50, 100)

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

local function Tween(obj, props, time, style, direction)
	local t = TweenService:Create(
		obj,
		TweenInfo.new(
			time or 0.18,
			style or Enum.EasingStyle.Quad,
			direction or Enum.EasingDirection.Out
		),
		props
	)
	t:Play()
	return t
end

local function Drag(frame, handle, getBlocked)
	local dragging = false
	local dragStart
	local startPos

	handle = handle or frame

	handle.InputBegan:Connect(function(input)
		if getBlocked and getBlocked() then
			return
		end

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

-- small circular icon button used for minimize / maximize / close
local function IconButton(parent, order)
	local Btn = New("TextButton", {
		Name = "IconButton",
		Size = UDim2.fromOffset(28, 28),
		Position = UDim2.new(1, -34 - (order - 1) * 34, 0, 13),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Text = "",
		AutoButtonColor = false,
		ZIndex = 4
	}, parent)

	Corner(Btn, 14)

	return Btn
end

function Riceberry:CreateWindow(Config)
	Config = Config or {}

	local Name = Config.Name or "Riceberry"
	local Ability = Config.Ability or ""

	local NormalSize = UDim2.fromOffset(430, 320)
	local NormalPosition = UDim2.new(0.5, -215, 0.5, -160)

	local Gui = New("ScreenGui", {
		Name = "RiceberryUI",
		ResetOnSpawn = false,
		ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	}, PlayerGui)

	local Main = New("Frame", {
		Name = "Main",
		Size = NormalSize,
		Position = NormalPosition,
		BackgroundColor3 = Color3.fromRGB(20, 20, 24),
		BorderSizePixel = 0,
		ClipsDescendants = true,
		ZIndex = 2
	}, Gui)

	Corner(Main, 12)
	Stroke(Main, Color3.fromRGB(70, 70, 78), 1)

	New("ImageLabel", {
		Name = "Shadow",
		BackgroundTransparency = 1,
		Image = "rbxassetid://1316045217",
		ImageColor3 = Color3.fromRGB(0, 0, 0),
		ImageTransparency = 0.55,
		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = Rect.new(10, 10, 118, 118),
		Size = UDim2.new(1, 40, 1, 40),
		Position = UDim2.new(0.5, 0, 0.5, 4),
		AnchorPoint = Vector2.new(0.5, 0.5),
		ZIndex = 1
	}, Main)

	local Top = New("Frame", {
		Name = "Top",
		Size = UDim2.new(1, 0, 0, 55),
		BackgroundColor3 = Color3.fromRGB(30, 30, 36),
		BorderSizePixel = 0,
		ZIndex = 3
	}, Main)

	Corner(Top, 12)

	New("Frame", {
		Size = UDim2.new(1, 0, 0, 12),
		Position = UDim2.new(0, 0, 1, -12),
		BackgroundColor3 = Color3.fromRGB(30, 30, 36),
		BorderSizePixel = 0,
		ZIndex = 3
	}, Top)

	New("UIGradient", {
		Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(38, 34, 44)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(26, 26, 32))
		}),
		Rotation = 90
	}, Top)

	-- thin accent line under the header for a bit of branding
	local AccentLine = New("Frame", {
		Size = UDim2.new(1, 0, 0, 2),
		Position = UDim2.new(0, 0, 1, 0),
		BackgroundColor3 = Accent,
		BackgroundTransparency = 0.15,
		BorderSizePixel = 0,
		ZIndex = 3
	}, Top)

	New("UIGradient", {
		Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Accent),
			ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 140, 190)),
			ColorSequenceKeypoint.new(1, Accent)
		})
	}, AccentLine)

	local Title = New("TextLabel", {
		Size = UDim2.new(1, -140, 0, 28),
		Position = UDim2.fromOffset(16, 7),
		BackgroundTransparency = 1,
		Text = Name,
		TextColor3 = Color3.fromRGB(255, 255, 255),
		TextSize = 18,
		Font = Enum.Font.GothamBold,
		TextXAlignment = Enum.TextXAlignment.Left,
		ZIndex = 3
	}, Top)

	New("TextLabel", {
		Size = UDim2.new(1, -140, 0, 18),
		Position = UDim2.fromOffset(16, 31),
		BackgroundTransparency = 1,
		Text = Ability,
		TextColor3 = Color3.fromRGB(155, 155, 165),
		TextSize = 11,
		Font = Enum.Font.Gotham,
		TextXAlignment = Enum.TextXAlignment.Left,
		ZIndex = 3
	}, Top)

	--============================================================
	-- Window controls: minimize, maximize/restore, close
	--============================================================

	local IsMinimized = false
	local IsMaximized = false
	local Dialogging = false

	local MinimizeBtn = IconButton(Top, 3)
	local MaximizeBtn = IconButton(Top, 2)
	local CloseBtn = IconButton(Top, 1)

	local function HoverHighlight(btn, hoverColor)
		btn.MouseEnter:Connect(function()
			Tween(btn, { BackgroundTransparency = 0.85, BackgroundColor3 = hoverColor or Color3.fromRGB(255, 255, 255) }, 0.12)
		end)
		btn.MouseLeave:Connect(function()
			Tween(btn, { BackgroundTransparency = 1 }, 0.12)
		end)
	end

	HoverHighlight(MinimizeBtn)
	HoverHighlight(MaximizeBtn)
	HoverHighlight(CloseBtn, Color3.fromRGB(255, 70, 70))

	-- minimize icon: a simple line
	local MinIcon = New("Frame", {
		Size = UDim2.fromOffset(11, 2),
		Position = UDim2.new(0.5, 0, 0.5, 0),
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundColor3 = Color3.fromRGB(225, 225, 230),
		BorderSizePixel = 0,
		ZIndex = 5
	}, MinimizeBtn)
	Corner(MinIcon, 2)

	-- maximize icon: square outline, becomes a "layered" icon when maximized
	local MaxIconBack = New("Frame", {
		Size = UDim2.fromOffset(9, 9),
		Position = UDim2.new(0.5, -2, 0.5, -2),
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Visible = false,
		ZIndex = 5
	}, MaximizeBtn)
	Stroke(MaxIconBack, Color3.fromRGB(225, 225, 230), 1.3)
	Corner(MaxIconBack, 2)

	local MaxIconFront = New("Frame", {
		Size = UDim2.fromOffset(9, 9),
		Position = UDim2.new(0.5, 1, 0.5, 1),
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		ZIndex = 5
	}, MaximizeBtn)
	Stroke(MaxIconFront, Color3.fromRGB(225, 225, 230), 1.3)
	Corner(MaxIconFront, 2)

	-- close icon: ×
	New("TextLabel", {
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
		Text = "×",
		TextColor3 = Color3.fromRGB(230, 230, 235),
		TextSize = 20,
		Font = Enum.Font.GothamBold,
		ZIndex = 5
	}, CloseBtn)

	local Content = New("ScrollingFrame", {
		Name = "Content",
		Size = UDim2.new(1, -20, 1, -70),
		Position = UDim2.fromOffset(10, 60),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		ScrollBarThickness = 4,
		ScrollBarImageColor3 = Accent,
		CanvasSize = UDim2.fromOffset(0, 0),
		ZIndex = 2
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

	Drag(Main, Top, function()
		return IsMaximized or Dialogging
	end)

	--============================================================
	-- Confirmation dialog (English) — used by the close button
	--============================================================

	local function ShowConfirm(titleText, messageText, onConfirm)
		if Dialogging then
			return
		end
		Dialogging = true

		local Backdrop = New("Frame", {
			Name = "Backdrop",
			Size = UDim2.fromScale(1, 1),
			BackgroundColor3 = Color3.fromRGB(0, 0, 0),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			ZIndex = 10
		}, Gui)

		local Box = New("Frame", {
			Name = "ConfirmBox",
			Size = UDim2.fromOffset(280, 138),
			Position = UDim2.fromScale(0.5, 0.5),
			AnchorPoint = Vector2.new(0.5, 0.5),
			BackgroundColor3 = Color3.fromRGB(26, 26, 31),
			BorderSizePixel = 0,
			ZIndex = 11
		}, Backdrop)

		Corner(Box, 12)
		Stroke(Box, Color3.fromRGB(70, 70, 78), 1)

		New("TextLabel", {
			Size = UDim2.new(1, -32, 0, 24),
			Position = UDim2.fromOffset(16, 16),
			BackgroundTransparency = 1,
			Text = titleText,
			TextColor3 = Color3.fromRGB(255, 255, 255),
			TextSize = 16,
			Font = Enum.Font.GothamBold,
			TextXAlignment = Enum.TextXAlignment.Left,
			ZIndex = 12
		}, Box)

		New("TextLabel", {
			Size = UDim2.new(1, -32, 0, 44),
			Position = UDim2.fromOffset(16, 44),
			BackgroundTransparency = 1,
			Text = messageText,
			TextColor3 = Color3.fromRGB(160, 160, 170),
			TextSize = 13,
			Font = Enum.Font.Gotham,
			TextXAlignment = Enum.TextXAlignment.Left,
			TextWrapped = true,
			ZIndex = 12
		}, Box)

		local function CloseDialog()
			local fade = Tween(Backdrop, { BackgroundTransparency = 1 }, 0.15)
			fade.Completed:Connect(function()
				Backdrop:Destroy()
				Dialogging = false
			end)
		end

		local CancelBtn = New("TextButton", {
			Size = UDim2.new(0.5, -22, 0, 36),
			Position = UDim2.new(0, 16, 1, -52),
			BackgroundColor3 = Color3.fromRGB(38, 38, 45),
			BorderSizePixel = 0,
			Text = "Cancel",
			TextColor3 = Color3.fromRGB(230, 230, 235),
			TextSize = 14,
			Font = Enum.Font.GothamMedium,
			AutoButtonColor = false,
			ZIndex = 12
		}, Box)
		Corner(CancelBtn, 8)

		CancelBtn.MouseEnter:Connect(function()
			Tween(CancelBtn, { BackgroundColor3 = Color3.fromRGB(48, 48, 56) }, 0.1)
		end)
		CancelBtn.MouseLeave:Connect(function()
			Tween(CancelBtn, { BackgroundColor3 = Color3.fromRGB(38, 38, 45) }, 0.1)
		end)
		CancelBtn.MouseButton1Click:Connect(CloseDialog)

		local ConfirmBtn = New("TextButton", {
			Size = UDim2.new(0.5, -22, 0, 36),
			Position = UDim2.new(0.5, 6, 1, -52),
			BackgroundColor3 = Accent,
			BorderSizePixel = 0,
			Text = "Confirm",
			TextColor3 = Color3.fromRGB(255, 255, 255),
			TextSize = 14,
			Font = Enum.Font.GothamBold,
			AutoButtonColor = false,
			ZIndex = 12
		}, Box)
		Corner(ConfirmBtn, 8)

		ConfirmBtn.MouseEnter:Connect(function()
			Tween(ConfirmBtn, { BackgroundColor3 = Color3.fromRGB(200, 60, 115) }, 0.1)
		end)
		ConfirmBtn.MouseLeave:Connect(function()
			Tween(ConfirmBtn, { BackgroundColor3 = Accent }, 0.1)
		end)
		ConfirmBtn.MouseButton1Click:Connect(function()
			CloseDialog()
			if typeof(onConfirm) == "function" then
				onConfirm()
			end
		end)

		-- clicking the dimmed backdrop itself also cancels
		Backdrop.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 then
				local pos = input.Position
				local absPos, absSize = Box.AbsolutePosition, Box.AbsoluteSize
				local inside = pos.X >= absPos.X and pos.X <= absPos.X + absSize.X
					and pos.Y >= absPos.Y and pos.Y <= absPos.Y + absSize.Y
				if not inside then
					CloseDialog()
				end
			end
		end)

		Box.Size = UDim2.fromOffset(260, 126)
		Tween(Backdrop, { BackgroundTransparency = 0.5 }, 0.15)
		Tween(Box, { Size = UDim2.fromOffset(280, 138) }, 0.18, Enum.EasingStyle.Back)
	end

	--============================================================
	-- Button behaviour
	--============================================================

	MinimizeBtn.MouseButton1Click:Connect(function()
		if IsMaximized then
			return
		end

		IsMinimized = not IsMinimized

		if IsMinimized then
			Tween(Main, { Size = UDim2.new(0, Main.AbsoluteSize.X, 0, 55) }, 0.18)
		else
			Tween(Main, { Size = NormalSize }, 0.18)
		end
	end)

	MaximizeBtn.MouseButton1Click:Connect(function()
		if IsMinimized then
			return
		end

		IsMaximized = not IsMaximized

		if IsMaximized then
			local viewport = workspace.CurrentCamera.ViewportSize
			local w = math.min(760, viewport.X - 60)
			local h = math.min(540, viewport.Y - 60)

			Tween(Main, {
				Size = UDim2.fromOffset(w, h),
				Position = UDim2.new(0.5, -w / 2, 0.5, -h / 2)
			}, 0.22, Enum.EasingStyle.Quart)

			MaxIconBack.Visible = true
			MaxIconFront.Position = UDim2.new(0.5, -1, 0.5, -1)
		else
			Tween(Main, {
				Size = NormalSize,
				Position = NormalPosition
			}, 0.22, Enum.EasingStyle.Quart)

			MaxIconBack.Visible = false
			MaxIconFront.Position = UDim2.new(0.5, 1, 0.5, 1)
		end
	end)

	CloseBtn.MouseButton1Click:Connect(function()
		ShowConfirm(
			"Close " .. Name .. "?",
			"Are you sure you want to close this window? You can reopen it by running the script again.",
			function()
				local CloseTween = Tween(Main, {
					Size = UDim2.fromOffset(Main.AbsoluteSize.X, 0),
					BackgroundTransparency = 1
				}, 0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.In)

				CloseTween.Completed:Connect(function()
					Gui:Destroy()
				end)
			end
		)
	end)

	-- gentle open animation
	Main.Size = UDim2.fromOffset(430, 0)
	Tween(Main, { Size = NormalSize }, 0.25, Enum.EasingStyle.Quart)

	local Window = {}
	Window.Content = Content
	Window.Main = Main
	Window.Gui = Gui

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
			AutoButtonColor = false
		}, Content)

		Corner(Button, 8)

		Button.MouseEnter:Connect(function()
			Tween(Button, { BackgroundColor3 = Color3.fromRGB(48, 48, 56) }, 0.12)
		end)

		Button.MouseLeave:Connect(function()
			Tween(Button, { BackgroundColor3 = Color3.fromRGB(38, 38, 45) }, 0.12)
		end)

		Button.MouseButton1Down:Connect(function()
			Tween(Button, { BackgroundColor3 = Accent }, 0.08)
		end)

		Button.MouseButton1Up:Connect(function()
			Tween(Button, { BackgroundColor3 = Color3.fromRGB(48, 48, 56) }, 0.12)
		end)

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

		Button.MouseEnter:Connect(function()
			Tween(Button, { BackgroundColor3 = Color3.fromRGB(48, 48, 56) }, 0.12)
		end)

		Button.MouseLeave:Connect(function()
			Tween(Button, { BackgroundColor3 = Color3.fromRGB(38, 38, 45) }, 0.12)
		end)

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

		local function Update(Animate)
			local switchColor = Enabled and Accent or Color3.fromRGB(65, 65, 72)
			local dotPos = Enabled and UDim2.new(1, -20, 0, 2) or UDim2.fromOffset(2, 2)

			if Animate == false then
				Switch.BackgroundColor3 = switchColor
				Dot.Position = dotPos
			else
				Tween(Switch, { BackgroundColor3 = switchColor }, 0.15)
				Tween(Dot, { Position = dotPos }, 0.15, Enum.EasingStyle.Back)
			end

			if typeof(Config.Callback) == "function" then
				Config.Callback(Enabled)
			end
		end

		Button.MouseButton1Click:Connect(function()
			Enabled = not Enabled
			Update()
		end)

		Update(false)

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

		local BoxStroke = Stroke(Box, Color3.fromRGB(70, 70, 78), 1)
		BoxStroke.Transparency = 1

		Box.Focused:Connect(function()
			Tween(BoxStroke, { Transparency = 0, Color = Accent }, 0.12)
		end)

		Box.FocusLost:Connect(function()
			Tween(BoxStroke, { Transparency = 1 }, 0.12)

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


-- ============================================================
-- Riceberry UI Extended Pack
-- Extra components, animations, notifications, themes and helpers
-- ============================================================

local RB_Defaults = {
    AnimationSpeed = 0.18,
    Accent = Color3.fromRGB(180, 50, 100),
    Background = Color3.fromRGB(20, 20, 24),
    Surface = Color3.fromRGB(30, 30, 36),
    Element = Color3.fromRGB(38, 38, 45),
    Text = Color3.fromRGB(240, 240, 245),
    Muted = Color3.fromRGB(155, 155, 165),
}

local function RB_SafeCallback(callback, ...)
    if typeof(callback) ~= "function" then
        return
    end

    task.spawn(function(...)
        local ok, err = pcall(callback, ...)
        if not ok then
            warn("[Riceberry] Callback error:", err)
        end
    end, ...)
end

local function RB_MakeScale(parent)
    local scale = parent:FindFirstChildOfClass("UIScale")
    if not scale then
        scale = Instance.new("UIScale")
        scale.Scale = 1
        scale.Parent = parent
    end
    return scale
end

local function RB_PopIn(object, duration)
    local scale = RB_MakeScale(object)
    scale.Scale = 0.94
    Tween(scale, {Scale = 1}, duration or 0.2, Enum.EasingStyle.Back)
end

local function RB_Press(button)
    local scale = RB_MakeScale(button)
    Tween(scale, {Scale = 0.97}, 0.07, Enum.EasingStyle.Quad)
    task.delay(0.07, function()
        if scale.Parent then
            Tween(scale, {Scale = 1}, 0.12, Enum.EasingStyle.Back)
        end
    end)
end

local function RB_Ripple(button, position)
    local ripple = New("Frame", {
        Name = "Ripple",
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromOffset(position.X, position.Y),
        Size = UDim2.fromOffset(0, 0),
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 0.82,
        BorderSizePixel = 0,
        ZIndex = button.ZIndex + 5,
    }, button)

    Corner(ripple, 999)

    local target = math.max(button.AbsoluteSize.X, button.AbsoluteSize.Y) * 1.8
    Tween(ripple, {
        Size = UDim2.fromOffset(target, target),
        BackgroundTransparency = 1
    }, 0.42, Enum.EasingStyle.Quad)

    task.delay(0.45, function()
        if ripple.Parent then
            ripple:Destroy()
        end
    end)
end

local function RB_BindButtonFX(button)
    button.MouseEnter:Connect(function()
        if button:IsA("TextButton") or button:IsA("ImageButton") then
            Tween(button, {BackgroundColor3 = Color3.fromRGB(48, 48, 57)}, 0.12)
        end
    end)

    button.MouseLeave:Connect(function()
        if button:IsA("TextButton") or button:IsA("ImageButton") then
            Tween(button, {BackgroundColor3 = Color3.fromRGB(38, 38, 45)}, 0.16)
        end
    end)

    button.MouseButton1Down:Connect(function()
        RB_Press(button)
    end)

    button.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then
            RB_Ripple(button, Vector2.new(
                math.clamp(input.Position.X - button.AbsolutePosition.X, 0, button.AbsoluteSize.X),
                math.clamp(input.Position.Y - button.AbsolutePosition.Y, 0, button.AbsoluteSize.Y)
            ))
        end
    end)
end

function Riceberry:SetAccent(color)
    if typeof(color) ~= "Color3" then
        return
    end
    Accent = color
    self.Accent = color
end

function Riceberry:GetAccent()
    return Accent
end

function Riceberry:CreateNotification(Config)
    Config = Config or {}

    local title = Config.Title or "Riceberry"
    local message = Config.Message or ""
    local duration = Config.Duration or 3

    local holder = self.NotificationHolder

    if not holder then
        holder = New("Frame", {
            Name = "Notifications",
            AnchorPoint = Vector2.new(1, 1),
            Position = UDim2.new(1, -18, 1, -18),
            Size = UDim2.fromOffset(330, 420),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            ZIndex = 1000
        }, PlayerGui)

        local list = New("UIListLayout", {
            Padding = UDim.new(0, 8),
            HorizontalAlignment = Enum.HorizontalAlignment.Right,
            VerticalAlignment = Enum.VerticalAlignment.Bottom,
            SortOrder = Enum.SortOrder.LayoutOrder
        }, holder)

        self.NotificationHolder = holder
        self.NotificationList = list
    end

    local card = New("Frame", {
        Size = UDim2.fromOffset(310, 72),
        BackgroundColor3 = Color3.fromRGB(28, 28, 34),
        BackgroundTransparency = 0.02,
        BorderSizePixel = 0,
        ZIndex = 1001
    }, holder)

    Corner(card, 10)
    Stroke(card, Color3.fromRGB(65, 65, 74), 1)

    local bar = New("Frame", {
        Size = UDim2.fromOffset(4, 72),
        BackgroundColor3 = Config.Color or Accent,
        BorderSizePixel = 0,
        ZIndex = 1002
    }, card)

    Corner(bar, 5)

    local titleLabel = New("TextLabel", {
        Size = UDim2.new(1, -28, 0, 24),
        Position = UDim2.fromOffset(16, 8),
        BackgroundTransparency = 1,
        Text = title,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 14,
        Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 1002
    }, card)

    local messageLabel = New("TextLabel", {
        Size = UDim2.new(1, -28, 0, 34),
        Position = UDim2.fromOffset(16, 31),
        BackgroundTransparency = 1,
        Text = message,
        TextColor3 = RB_Defaults.Muted,
        TextSize = 12,
        Font = Enum.Font.Gotham,
        TextWrapped = true,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Top,
        ZIndex = 1002
    }, card)

    RB_PopIn(card, 0.22)

    task.delay(duration, function()
        if not card.Parent then
            return
        end

        local scale = RB_MakeScale(card)
        Tween(scale, {Scale = 0.92}, 0.16, Enum.EasingStyle.Quad)
        Tween(card, {BackgroundTransparency = 1}, 0.16)
        Tween(titleLabel, {TextTransparency = 1}, 0.16)
        Tween(messageLabel, {TextTransparency = 1}, 0.16)

        task.wait(0.18)
        if card.Parent then
            card:Destroy()
        end
    end)

    return card
end

function Riceberry:Notify(title, message, duration)
    return self:CreateNotification({
        Title = title,
        Message = message,
        Duration = duration
    })
end

function Riceberry:CreateTheme(Name, Theme)
    self.Themes = self.Themes or {}
    self.Themes[Name] = Theme or {}
    return self.Themes[Name]
end

function Riceberry:ApplyTheme(Name)
    if not self.Themes or not self.Themes[Name] then
        return false
    end

    local theme = self.Themes[Name]

    if theme.Accent then
        self:SetAccent(theme.Accent)
    end

    if self.Windows then
        for _, window in pairs(self.Windows) do
            if window.ApplyTheme then
                window:ApplyTheme(theme)
            end
        end
    end

    return true
end

-- Extended Window API
local RB_OriginalCreateWindow = Riceberry.CreateWindow

Riceberry.CreateWindow = function(self, Config)
    Config = Config or {}

    local Window = RB_OriginalCreateWindow(self, Config)

    self.Windows = self.Windows or {}
    table.insert(self.Windows, Window)

    Window._Components = {}
    Window._Tabs = {}
    Window._CurrentTab = nil

    function Window:CreateSection(Text)
        local section = New("TextLabel", {
            Size = UDim2.new(1, 0, 0, 28),
            BackgroundTransparency = 1,
            Text = tostring(Text or "Section"),
            TextColor3 = Accent,
            TextSize = 12,
            Font = Enum.Font.GothamBold,
            TextXAlignment = Enum.TextXAlignment.Left
        }, self.Content or nil)

        RB_PopIn(section, 0.16)
        table.insert(self._Components, section)
        return section
    end

    function Window:CreateParagraph(Config)
        Config = Config or {}

        local frame = New("Frame", {
            Size = UDim2.new(1, 0, 0, Config.Height or 68),
            BackgroundColor3 = Color3.fromRGB(34, 34, 41),
            BorderSizePixel = 0
        }, self.Content)

        Corner(frame, 9)

        local title = New("TextLabel", {
            Size = UDim2.new(1, -24, 0, 22),
            Position = UDim2.fromOffset(12, 8),
            BackgroundTransparency = 1,
            Text = Config.Title or "Info",
            TextColor3 = Color3.fromRGB(245, 245, 248),
            TextSize = 13,
            Font = Enum.Font.GothamBold,
            TextXAlignment = Enum.TextXAlignment.Left
        }, frame)

        local body = New("TextLabel", {
            Size = UDim2.new(1, -24, 1, -32),
            Position = UDim2.fromOffset(12, 30),
            BackgroundTransparency = 1,
            Text = Config.Content or "",
            TextColor3 = RB_Defaults.Muted,
            TextSize = 11,
            Font = Enum.Font.Gotham,
            TextWrapped = true,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextYAlignment = Enum.TextYAlignment.Top
        }, frame)

        RB_PopIn(frame)
        return frame
    end

    function Window:CreateDropdown(Config)
        Config = Config or {}

        local values = Config.Options or Config.Values or {}
        local selected = Config.Default or values[1]
        local opened = false

        local holder = New("Frame", {
            Size = UDim2.new(1, 0, 0, 42),
            BackgroundTransparency = 1,
            ClipsDescendants = false
        }, self.Content)

        local button = New("TextButton", {
            Size = UDim2.new(1, 0, 0, 42),
            BackgroundColor3 = RB_Defaults.Element,
            BorderSizePixel = 0,
            Text = "",
            AutoButtonColor = false
        }, holder)

        Corner(button, 8)

        local label = New("TextLabel", {
            Size = UDim2.new(1, -100, 1, 0),
            Position = UDim2.fromOffset(14, 0),
            BackgroundTransparency = 1,
            Text = Config.Name or "Dropdown",
            TextColor3 = RB_Defaults.Text,
            TextSize = 13,
            Font = Enum.Font.GothamMedium,
            TextXAlignment = Enum.TextXAlignment.Left
        }, button)

        local valueLabel = New("TextLabel", {
            Size = UDim2.fromOffset(110, 42),
            Position = UDim2.new(1, -122, 0, 0),
            BackgroundTransparency = 1,
            Text = tostring(selected or "Select"),
            TextColor3 = Accent,
            TextSize = 12,
            Font = Enum.Font.GothamBold,
            TextXAlignment = Enum.TextXAlignment.Right
        }, button)

        local arrow = New("TextLabel", {
            Size = UDim2.fromOffset(18, 42),
            Position = UDim2.new(1, -22, 0, 0),
            BackgroundTransparency = 1,
            Text = "⌄",
            TextColor3 = RB_Defaults.Muted,
            TextSize = 16,
            Font = Enum.Font.GothamBold
        }, button)

        local list = New("ScrollingFrame", {
            Size = UDim2.new(1, 0, 0, 0),
            Position = UDim2.fromOffset(0, 45),
            BackgroundColor3 = Color3.fromRGB(31, 31, 38),
            BorderSizePixel = 0,
            ScrollBarThickness = 3,
            CanvasSize = UDim2.fromOffset(0, 0),
            Visible = false,
            ZIndex = 50
        }, holder)

        Corner(list, 8)

        local layout = New("UIListLayout", {
            Padding = UDim.new(0, 3)
        }, list)

        local function refreshSize()
            local h = math.min(math.max(#values, 1) * 34 + 6, 170)
            list.CanvasSize = UDim2.fromOffset(0, #values * 34 + 6)
            return h
        end

        local function closeList()
            opened = false
            arrow.Text = "⌄"
            Tween(list, {Size = UDim2.new(1, 0, 0, 0)}, 0.14)
            task.delay(0.15, function()
                if not opened then
                    list.Visible = false
                    holder.Size = UDim2.new(1, 0, 0, 42)
                end
            end)
        end

        local function set(value)
            selected = value
            valueLabel.Text = tostring(value)
            RB_SafeCallback(Config.Callback, value)
        end

        local function rebuildOptions()
            for _, child in ipairs(list:GetChildren()) do
                if child:IsA("TextButton") then
                    child:Destroy()
                end
            end

            for _, option in ipairs(values) do
                local optionButton = New("TextButton", {
                    Size = UDim2.new(1, -8, 0, 30),
                    Position = UDim2.fromOffset(4, 0),
                    BackgroundColor3 = Color3.fromRGB(42, 42, 50),
                    BorderSizePixel = 0,
                    Text = tostring(option),
                    TextColor3 = RB_Defaults.Text,
                    TextSize = 12,
                    Font = Enum.Font.Gotham,
                    AutoButtonColor = false,
                    ZIndex = 51
                }, list)

                Corner(optionButton, 6)

                optionButton.MouseEnter:Connect(function()
                    Tween(optionButton, {BackgroundColor3 = Color3.fromRGB(55, 55, 64)}, 0.1)
                end)

                optionButton.MouseLeave:Connect(function()
                    Tween(optionButton, {BackgroundColor3 = Color3.fromRGB(42, 42, 50)}, 0.1)
                end)

                optionButton.MouseButton1Click:Connect(function()
                    set(option)
                    closeList()
                end)
            end
        end

        rebuildOptions()

        button.MouseButton1Click:Connect(function()
            opened = not opened
            local h = refreshSize()

            if opened then
                list.Visible = true
                arrow.Text = "⌃"
                holder.Size = UDim2.new(1, 0, 0, 42 + h + 3)
                Tween(list, {Size = UDim2.new(1, 0, 0, h)}, 0.18, Enum.EasingStyle.Back)
            else
                closeList()
            end
        end)

        RB_BindButtonFX(button)
        RB_PopIn(holder)

        return {
            Set = function(_, value)
                for _, option in ipairs(values) do
                    if option == value then
                        set(value)
                        return
                    end
                end
            end,
            Get = function()
                return selected
            end,
            Refresh = function(_, newValues)
                values = newValues or {}
                if selected ~= nil then
                    local stillValid = false
                    for _, option in ipairs(values) do
                        if option == selected then
                            stillValid = true
                            break
                        end
                    end
                    if not stillValid then
                        selected = values[1]
                        valueLabel.Text = tostring(selected or "Select")
                    end
                end
                rebuildOptions()
                if opened then
                    local h = refreshSize()
                    holder.Size = UDim2.new(1, 0, 0, 42 + h + 3)
                    list.Size = UDim2.new(1, 0, 0, h)
                end
            end
        }
    end

    function Window:CreateSlider(Config)
        Config = Config or {}

        local min = tonumber(Config.Min) or 0
        local max = tonumber(Config.Max) or 100
        if max < min then
            max = min
        end
        local value = math.clamp(tonumber(Config.Default) or min, min, max)
        local range = math.max(max - min, 1e-9)

        local frame = New("Frame", {
            Size = UDim2.new(1, 0, 0, 58),
            BackgroundTransparency = 1
        }, self.Content)

        local title = New("TextLabel", {
            Size = UDim2.new(1, -70, 0, 24),
            BackgroundTransparency = 1,
            Text = Config.Name or "Slider",
            TextColor3 = RB_Defaults.Text,
            TextSize = 13,
            Font = Enum.Font.GothamMedium,
            TextXAlignment = Enum.TextXAlignment.Left
        }, frame)

        local valueLabel = New("TextLabel", {
            Size = UDim2.fromOffset(65, 24),
            Position = UDim2.new(1, -65, 0, 0),
            BackgroundTransparency = 1,
            Text = tostring(value),
            TextColor3 = Accent,
            TextSize = 12,
            Font = Enum.Font.GothamBold,
            TextXAlignment = Enum.TextXAlignment.Right
        }, frame)

        -- Wider invisible hit area so the thin bar is easy to grab
        local hit = New("TextButton", {
            Size = UDim2.new(1, 0, 0, 24),
            Position = UDim2.fromOffset(0, 26),
            BackgroundTransparency = 1,
            Text = "",
            AutoButtonColor = false,
            ZIndex = 3
        }, frame)

        local bar = New("Frame", {
            Size = UDim2.new(1, 0, 0, 6),
            Position = UDim2.fromOffset(0, 9),
            BackgroundColor3 = Color3.fromRGB(55, 55, 63),
            BorderSizePixel = 0,
            ZIndex = 2
        }, hit)

        Corner(bar, 10)

        local fill = New("Frame", {
            Size = UDim2.new((value - min) / range, 0, 1, 0),
            BackgroundColor3 = Accent,
            BorderSizePixel = 0,
            ZIndex = 2
        }, bar)

        Corner(fill, 10)

        local knob = New("Frame", {
            Size = UDim2.fromOffset(16, 16),
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.new((value - min) / range, 0, 0.5, 0),
            BackgroundColor3 = Color3.fromRGB(250, 250, 250),
            BorderSizePixel = 0,
            ZIndex = 4
        }, bar)

        Corner(knob, 20)

        local dragging = false

        local function applyVisual(p, animate)
            valueLabel.Text = tostring(value)
            local size = UDim2.new(p, 0, 1, 0)
            local pos = UDim2.new(p, 0, 0.5, 0)
            if animate then
                Tween(fill, {Size = size}, 0.1)
                Tween(knob, {Position = pos}, 0.1, Enum.EasingStyle.Quad)
            else
                fill.Size = size
                knob.Position = pos
            end
        end

        local function setFromX(x, fire, animate)
            local absPos = bar.AbsolutePosition
            local absSize = bar.AbsoluteSize
            local pct = 0
            if absSize.X > 0 then
                pct = math.clamp((x - absPos.X) / absSize.X, 0, 1)
            end

            value = min + range * pct

            if Config.Rounding then
                local power = 10 ^ (tonumber(Config.Rounding) or 0)
                value = math.round(value * power) / power
            else
                value = math.round(value)
            end
            value = math.clamp(value, min, max)

            local p = (value - min) / range
            applyVisual(p, animate == true)

            if fire ~= false then
                RB_SafeCallback(Config.Callback, value)
            end
        end

        local function beginDrag(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1
                or input.UserInputType == Enum.UserInputType.Touch then
                dragging = true
                setFromX(input.Position.X, true, false)
            end
        end

        hit.InputBegan:Connect(beginDrag)
        bar.InputBegan:Connect(beginDrag)
        knob.InputBegan:Connect(beginDrag)

        local changedConn = UserInputService.InputChanged:Connect(function(input)
            if not dragging then
                return
            end
            if input.UserInputType == Enum.UserInputType.MouseMovement
                or input.UserInputType == Enum.UserInputType.Touch then
                setFromX(input.Position.X, true, false)
            end
        end)

        local endedConn = UserInputService.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1
                or input.UserInputType == Enum.UserInputType.Touch then
                dragging = false
            end
        end)

        frame.Destroying:Connect(function()
            if changedConn then
                changedConn:Disconnect()
            end
            if endedConn then
                endedConn:Disconnect()
            end
        end)

        RB_PopIn(frame)

        return {
            Set = function(_, newValue)
                value = math.clamp(tonumber(newValue) or min, min, max)
                local p = (value - min) / range
                applyVisual(p, true)
                RB_SafeCallback(Config.Callback, value)
            end,
            Get = function()
                return value
            end
        }
    end

    function Window:CreateKeybind(Config)
        Config = Config or {}

        local current = Config.Default
        local listening = false

        local button = New("TextButton", {
            Size = UDim2.new(1, 0, 0, 42),
            BackgroundColor3 = RB_Defaults.Element,
            BorderSizePixel = 0,
            Text = "",
            AutoButtonColor = false
        }, self.Content)

        Corner(button, 8)

        local label = New("TextLabel", {
            Size = UDim2.new(1, -130, 1, 0),
            Position = UDim2.fromOffset(14, 0),
            BackgroundTransparency = 1,
            Text = Config.Name or "Keybind",
            TextColor3 = RB_Defaults.Text,
            TextSize = 13,
            Font = Enum.Font.GothamMedium,
            TextXAlignment = Enum.TextXAlignment.Left
        }, button)

        local key = New("TextLabel", {
            Size = UDim2.fromOffset(105, 30),
            Position = UDim2.new(1, -115, 0.5, -15),
            BackgroundColor3 = Color3.fromRGB(50, 50, 58),
            Text = current and current.Name or "None",
            TextColor3 = Accent,
            TextSize = 11,
            Font = Enum.Font.GothamBold
        }, button)

        Corner(key, 7)

        local function updateText()
            key.Text = listening and "Press key..." or (current and current.Name or "None")
        end

        button.MouseButton1Click:Connect(function()
            listening = true
            updateText()
        end)

        local inputConn = UserInputService.InputBegan:Connect(function(input, processed)
            if listening then
                if input.UserInputType == Enum.UserInputType.Keyboard then
                    -- Escape cancels rebind without changing the key
                    if input.KeyCode == Enum.KeyCode.Escape then
                        listening = false
                        updateText()
                        return
                    end
                    current = input.KeyCode
                    listening = false
                    updateText()
                    RB_SafeCallback(Config.Changed, current)
                end
                return
            end

            if processed then
                return
            end

            if current and input.KeyCode == current then
                RB_SafeCallback(Config.Callback, current)
            end
        end)

        button.Destroying:Connect(function()
            if inputConn then
                inputConn:Disconnect()
            end
        end)

        RB_BindButtonFX(button)
        RB_PopIn(button)

        return {
            Set = function(_, keyCode)
                current = keyCode
                updateText()
            end,
            Get = function()
                return current
            end
        }
    end

    function Window:CreateDivider()
        local divider = New("Frame", {
            Size = UDim2.new(1, 0, 0, 1),
            BackgroundColor3 = Color3.fromRGB(58, 58, 66),
            BorderSizePixel = 0
        }, self.Content)

        return divider
    end

    function Window:CreateSpacer(height)
        return New("Frame", {
            Size = UDim2.new(1, 0, 0, tonumber(height) or 8),
            BackgroundTransparency = 1
        }, self.Content)
    end

    function Window:CreateIconButton(Config)
        Config = Config or {}

        local button = New("TextButton", {
            Size = UDim2.fromOffset(Config.Size or 42, Config.Size or 42),
            BackgroundColor3 = Config.Background or RB_Defaults.Element,
            BorderSizePixel = 0,
            Text = Config.Icon or "★",
            TextColor3 = Config.Color or Accent,
            TextSize = Config.TextSize or 17,
            Font = Enum.Font.GothamBold,
            AutoButtonColor = false
        }, self.Content)

        Corner(button, 9)
        Stroke(button, Color3.fromRGB(62, 62, 70), 1)
        RB_BindButtonFX(button)

        button.MouseButton1Click:Connect(function()
            RB_SafeCallback(Config.Callback)
        end)

        RB_PopIn(button)
        return button
    end

    function Window:CreateStatus(Config)
        Config = Config or {}

        local frame = New("Frame", {
            Size = UDim2.new(1, 0, 0, 38),
            BackgroundColor3 = Color3.fromRGB(34, 34, 41),
            BorderSizePixel = 0
        }, self.Content)

        Corner(frame, 8)

        local dot = New("Frame", {
            Size = UDim2.fromOffset(9, 9),
            Position = UDim2.fromOffset(12, 14),
            BackgroundColor3 = Config.Color or Color3.fromRGB(80, 200, 120),
            BorderSizePixel = 0
        }, frame)

        Corner(dot, 20)

        local label = New("TextLabel", {
            Size = UDim2.new(1, -38, 1, 0),
            Position = UDim2.fromOffset(30, 0),
            BackgroundTransparency = 1,
            Text = Config.Text or "Ready",
            TextColor3 = RB_Defaults.Text,
            TextSize = 12,
            Font = Enum.Font.GothamMedium,
            TextXAlignment = Enum.TextXAlignment.Left
        }, frame)

        local api = {}

        function api:Set(text, color)
            label.Text = text or ""
            if color then
                Tween(dot, {BackgroundColor3 = color}, 0.15)
            end
        end

        return api
    end

    function Window:CreateProgress(Config)
        Config = Config or {}

        local value = math.clamp(tonumber(Config.Default) or 0, 0, 100)

        local frame = New("Frame", {
            Size = UDim2.new(1, 0, 0, 48),
            BackgroundTransparency = 1
        }, self.Content)

        local label = New("TextLabel", {
            Size = UDim2.new(1, -60, 0, 20),
            BackgroundTransparency = 1,
            Text = Config.Name or "Progress",
            TextColor3 = RB_Defaults.Text,
            TextSize = 12,
            Font = Enum.Font.GothamMedium,
            TextXAlignment = Enum.TextXAlignment.Left
        }, frame)

        local percent = New("TextLabel", {
            Size = UDim2.fromOffset(55, 20),
            Position = UDim2.new(1, -55, 0, 0),
            BackgroundTransparency = 1,
            Text = tostring(value) .. "%",
            TextColor3 = Accent,
            TextSize = 11,
            Font = Enum.Font.GothamBold,
            TextXAlignment = Enum.TextXAlignment.Right
        }, frame)

        local bar = New("Frame", {
            Size = UDim2.new(1, 0, 0, 7),
            Position = UDim2.fromOffset(0, 30),
            BackgroundColor3 = Color3.fromRGB(55, 55, 63),
            BorderSizePixel = 0
        }, frame)

        Corner(bar, 10)

        local fill = New("Frame", {
            Size = UDim2.new(value / 100, 0, 1, 0),
            BackgroundColor3 = Accent,
            BorderSizePixel = 0
        }, bar)

        Corner(fill, 10)

        local api = {}

        function api:Set(newValue)
            value = math.clamp(tonumber(newValue) or 0, 0, 100)
            percent.Text = tostring(math.round(value)) .. "%"
            Tween(fill, {
                Size = UDim2.new(value / 100, 0, 1, 0)
            }, 0.25, Enum.EasingStyle.Quad)
        end

        function api:Get()
            return value
        end

        RB_PopIn(frame)
        return api
    end

    function Window:CreateTabs()
        local tabs = {}
        local api = {}
        local selectedTab = nil

        local bar = New("Frame", {
            Size = UDim2.new(1, 0, 0, 40),
            BackgroundTransparency = 1
        }, self.Content)

        New("UIListLayout", {
            FillDirection = Enum.FillDirection.Horizontal,
            Padding = UDim.new(0, 6)
        }, bar)

        local function selectTab(tab)
            if not tab then
                return
            end

            for _, item in ipairs(tabs) do
                item.Visible = false
                if item.Container then
                    item.Container.Visible = false
                end
                if item.Button then
                    Tween(item.Button, {
                        BackgroundColor3 = RB_Defaults.Element,
                        TextColor3 = RB_Defaults.Muted
                    }, 0.12)
                end
            end

            tab.Visible = true
            selectedTab = tab

            if tab.Container then
                tab.Container.Visible = true
            end

            if tab.Button then
                Tween(tab.Button, {
                    BackgroundColor3 = Accent,
                    TextColor3 = Color3.fromRGB(255, 255, 255)
                }, 0.15)
            end
        end

        function api:AddTab(name)
            local tab = {
                Name = name or ("Tab " .. tostring(#tabs + 1)),
                Visible = false
            }

            local button = New("TextButton", {
                Size = UDim2.fromOffset(90, 34),
                BackgroundColor3 = RB_Defaults.Element,
                BorderSizePixel = 0,
                Text = tab.Name,
                TextColor3 = RB_Defaults.Muted,
                TextSize = 11,
                Font = Enum.Font.GothamBold,
                AutoButtonColor = false
            }, bar)

            Corner(button, 8)

            button.MouseButton1Click:Connect(function()
                selectTab(tab)
            end)

            tab.Button = button
            table.insert(tabs, tab)

            -- Auto-select the first tab
            if #tabs == 1 then
                selectTab(tab)
            end

            return tab
        end

        function api:Select(name)
            for _, tab in ipairs(tabs) do
                if tab.Name == name then
                    selectTab(tab)
                    return
                end
            end
        end

        RB_PopIn(bar)
        return api
    end

    function Window:CreateToast(message)
        local winName = (Config and Config.Name) or "Riceberry"
        return Riceberry:Notify(winName, message, 2.5)
    end

    function Window:ApplyTheme(theme)
        if not theme then
            return
        end

        if theme.Accent then
            Accent = theme.Accent
        end
    end

    return Window
end

Riceberry.CreateSimpleTheme = function(self)
    self:CreateTheme("Riceberry", {
        Accent = Color3.fromRGB(180, 50, 100),
        Background = Color3.fromRGB(20, 20, 24),
        Surface = Color3.fromRGB(30, 30, 36),
        Element = Color3.fromRGB(38, 38, 45),
        Text = Color3.fromRGB(240, 240, 245),
        Muted = Color3.fromRGB(155, 155, 165)
    })

    return self
end

-- Global utility animations
function Riceberry:Animate(object, properties, duration, style, direction)
    if not object or not object.Parent then
        return
    end

    return Tween(
        object,
        properties,
        duration or 0.2,
        style or Enum.EasingStyle.Quad,
        direction or Enum.EasingDirection.Out
    )
end

function Riceberry:Pulse(object, amount, duration)
    if not object or not object.Parent then
        return
    end

    local scale = RB_MakeScale(object)
    amount = amount or 1.04
    duration = duration or 0.18

    Tween(scale, {Scale = amount}, duration, Enum.EasingStyle.Sine)
    task.delay(duration, function()
        if scale.Parent then
            Tween(scale, {Scale = 1}, duration, Enum.EasingStyle.Sine)
        end
    end)
end

function Riceberry:Shake(object, intensity, duration)
    if not object or not object.Parent then
        return
    end

    intensity = intensity or 5
    duration = duration or 0.25

    local original = object.Position

    task.spawn(function()
        local steps = 8
        for i = 1, steps do
            if not object.Parent then
                return
            end

            local decay = 1 - (i / steps)
            local x = math.random(-intensity, intensity) * decay
            local y = math.random(-intensity, intensity) * decay

            object.Position = UDim2.new(
                original.X.Scale,
                original.X.Offset + x,
                original.Y.Scale,
                original.Y.Offset + y
            )

            task.wait(duration / steps)
        end

        if object.Parent then
            object.Position = original
        end
    end)
end

Riceberry:CreateSimpleTheme()


-- Friendly short aliases
do
    local oldCreateButton = nil
    -- Aliases are attached to each Window by the extended CreateWindow wrapper.
    -- They intentionally mirror the long-form methods.
    local original = Riceberry.CreateWindow
    Riceberry.CreateWindow = function(self, Config)
        local window = original(self, Config)

        window.Button = function(selfWindow, name, callback)
            return selfWindow:CreateButton({
                Name = name,
                Callback = callback
            })
        end

        window.Toggle = function(selfWindow, name, callback, default)
            return selfWindow:CreateToggle({
                Name = name,
                Callback = callback,
                Default = default
            })
        end

        window.Textbox = function(selfWindow, placeholder, callback)
            return selfWindow:CreateTextbox({
                Placeholder = placeholder,
                Callback = callback
            })
        end

        window.Label = function(selfWindow, text)
            return selfWindow:CreateLabel(text)
        end

        window.Section = function(selfWindow, text)
            return selfWindow:CreateSection(text)
        end

        window.Dropdown = function(selfWindow, name, options, callback)
            return selfWindow:CreateDropdown({
                Name = name,
                Options = options,
                Callback = callback
            })
        end

        window.Slider = function(selfWindow, name, min, max, default, callback)
            return selfWindow:CreateSlider({
                Name = name,
                Min = min,
                Max = max,
                Default = default,
                Callback = callback
            })
        end

        window.Keybind = function(selfWindow, name, default, callback)
            return selfWindow:CreateKeybind({
                Name = name,
                Default = default,
                Callback = callback
            })
        end

        window.Divider = function(selfWindow)
            return selfWindow:CreateDivider()
        end

        window.Spacer = function(selfWindow, height)
            return selfWindow:CreateSpacer(height)
        end

        return window
    end
end

return Riceberry
