include("config.lua")
include("tickets.lua")

surface.CreateFont( "pl_font", { font = "Lobster 1.4", size = 25, weight = 500 } )

function LuckMenu (ply)

	local LuckFrame = vgui.Create("DFrame")
		
		LuckFrame:SetPos(75,75)
		LuckFrame:SetSize(ScrW()/ 4, ScrH() / 3)
		LuckFrame:Center()
		LuckFrame:SetTitle(config.menuName)
		LuckFrame.Paint = function()
			draw.RoundedBox( 2, 0, 0, LuckFrame:GetWide(), LuckFrame:GetTall(), Color( 31,31,32 ) )
			draw.RoundedBox( 2, 0, 0, LuckFrame:GetWide(), LuckFrame:GetTall(), Color( 27,27,28 ) )
		end
		LuckFrame:MakePopup()
		

	local TabBG = vgui.Create("DPanel", LuckFrame)
		TabBG:SetPos(LuckFrame:GetWide() / 500, LuckFrame:GetTall() / 5)
		TabBG:SetSize(LuckFrame:GetWide(), TabBG:GetTall() / 0.8)
		TabBG.Paint = function()
			draw.RoundedBox( 2, 0, 0, TabBG:GetWide(), TabBG:GetTall(), Color( 220,224,230 ) )
			draw.RoundedBox( 2, 0, TabBG:GetTall() /1.2, TabBG:GetWide(), TabBG:GetTall(), Color( 96,109,128 ) )
		end

		

	local TicketPrice = vgui.Create("DLabel", LuckFrame)
		TicketPrice:SetPos(LuckFrame:GetWide() /3.2, LuckFrame:GetTall() /5  )
		TicketPrice:SetSize(ScrW() * (1), ScrH() * (0.04) )
		TicketPrice:SetText("Ticket Price: "..config.ticketPrice)
		TicketPrice:SetTextColor(Color(0,0,0))
		TicketPrice:SetFont("pl_font")
		


	
	local DisplayPoints = vgui.Create("DLabel", LuckFrame)
		DisplayPoints:SetPos(LuckFrame:GetWide() /1.6, LuckFrame:GetTall() / 2.8)
		//DisplayPoints:SetText("Points: "..LocalPlayer():PS_GetPoints())
		DisplayPoints.Think = function() DisplayPoints:SetText("Points: "..LocalPlayer():PS_GetPoints()) DisplayPoints:SizeToContents() end
		DisplayPoints:SetTextColor(Color(255,255,255))
		DisplayPoints:SetFont("pl_font")
		DisplayPoints:SizeToContents()

		
		
	local Tickets = vgui.Create("DLabel", LuckFrame)
		Tickets:SetPos(LuckFrame:GetWide() * 0.08, LuckFrame:GetTall() / 2.8)
		//Tickets:SetText( "Tickets: "..tickets )
		Tickets.Think = function() Tickets:SetText("Tickets: "..LocalPlayer():GetTickets()) Tickets:SizeToContents() end
		Tickets:SetFont("pl_font")
		Tickets:SetTextColor(Color(255,255,255))
		
		local buyTicks = vgui.Create("DButton", LuckFrame)
		buyTicks:SetPos(LuckFrame:GetWide() * 0.08, LuckFrame:GetTall() / 1.3)
		buyTicks:SetSize(LuckFrame:GetWide() / 3.2, LuckFrame:GetTall() / 6.3)
		buyTicks:SetTextColor(Color(255,255,255))
		buyTicks:SetText("Buy A Ticket")
		buyTicks.Paint = function()
			draw.RoundedBox( 2, 0, 0, buyTicks:GetWide(), buyTicks:GetTall(), Color( 86,126,187 ) )
			draw.RoundedBox( 2, 0, buyTicks:GetTall() / 1.1, buyTicks:GetWide(), buyTicks:GetTall(), Color( 43,76,126 ) )
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
		useTicks:SetPos(LuckFrame:GetWide() /1.6 , LuckFrame:GetTall() / 1.3)
		useTicks:SetSize(LuckFrame:GetWide() / 3.2,LuckFrame:GetTall() / 6.3)
		useTicks:SetTextColor(Color(255,255,255))
		useTicks:SetText("Random Points!")
		useTicks.Paint = function()
			draw.RoundedBox( 2, 0, 0, useTicks:GetWide(), useTicks:GetTall(), Color( 231, 76, 60 ) )
			draw.RoundedBox( 2, 0, useTicks:GetTall() / 1.1, useTicks:GetWide(), useTicks:GetTall(), Color( 192, 57, 43 ) )
		end
		useTicks.DoClick = function()

			if LocalPlayer():GetTickets() >= config.purchasePrice then
				net.Start("RunRandomFunction")
				net.SendToServer()

				else 
					MsgC(Color(255, 0, 0), "Not enough tickets! ")
			
				
			end
		end

			local RandomItem = vgui.Create("DButton", LuckFrame)
		RandomItem:SetPos(LuckFrame:GetWide() /1.6 , LuckFrame:GetTall() / 2)
		RandomItem:SetSize(LuckFrame:GetWide() / 3.2,LuckFrame:GetTall() / 6.3)
		RandomItem:SetTextColor(Color(255,255,255))
		RandomItem:SetText("Random Item!")
		RandomItem.Paint = function()
			draw.RoundedBox( 2, 0, 0, RandomItem:GetWide(), RandomItem:GetTall(), Color( 231, 76, 60 ) )
			draw.RoundedBox( 2, 0, RandomItem:GetTall() / 1.1, RandomItem:GetWide(), RandomItem:GetTall(), Color( 192, 57, 43 ) )
		end
		RandomItem.DoClick = function()

			if LocalPlayer():GetTickets() >= config.purchasePrice then
				net.Start("WinAnItem")
				net.SendToServer()

				else 
					MsgC(Color(255, 0, 0), "Not enough tickets! ")
			
				
			end
		end


	local sellTicks = vgui.Create("DButton", LuckFrame)
		sellTicks:SetPos(LuckFrame:GetWide() * 0.08 , LuckFrame:GetTall() / 2)
		sellTicks:SetSize(LuckFrame:GetWide() / 3.2,LuckFrame:GetTall() / 6.3)
		sellTicks:SetTextColor(Color(255,255,255))
		sellTicks:SetText("Sell Ticket")
		sellTicks.Paint = function()
			draw.RoundedBox( 2, 0, 0, sellTicks:GetWide(), sellTicks:GetTall(), Color( 86,126,187 ) )
			draw.RoundedBox( 2, 0, sellTicks:GetTall() / 1.1, sellTicks:GetWide(), sellTicks:GetTall(), Color( 43,76,126 ) )
		end
		sellTicks.DoClick = function()

			if LocalPlayer():GetTickets() >= 1 then
				LocalPlayer():TakeTickets(1)
				net.Start("SellTicket")
				net.SendToServer()
				else 
					MsgC(Color(255, 0, 0), "Not enough tickets to sell: 1! ")
			
				
			end
		end
		



end

concommand.Add(config.conCommand, LuckMenu)

net.Receive("NetLuckMenu", LuckMenu)

