local frame = CreateFrame("FRAME", "ComixTrapAddonFrame");
frame:RegisterEvent("UNIT_SPELLCAST_SENT");

local name = "Comix_Trap"
local path = "Interface\\AddOns\\"..name

local spell = "Trap" 

local function eventHandler(self, event, ...)
	if strfind(arg2, spell) then

		local sound = true

		--disable if user has comix/sound disabled
		local comix = (not (Comix_Hugs == nil))
		if comix and (not Comix_AddOnEnabled or not Comix_SoundEnabled) then
			sound = false
		end

		if sound then
			PlaySoundFile(path.."\\Sounds\\Trap"..math.random(1,2)..".wav")
		end
		

		if comix then
			Comix_CallPic2(path.."\\Images\\Trap.blp")
		end
	end
end

frame:SetScript("OnEvent", eventHandler);

--comix uses relative paths...
--this is ripped straight out of Comix
function Comix_CallPic2(Image, name)
	if not Comix_AddOnEnabled then
		return
	end

  if Comix_ImagesEnabled then
-- Creating x,y Coordinates --
    Comix_x_coord = math.random(-120,120)
    if Comix_x_coord <= 0 then
      Comix_x_coord = Comix_x_coord -40
    else
      Comix_x_coord= Comix_x_coord +40
    end  
 
    if (abs(Comix_x_coord)<75) then
      local y_buffer = 50 
      Comix_y_coord = math.random(y_buffer,130)
    else
      Comix_y_coord = math.random(0,130)   
    end
  
-- Finally handing over x,y Coords and the image to show --
    Comix_CurrentImage = Image
    Comix_Pic2(Comix_x_coord,Comix_y_coord,Image, name, gen)
 end
 
end

function Comix_Pic2(x,y,Pic, name)

  if Comix_ImagesEnabled then
-- Resetting Frames animation values --
    if Comix_Frames[ComixCurrentFrameCt]:IsVisible() then
      Comix_Frames[ComixCurrentFrameCt]:Hide()
    end  
    Comix_FramesStatus[ComixCurrentFrameCt] = 0
    Comix_FramesScale[ComixCurrentFrameCt] = 0.2
    Comix_FramesVisibleTime[ComixCurrentFrameCt] = 0 
   
-- Setting Texture --
	if Pic == "portrait" then
		SetPortraitTexture(Comix_textures[ComixCurrentFrameCt], name);
	else
		Comix_textures[ComixCurrentFrameCt]:SetTexture(Pic);
	end
    Comix_textures[ComixCurrentFrameCt]:SetAllPoints(Comix_Frames[ComixCurrentFrameCt]);
    Comix_Frames[ComixCurrentFrameCt].texture = Comix_textures[ComixCurrentFrameCt];
   
-- Positioning Frame --
     if Pic == "portrait" then
		Comix_Frames[ComixCurrentFrameCt]:SetPoint("Center",-150,-50);
	 else
		Comix_Frames[ComixCurrentFrameCt]:SetPoint("Center",x,y);
	end
    Comix_Frames[ComixCurrentFrameCt]:Show();

-- Increasing Current Frame or resetting it to 1 --  
    if ComixCurrentFrameCt == 5 then
      ComixCurrentFrameCt = 1
    else
      ComixCurrentFrameCt = ComixCurrentFrameCt +1
    end
  end     
end  
