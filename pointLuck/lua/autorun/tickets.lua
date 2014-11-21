local meta = FindMetaTable("Player")

function meta:GetTickets()

	return self:GetNWInt("Tickets")

end

function meta:GiveTickets(amount)

	local curTicks = self:GetNWInt("Tickets")
	self:SetNWInt("Tickets", curTicks + amount )

end

function meta:TakeTickets(amount)
	
	local curTicks = self:GetNWInt("Tickets")
	self:SetNWInt("Tickets", curTicks - amount)

end

function meta:SetTickets(amount)

	self:SetNWInt("Tickets", amount)

end

