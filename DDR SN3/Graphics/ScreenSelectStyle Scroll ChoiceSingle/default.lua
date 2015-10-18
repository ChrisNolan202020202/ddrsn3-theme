local masterPlayer = GAMESTATE:GetMasterPlayerNumber() == PLAYER_1 and "P1" or "P2"
local unjoinedPlayer = GAMESTATE:GetMasterPlayerNumber() == PLAYER_1 and "P2" or "P1"

local t = Def.ActorFrame{
	-- Information panel
	LoadActor("_info")..{
		InitCommand=cmd(x,SCREEN_CENTER_X+110;y,SCREEN_CENTER_Y-75;);
		OnCommand=cmd(addx,379;sleep,0.264;decelerate,0.264;addx,-390;decelerate,0.1;addx,11);
		GainFocusCommand=cmd(visible,true;addx,-11;decelerate,0.1;addx,11);
		LoseFocusCommand=cmd(visible,false);
		OffCommand=cmd(decelerate,0.264;addx,440);
	};
	
	-- Panel
	LoadActor("_panel")..{
		InitCommand=cmd(x,SCREEN_CENTER_X-142;y,SCREEN_CENTER_Y+109;);
		OnCommand=cmd(zoom,0;diffusealpha,0;sleep,0.264;sleep,0.792;sleep,0.132;diffusealpha,1;decelerate,0.066;zoom,1;accelerate,0.066;zoom,0.8;decelerate,0.066;zoom,1);
		GainFocusCommand=cmd(stoptweening;diffusealpha,1;);
		LoseFocusCommand=cmd(stoptweening;diffusealpha,0;);
		OffCommand=cmd(sleep,0.264;accelerate,0.066;zoom,0.8;decelerate,0.066;zoom,1;accelerate,0.066;zoom,0);
	};

	-- Picture
	LoadActor("dancer"..masterPlayer)..{
		InitCommand=cmd(x,SCREEN_CENTER_X-146;y,SCREEN_CENTER_Y+108);
		BeginCommand=cmd(playcommand,"CheckNumPlayers");
		OnCommand=cmd(vertalign,bottom;draworder,90;diffusealpha,0;zoom,0;sleep,0.264;sleep,0.792;sleep,0.264;sleep,0.132;diffusealpha,1;decelerate,0.066;zoom,1;accelerate,0.066;zoom,0.8;decelerate,0.066;zoom,1);
		GainFocusCommand=cmd(diffusealpha,1);
		LoseFocusCommand=cmd(stoptweening;diffusealpha,0);
		OffCommand=cmd(sleep,0.132;accelerate,0.066;zoom,0.8;decelerate,0.066;zoom,1;accelerate,0.066;zoom,0);
		CheckNumPlayersCommand=function(self,param)
			if GAMESTATE:GetNumPlayersEnabled() > 1 then
				self:visible(false)
			end
		end;
	};
	--style
	LoadActor("style")..{
		InitCommand=cmd(x,SCREEN_CENTER_X-253;y,SCREEN_CENTER_Y+183);
		OnCommand=cmd(zoom,0;sleep,0.264;bounceend,0.264;zoom,1);
		OffCommand=cmd(bouncebegin,0.264;zoom,0);
		GainFocusCommand=cmd(bounceend,0.2;zoom,1);
		LoseFocusCommand=cmd(bouncebegin,0.2;zoom,0);
	};
};

return t;