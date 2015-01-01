AddCSLuaFile('cl_menu.lua')
AddCSLuaFile('config.lua')

include('config.lua')

util.AddNetworkString("SDSMenuKey")

//Network the f4 key to open the Donation Menu interface

hook.Add("ShowSpare2", "OpenDonationMenu", function(ply)

	if SDSConfig.AllowF4 == true then

	net.Start("SDSMenuKey")
	net.Send(ply)

	else return end

end)

resource.AddFile("resource/fonts/RobotoCondensed-Bold.ttf")

//Credit to Kamshak for this sweet helper function
function addContentFolder( path )
        local files, folders = file.Find( path .. "/*", "GAME" )
        for k, v in pairs( files ) do
                resource.AddFile( path .. "/" .. v )
        end
        
        for k, v in pairs( folders ) do
                addContent( path .. "/" .. v )
        end
end

addContentFolder("materials/donationmenu")

