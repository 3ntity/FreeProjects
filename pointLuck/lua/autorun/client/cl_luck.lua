include("config.lua")
include("tickets.lua")

surface.CreateFont( "pl_font", { font = "Lobster 1.4", size = 25, weight = 500 } )

function LuckMenu (ply)

	local tickets = LocalPlayer():GetTickets()
	local LuckFrame = vgui.Create("DFrame")
		
		local x = 1280
		local y = 720

		local ScreenW = ScrW( ) / x
		local ScreenH = ScrH( ) / y

		LuckFrame:SetPos(300* ScreenW, 300* ScreenH)
		LuckFrame:SetSize(300* ScreenW, 200* ScreenH)
		LuckFrame:Center()
		LuckFrame:SetTitle(config.menuName)
		LuckFrame.Paint = function()
			draw.RoundedBox( 2, 0, 0, LuckFrame:GetWide(), LuckFrame:GetTall(), Color( 31,31,32 ) )
			draw.RoundedBox( 2, 0, 190* ScreenH, LuckFrame:GetWide(), LuckFrame:GetTall(), Color( 27,27,28 ) )
		end
		LuckFrame:MakePopup()

	local TabBG = vgui.Create("DPanel", LuckFrame)
		TabBG:SetPos(0, 40)
		TabBG:SetSize(320, 30)
		TabBG.Paint = function()
			draw.RoundedBox( 2, 0, 0, TabBG:GetWide(), TabBG:GetTall(), Color( 220,224,230 ) )
			draw.RoundedBox( 2, 0, 25, TabBG:GetWide(), TabBG:GetTall(), Color( 96,109,128 ) )
		end

	local TicketPrice = vgui.Create("DLabel", LuckFrame)
		TicketPrice:SetPos(105, 40)
		TicketPrice:SetText("Ticket Price: "..config.ticketPrice)
		TicketPrice:SetTextColor(Color(0,0,0))
		TicketPrice:SetFont("pl_font")
		TicketPrice:SizeToContents()


	
	local DisplayPoints = vgui.Create("DLabel", LuckFrame)
		DisplayPoints:SetPos(190, 90)
		//DisplayPoints:SetText("Points: "..LocalPlayer():PS_GetPoints())
		DisplayPoints.Think = function() DisplayPoints:SetText("Points: "..LocalPlayer():PS_GetPoints()) DisplayPoints:SizeToContents() end
		DisplayPoints:SetTextColor(Color(255,255,255))
		DisplayPoints:SetFont("pl_font")
		DisplayPoints:SizeToContents()
		
	local Tickets = vgui.Create("DLabel", LuckFrame)
		Tickets:SetPos(30, 90)
		//Tickets:SetText( "Tickets: "..tickets )
		Tickets.Think = function() Tickets:SetText("Tickets: "..tickets) Tickets:SizeToContents() end
		Tickets:SetFont("pl_font")
		Tickets:SetTextColor(Color(255,255,255))
		
		local buyTicks = vgui.Create("DButton", LuckFrame)
		buyTicks:SetPos(30, 140)
		buyTicks:SetSize(100,40)
		buyTicks:SetTextColor(Color(255,255,255))
		buyTicks:SetText("Buy A Ticket")
		buyTicks.Paint = function()
			draw.RoundedBox( 2, 0, 0, buyTicks:GetWide(), buyTicks:GetTall(), Color( 86,126,187 ) )
			draw.RoundedBox( 2, 0, 35, buyTicks:GetWide(), buyTicks:GetTall(), Color( 43,76,126 ) )
		end
		buyTicks.DoClick = function()
			if LocalPlayer():PS_GetPoints() >= config.ticketPrice then
			net.Start("TakePoints")	
			net.SendToServer()
		else
			MsgC(Color(255, 0, 0), "Not enough points! ")
		end
		
		end
	

	local useTicks = vgui.Create("DButton", LuckFrame)
		useTicks:SetPos(190, 140)
		useTicks:SetSize(100,40)
		useTicks:SetTextColor(Color(255,255,255))
		useTicks:SetText("Random Points!")
		useTicks.Paint = function()
			draw.RoundedBox( 2, 0, 0, useTicks:GetWide(), useTicks:GetTall(), Color( 231, 76, 60 ) )
			draw.RoundedBox( 2, 0, 35, useTicks:GetWide(), useTicks:GetTall(), Color( 192, 57, 43 ) )
		end
		useTicks.DoClick = function()

			if LocalPlayer():GetTickets() >= config.purchasePrice then
				net.Start("RunRandomFunction")
				net.SendToServer()

				else 
					MsgC(Color(255, 0, 0), "Not enough tickets! ")
			
				
			end
		end



end

net.Receive("NetLuckMenu", LuckMenu)

