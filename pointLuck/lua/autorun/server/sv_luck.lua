AddCSLuaFile("cl_luck.lua")
AddCSLuaFile("config.lua")
AddCSLuaFile("tickets.lua")

include("config.lua")
include("tickets.lua")

--[[Precached messages]]--
util.AddNetworkString("NetLuckMenu")
util.AddNetworkString("TakePoints")
util.AddNetworkString("RunRandomFunction")
util.AddNetworkString("SellTicket")
util.AddNetworkString("WinAnItem")
--==============================================================================================================================================================--

hook.Add("PlayerInitialSpawn", "InitialSpawnTickets", function(ply)

	ply:GiveTickets(config.initialSpawnTickets)

end)

timer.Create("TimedCredits", 300, 0, function()

	if config.allowCredits == true then
	MsgC(Color(0,255,0), "This server is using Pointshop Luck by _Entity ")

	else
		return
	end
	

end)





--================================================================================================================================================================--
--[[Bind hooks]]--

hook.Add("ShowSpare2", "OpenLuckMenu", function (ply) 

	if config.allowF4 == true then

	net.Start("NetLuckMenu")
	net.Send(ply)

	else
		return end

end)


--==================================================================================================================================================================--
--[[Net Receiving and Sending]]--

net.Receive("TakePoints", function(len, ply)

		local amount = config.ticketPrice
		ply:PS_TakePoints(amount)
		ply:GiveTickets(1)
		ply:PS_Notify('You bought a ticket for '..config.ticketPrice..' from '..config.menuName)
	  
end)

net.Receive("RunRandomFunction", function(len, ply)

	ply:TakeTickets(config.purchasePrice)
	local HighestWinning = config.highestAmount
	local LowestWinning =  config.lowestAmount

	local random = math.random (LowestWinning, HighestWinning)

	local curPoints = ply:PS_GetPoints()

	ply:PS_SetPoints(curPoints + random)
	ply:PS_Notify('You have won '..random..' from '..config.menuName)	
	 	

end)

net.Receive("SellTicket", function(len, ply)

	ply:PS_GivePoints(config.ticketSellPrice)
	ply:PS_Notify('You have sold a ticket for '..config.ticketSellPrice)

end)

net.Receive("WinAnItem", function(len, ply)
	local item = table.Random(config.winnableItems)
	ply:PS_GiveItem(item)
	ply:PS_Notify('You have been give ', item, ' from '..config.menuName)
end)


