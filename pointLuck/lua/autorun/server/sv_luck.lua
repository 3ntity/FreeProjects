AddCSLuaFile("cl_luck.lua")
AddCSLuaFile("config.lua")
AddCSLuaFile("tickets.lua")

include("config.lua")
include("tickets.lua")

--[[Precached messages]]--
util.AddNetworkString("NetLuckMenu")
util.AddNetworkString("TicketsNum")
util.AddNetworkString("TakePoints")
util.AddNetworkString("RunRandomFunction")
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

	net.Start("NetLuckMenu")
	net.Send(ply)

end)


--==================================================================================================================================================================--
--[[Net Receiving and Sending]]--

net.Receive("TakePoints", function(len, ply)

		local amount = config.ticketPrice
		ply:PS_TakePoints(amount)
		ply:GiveTickets(1)
	  
end)

net.Receive("RunRandomFunction", function(len, ply)

	ply:TakeTickets(config.purchasePrice)
	local HighestWinning = config.highestAmount
	local LowestWinning =  config.lowestAmount

	local random = math.random (LowestWinning, HighestWinning)

	local curPoints = ply:PS_GetPoints()

	ply:PS_SetPoints(curPoints + random)	
	 	

end)



