	include('autorun/config.lua')

	//Private script for SomeDayzServer
	//Not to be sold or re-distributed as yours.

	surface.CreateFont( "SDSButtonFonts", {	font = "RobotoCondensed-Bold", size = 15, weight = 1000 } )


	local function SDSdonation_Menu ()

		 	SDSFrame = vgui.Create("DFrame")
			SDSFrame:SetPos(0, 0)
			SDSFrame:SetSize(ScrW() / 4, ScrH() / 2 )
			SDSFrame:SetTitle("Donation Types")
			SDSFrame.Paint = function()
				draw.RoundedBox( 0, 0, 0, SDSFrame:GetWide(), SDSFrame:GetTall(), SDSConfig.FrameColor )
			end
			SDSFrame:Center()
			SDSFrame:SetBackgroundBlur(true)
			SDSFrame:MakePopup()

			List = vgui.Create( "DIconLayout", SDSFrame)
			List:SetSize( SDSFrame:GetWide(), SDSFrame:GetTall() / 0.25 )
			List:SetPos( SDSFrame:GetWide() * 0.065, 30 )
			List:SetSpaceY( SDSFrame:GetTall() *0.05 ) //Sets the space in between the panels on the X Axis by 5
			List:SetSpaceX( SDSFrame:GetWide() *0.07)

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--																Add Or Change Buttons HERE!!!!																
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
// To add a regular button with a label do AddDonationButton(parent, label, url)
// To add an image button do AddDontionIButton(parent, url, image)


//Edit these as you please. The url's can link to a donation page on the site with mulitple payment options!
//You NEED http:// before the web address. Don't do https:// it wont work in steam.

			AddDonationButton(List, "VIP", "http://www.somedayzserver.host22.com/") 
			AddDonationButton(List, "VIP+", "http://www.somedayzserver.host22.com/")
			AddDonationButton(List, "VIP++", "http://www.somedayzserver.host22.com/")
			AddDonationButton(List, "VIP+++", "http://www.somedayzserver.host22.com/")
			AddDonationButton(List, "$100,000", "http://www.somedayzserver.host22.com/")
			AddDonationIButton(List, "http://www.somedayzserver.host22.com/", "donationmenu/W_helicopter.png")

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--																Dont Edit Stuff Past HERE!!!														
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

		
	end


	function AddDonationButton(parent, label, url)

		local SDSDonationButton = parent:Add("DButton")
		SDSDonationButton:SetSize( SDSFrame:GetWide() / 2.5, SDSFrame:GetTall() / 4 )
		SDSDonationButton:SetText(label)
		SDSDonationButton:SetFont("SDSButtonFonts")
		SDSDonationButton:SetTextColor(SDSConfig.ButtonTextColors)
		SDSDonationButton.Paint = function(	)
			draw.RoundedBox( 0, 0, 0, SDSDonationButton:GetWide(), SDSDonationButton:GetTall(), SDSConfig.ButtonColors )
		end

		SDSDonationButton.OnCursorEntered = function()
			surface.PlaySound("ui/buttonrollover.wav")
			SDSDonationButton.Paint = function()
				draw.RoundedBox( 0, 0, 0, SDSDonationButton:GetWide(), SDSDonationButton:GetTall(), SDSConfig.HoverButtonColors )
			end
		end

		SDSDonationButton.OnCursorExited = function()
			SDSDonationButton.Paint = function()
				draw.RoundedBox( 0, 0, 0, SDSDonationButton:GetWide(), SDSDonationButton:GetTall(), SDSConfig.ButtonColors)
			end
		end

		SDSDonationButton.DoClick = function()
			surface.PlaySound("ui/buttonclick.wav")
			gui.OpenURL( url ) 
			print("Clicked!")
		end
	end

	function AddDonationIButton(parent, url, image)

			local SDSIButtonBGPanel = parent:Add("DPanel")
			SDSIButtonBGPanel:SetSize( SDSFrame:GetWide() / 2.5, SDSFrame:GetTall() / 4 )
			SDSIButtonBGPanel.Paint = function()
				draw.RoundedBox( 0, 0, 0, SDSIButtonBGPanel:GetWide(), SDSIButtonBGPanel:GetTall(), SDSConfig.ButtonColors )
			end

				SDSIButtonBGPanel.OnCursorEntered = function()
				surface.PlaySound("ui/buttonrollover.wav")
				SDSIButtonBGPanel.Paint = function()
					draw.RoundedBox( 0, 0, 0, SDSIButtonBGPanel:GetWide(), SDSIButtonBGPanel:GetTall(), SDSConfig.HoverButtonColors )
				end
			end

			SDSIButtonBGPanel.OnCursorExited = function()
				SDSIButtonBGPanel.Paint = function()
					draw.RoundedBox( 0, 0, 0, SDSIButtonBGPanel:GetWide(), SDSIButtonBGPanel:GetTall(), SDSConfig.ButtonColors)
				end
			end

			local SDSDonationIButton = vgui.Create("DImageButton", SDSIButtonBGPanel)
			SDSDonationIButton:SetSize( SDSIButtonBGPanel:GetWide() / 2, SDSIButtonBGPanel:GetTall() / 2 )
			SDSDonationIButton:SetMaterial( image ) 
			SDSDonationIButton:Center()
			SDSDonationIButton.DoClick = function()
				surface.PlaySound("ui/buttonclick.wav")
				gui.OpenURL( url ) 
				print("Clicked!")
			end

	end

	concommand.Add(SDSConfig.MenuConCommand, SDSdonation_Menu)
	net.Receive("SDSMenuKey", SDSdonation_Menu)