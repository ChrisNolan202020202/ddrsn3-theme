--[[
This script was taken from KENp's DDR X2 theme
and was recoded by FlameyBoy and Inorizushi
]]--

local x = Def.ActorFrame{

	CodeMessageCommand = function(self, params)
		if params.Name == 'Start' or params.Name == 'Center' then
			MESSAGEMAN:Broadcast("StartButton");
			SCREENMAN:GetTopScreen():Finish();
		end;
	end;

};

function LoadPlayerStuff(Player)
	
	local t = {};
	local pn = (Player == PLAYER_1) and 1 or 2;
	local strpn = tostring(pn);

	
	t[#t+1] = Def.ActorFrame {
		Name = 'BigFrame';
		LoadCard(PlayerColor(),color('1,1,1,1'),Player,true);
	};
	t[#t+1] = Def.ActorFrame {
		Name = 'SmallFrame';
		InitCommand=cmd(y,5);
		
		LoadActor( THEME:GetPathG("ScreenDataSaveSummary","MyGrooveRadarBackP1") )..{
			InitCommand=cmd(zoom,0.4;y,-2.5;);
			OnCommand=cmd(diffusealpha,0;sleep,0.9;linear,0.2;diffusealpha,1);
			OffCommand=cmd(linear,0.01;zoom,0;diffusealpha,0);
		};
		
		

	};
	
	
	t[#t+1] = LoadFont("_handelgothic bt 20px") .. {
		Name = 'SelectedProfileText';
		InitCommand=cmd(y,-48;zoom,0.6;shadowlength,0.5;diffuse,color("1,1,1,0");strokecolor,Color("Outline");maxwidth,400);
		OnCommand=cmd(sleep,0.8;linear,0.5;diffusealpha,1);
		OffCommand=cmd(stoptweening;linear,0.01;zoomy,0;diffusealpha,0);
	};
	
	t[#t+1] = LoadFont("_handelgothic bt 20px") .. {
		Name = 'SelectedProfileLevel';
		InitCommand=cmd(valign,1;x,55;y,52;zoom,0;diffuse,color("1,1,1,1");diffusebottomedge,color("0.1,1,0.1,1");strokecolor,Color("Outline");maxwidth,50);
		OnCommand=cmd(sleep,0.7;linear,0.05;diffusealpha,1;zoom,0.6);
		OffCommand=cmd(stoptweening;linear,0.1;zoomy,0;diffusealpha,0);
	};
	
t[#t+1] = LoadFont("_handelgothic bt 20px") .. {
		Name = 'selectedTotalCaloriesBurned';
		InitCommand=cmd(x,33.5;y,60;zoom,0;diffuse,color("1,1,1,1");maxwidth,350);
		OnCommand=cmd(sleep,0.9;linear,0.05;diffusealpha,1;zoomy,0.25;zoomx,0.2;);
		OffCommand=cmd(stoptweening;linear,0.1;zoomy,0;diffusealpha,0);
	};
	
t[#t+1] = LoadFont("_sveningsson Bold 60px") .. {
		Name = 'selectPlayerUID';
		InitCommand=cmd(visible,false);
	};	
	
	t[#t+1] = LoadFont("_handelgothic bt 20px") .. {
		Name = 'selectSongsPlayed';
		InitCommand=cmd(x,25;y,-56;zoom,0;diffuse,color("1,1,1,1");diffusebottomedge,color("1,1,0.1,1");strokecolor,Color("Outline");maxwidth,150);
		OnCommand=cmd(sleep,0.9;linear,0.05;diffusealpha,1;zoomy,0.3;zoomx,0.4;);
		OffCommand=cmd(stoptweening;linear,0.1;zoomy,0;diffusealpha,0);
	};
	
	t[#t+1] = Def.Sprite{
		Name = 'selectedMostSongPlayed';
		InitCommand=cmd(x,32.5;y,-16;zoom,0;scaletoclipped,20,20);
		OnCommand=cmd(sleep,1.9;linear,0.05;diffusealpha,1;diffuse,color("1,1,1,1");zoom,0.5;);
		OffCommand=cmd(stoptweening;linear,0.1;scaletoclipped,0,0;);
	};
	
	t[#t+1] = LoadActor( THEME:GetPathG("ScreenSelectProfile","LvBar") ) .. {
			Name = 'selectLvBarBack';
			InitCommand=cmd(diffusealpha,0;y,46;x,-2;zoomx,0.5;halign,1);
			OnCommand=cmd(sleep,0.3;linear,0.3;diffusealpha,1;diffuse,color("0.4,0.4,0.4,1"));
			OffCommand=cmd(stoptweening;linear,0.02;zoom,0.100;diffusealpha,0);
			
	};
	t[#t+1] = LoadActor( THEME:GetPathG("ScreenSelectProfile","LvBar") ) .. {
			Name = 'selectLvBar';
			InitCommand=cmd(diffusealpha,0;y,46;x,-2;zoomx,0.5;halign,1);
			OnCommand=cmd(sleep,0.3;linear,0.3;diffusealpha,1;);
			OffCommand=cmd(stoptweening;linear,0.02;zoom,0.100;diffusealpha,0);
			
		};

	t[#t+1]=LoadFont("_handelgothic bt 20px") .. {
		Name = 'selectTotalCalWord';
		InitCommand=cmd(x,-26;y,60;zoom,0;diffuse,color("1,1,1,1");strokecolor,Color("Outline");maxwidth,320);
		OnCommand=function(self)
			self:settext("Calories burned today:");
			(cmd(sleep,0.9;linear,0.05;diffusealpha,1;zoom,0.3))(self);
		end;
		OffCommand=cmd(stoptweening;linear,0.1;zoomy,0;diffusealpha,0);
	};
	

	t[#t+1] =LoadFont("_handelgothic bt 20px") .. {
		InitCommand=cmd(x,0;y,-83;zoom,0;diffuse,color("1,1,1,1");maxwidth,270);
		OnCommand=function(self)
			if Player== PLAYER_1 then
				self:settext("PLAYER 1");
				self:diffuse(color("#00ff30"));
			else
				self:settext("PLAYER 2");
				self:diffuse(color("#00ff30"));
			end
			(cmd(sleep,0.9;linear,0.05;diffusealpha,1;zoom,0.5))(self);
		end;
		OffCommand=cmd(stoptweening;linear,0.1;zoomy,0;diffusealpha,0);
	};	
	
	----MyGrooveRadar
	if (Player == PLAYER_1) then ---------------P1
		------New MyGrooveRadar
		if GAMESTATE:GetCurrentStyle():GetStepsType() == "StepsType_Dance_Single" then
			t[#t+1] = LoadActor( THEME:GetPathG("ScreenDataSaveSummary", "GrooveRadar" ),0,0,0,0,0,1,0,PLAYER_1)..{  --00000/Style/IsPastValue ::  Single=1 Double=2 IsPastValue=0 or 1
				Name = "GVRD1";
				InitCommand=cmd(x,0;y,5;zoom,0.56;diffusealpha,0;diffuse,Color("Yellow"));
				OnCommand=cmd(sleep,0.9;linear,0.05;diffusealpha,1;);
				OffCommand=cmd(linear,0.05;diffusealpha,0);
			};
		else
			t[#t+1] = LoadActor( THEME:GetPathG("ScreenDataSaveSummary", "GrooveRadar" ),1,0.2,0.2,0.2,0.5,2,0,PLAYER_1)..{
				Name = "GVRD1";
				InitCommand=cmd(x,0;y,5;zoom,0.56;diffusealpha,0;diffuse,Color("Yellow"));
				OnCommand=cmd(sleep,0.9;linear,0.05;diffusealpha,1;);
				OffCommand=cmd(linear,0.05;diffusealpha,0);
			};
		end
		
		--Old My Groove Radar
		if GAMESTATE:GetCurrentStyle():GetStepsType() == "StepsType_Dance_Single" then
			t[#t+1] = LoadActor( THEME:GetPathG("ScreenDataSaveSummary", "GrooveRadar" ),0,0,0,0,0,1,1,PLAYER_1)..{  --00000/Style/IsPastValue ::  Single=1 Double=2 IsPastValue=0 or 1
				Name = "GVRD1P";
				InitCommand=cmd(x,0;y,5;zoom,0.56;diffusealpha,0;diffuse,PlayerColor(PLAYER_1));
				OnCommand=cmd(sleep,0.9;linear,0.05;diffusealpha,1;);
				OffCommand=cmd(linear,0.05;diffusealpha,0);
			};
		else
			t[#t+1] = LoadActor( THEME:GetPathG("ScreenDataSaveSummary", "GrooveRadar" ),0,0,0,0,0,2,1,PLAYER_1)..{
				Name = "GVRD1P";
				InitCommand=cmd(x,0;y,5;zoom,0.56;diffusealpha,0;diffuse,PlayerColor(PLAYER_1));
				OnCommand=cmd(sleep,0.9;linear,0.05;diffusealpha,1;);
				OffCommand=cmd(linear,0.05;diffusealpha,0);
			};
		end
		
	else -----------P2
				------New MyGrooveRadar
		if GAMESTATE:GetCurrentStyle():GetStepsType() == "StepsType_Dance_Single" then
			t[#t+1] = LoadActor( THEME:GetPathG("ScreenDataSaveSummary", "GrooveRadar" ),0,0,0,0,0,1,0,PLAYER_2)..{  --00000/Style/IsPastValue ::  Single=1 Double=2 IsPastValue=0 or 1
				Name = "GVRD2";
				InitCommand=cmd(x,0;y,49.5;zoom,0.56;diffusealpha,0;diffuse,Color("Yellow"));
				OnCommand=cmd(sleep,0.9;linear,0.05;diffusealpha,1;);
				OffCommand=cmd(linear,0.05;diffusealpha,0);
			};
		else
			t[#t+1] = LoadActor( THEME:GetPathG("ScreenDataSaveSummary", "GrooveRadar" ),1,0.2,0.2,0.2,0.5,2,0,PLAYER_2)..{
				Name = "GVRD2";
				InitCommand=cmd(x,0;y,49.5;zoom,0.56;diffusealpha,0;diffuse,Color("Yellow"));
				OnCommand=cmd(sleep,0.9;linear,0.05;diffusealpha,1;);
				OffCommand=cmd(linear,0.05;diffusealpha,0);
			};
		end
		
		
		
		t[#t+1]=LoadFont("_russell square 16px") .. {
			Name = 'GVRD2Value_N1';
			InitCommand=cmd(horizalign,right;x,20+8.5;y,9;zoom,0;diffuse,color("1,1,1,1");diffusebottomedge,Color("Yellow");strokecolor,Color("Outline");maxwidth,220);
			OnCommand=cmd(sleep,0.9;linear,0.05;diffusealpha,1;zoom,0.35);
			OffCommand=cmd(stoptweening;linear,0.1;zoomy,0;diffusealpha,0);
		};
		t[#t+1]=LoadFont("_russell square 16px") .. {
			Name = 'GVRD2Value_N2';
			InitCommand=cmd(horizalign,right;x,-45+8.5;y,24;zoom,0;diffuse,color("1,1,1,1");diffusebottomedge,Color("Yellow");strokecolor,Color("Outline");maxwidth,220);
			OnCommand=cmd(sleep,0.9;linear,0.05;diffusealpha,1;zoom,0.35);
			OffCommand=cmd(stoptweening;linear,0.1;zoomy,0;diffusealpha,0);
		};
		t[#t+1]=LoadFont("_russell square 16px") .. {
			Name = 'GVRD2Value_N3';
			InitCommand=cmd(horizalign,right;x,-40+8.5;y,59;zoom,0;diffuse,color("1,1,1,1");diffusebottomedge,Color("Yellow");strokecolor,Color("Outline");maxwidth,220);
			OnCommand=cmd(sleep,0.9;linear,0.05;diffusealpha,1;zoom,0.35);
			OffCommand=cmd(stoptweening;linear,0.1;zoomy,0;diffusealpha,0);
		};
		t[#t+1]=LoadFont("_russellsquare 32px") .. {
			Name = 'GVRD2Value_N4';
			InitCommand=cmd(horizalign,right;x,40+8.5;y,59;zoom,0;diffuse,color("1,1,1,1");diffusebottomedge,Color("Yellow");strokecolor,Color("Outline");maxwidth,220);
			OnCommand=cmd(sleep,0.9;linear,0.05;diffusealpha,1;zoom,0.35);
			OffCommand=cmd(stoptweening;linear,0.1;zoomy,0;diffusealpha,0);
		};
		t[#t+1]=LoadFont("_russellsquare 32px") .. {
			Name = 'GVRD2Value_N5';
			InitCommand=cmd(horizalign,right;x,45+8.5;y,24;zoom,0;diffuse,color("1,1,1,1");diffusebottomedge,Color("Yellow");strokecolor,Color("Outline");maxwidth,220);
			OnCommand=cmd(sleep,0.9;linear,0.05;diffusealpha,1;zoom,0.35);
			OffCommand=cmd(stoptweening;linear,0.1;zoomy,0;diffusealpha,0);
		};
		
		
		--Old My Groove Radar
		if GAMESTATE:GetCurrentStyle():GetStepsType() == "StepsType_Dance_Single" then
			t[#t+1] = LoadActor( THEME:GetPathG("ScreenDataSaveSummary", "GrooveRadar" ),0,0,0,0,0,1,1,PLAYER_2)..{  --00000/Style/IsPastValue ::  Single=1 Double=2 IsPastValue=0 or 1
				Name = "GVRD2P";
				InitCommand=cmd(x,0;y,49.5;zoom,0.56;diffusealpha,0;diffuse,PlayerColor(PLAYER_2));
				OnCommand=cmd(sleep,0.9;linear,0.05;diffusealpha,1;);
				OffCommand=cmd(linear,0.05;diffusealpha,0);
			};
		else
			t[#t+1] = LoadActor( THEME:GetPathG("ScreenDataSaveSummary", "GrooveRadar" ),0,0,0,0,0,2,1,PLAYER_2)..{
				Name = "GVRD2P";
				InitCommand=cmd(x,0;y,49.5;zoom,0.56;diffusealpha,0;diffuse,PlayerColor(PLAYER_2));
				OnCommand=cmd(sleep,0.9;linear,0.05;diffusealpha,1;);
				OffCommand=cmd(linear,0.05;diffusealpha,0);
			};
		end
		t[#t+1]=LoadFont("_russell square 16px") .. {
			Name = 'GVRD2Value_O1';
			InitCommand=cmd(horizalign,right;x,20+8.5;y,9+7;zoom,0;diffuse,color("1,1,1,1");diffusebottomedge,PlayerColor(PLAYER_2);strokecolor,Color("Outline");maxwidth,220);
			OnCommand=cmd(sleep,0.9;linear,0.05;diffusealpha,1;zoom,0.35);
			OffCommand=cmd(stoptweening;linear,0.1;zoomy,0;diffusealpha,0);
		};
		t[#t+1]=LoadFont("_russell square 16px") .. {
			Name = 'GVRD2Value_O2';
			InitCommand=cmd(horizalign,right;x,-45+8.5;y,24+7;zoom,0;diffuse,color("1,1,1,1");diffusebottomedge,PlayerColor(PLAYER_2);strokecolor,Color("Outline");maxwidth,220);
			OnCommand=cmd(sleep,0.9;linear,0.05;diffusealpha,1;zoom,0.35);
			OffCommand=cmd(stoptweening;linear,0.1;zoomy,0;diffusealpha,0);
		};
		t[#t+1]=LoadFont("_russell square 16px") .. {
			Name = 'GVRD2Value_O3';
			InitCommand=cmd(horizalign,right;x,-40+8.5;y,59+7;zoom,0;diffuse,color("1,1,1,1");diffusebottomedge,PlayerColor(PLAYER_2);strokecolor,Color("Outline");maxwidth,220);
			OnCommand=cmd(sleep,0.9;linear,0.05;diffusealpha,1;zoom,0.35);
			OffCommand=cmd(stoptweening;linear,0.1;zoomy,0;diffusealpha,0);
		};
		t[#t+1]=LoadFont("_russell square 16px") .. {
			Name = 'GVRD2Value_O4';
			InitCommand=cmd(horizalign,right;x,40+8.5;y,59+7;zoom,0;diffuse,color("1,1,1,1");diffusebottomedge,PlayerColor(PLAYER_2);strokecolor,Color("Outline");maxwidth,220);
			OnCommand=cmd(sleep,0.9;linear,0.05;diffusealpha,1;zoom,0.35);
			OffCommand=cmd(stoptweening;linear,0.1;zoomy,0;diffusealpha,0);
		};
		t[#t+1]=LoadFont("_russell square 16px") .. {
			Name = 'GVRD2Value_O5';
			InitCommand=cmd(horizalign,right;x,45+8.5;y,24+7;zoom,0;diffuse,color("1,1,1,1");diffusebottomedge,PlayerColor(PLAYER_2);strokecolor,Color("Outline");maxwidth,220);
			OnCommand=cmd(sleep,0.9;linear,0.05;diffusealpha,1;zoom,0.35);
			OffCommand=cmd(stoptweening;linear,0.1;zoomy,0;diffusealpha,0);
		};
		
	end;
	
	

	return t;
end;

--Update Internal Stuff
function UpdateInternal(self, Player)
	local pn = (Player == PLAYER_1) and 1 or 2;
	local style = (GAMESTATE:GetCurrentStyle():GetStepsType() == "StepsType_Dance_Single") and "S" or "D";
	local seltext = self:GetChild('SelectedProfileText');
	local joinframe = self:GetChild('JoinFrame');
	local smallframe = self:GetChild('SmallFrame');
	local bigframe = self:GetChild('BigFrame');
	local selLevel = self:GetChild('SelectedProfileLevel');
	local selTotalCaloriesBurned = self:GetChild('selectedTotalCaloriesBurned');
	local selectRank = self:GetChild('selectRank');
	local selectPlayerUID = self:GetChild('selectPlayerUID');
	local selMostSongPlayed = self:GetChild('selectedMostSongPlayed');
	local selSongsPlayed = self:GetChild('selectSongsPlayed');
	local selLvBar = self:GetChild('selectLvBarBack');
	local selPlayerUID;
	local selGVRD = (Player == PLAYER_1) and self:GetChild('GVRD1') or self:GetChild('GVRD2');
	local selGVRDP = (Player == PLAYER_1) and self:GetChild('GVRD1P') or self:GetChild('GVRD2P');
	
	local PcntCompleteSingle = PROFILEMAN:GetProfile(Player):GetSongsAndCoursesPercentCompleteAllDifficulties('StepsType_Dance_Single');
				local PcntCompleteDouble = PROFILEMAN:GetProfile(Player):GetSongsAndCoursesPercentCompleteAllDifficulties('StepsType_Dance_Double');
				--HonorName
				
				if PcntCompleteSingle>PcntCompleteDouble then
					PcntLarger = PcntCompleteSingle;
				else 
					PcntLarger = PcntCompleteDouble;
				end
				PcntLarger = PcntLarger*100;
				
			
				local Lv = (math.ceil(math.sqrt(PROFILEMAN:GetProfile(Player):GetTotalCaloriesBurned())));
				local pcnt =((PROFILEMAN:GetProfile(Player):GetTotalCaloriesBurned())-((Lv-1)*(Lv-1))) /((Lv*Lv)-((Lv-1)*(Lv-1)));
				local totalPcnt = (PcntCompleteSingle + PcntCompleteDouble) / 2;
					--totalPcnt = PcntLarger;				
				--local pcnt =((PROFILEMAN:GetProfile(Player):GetTotalCaloriesBurned())-((Lv-1)*(Lv-1))) /((Lv*Lv)-((Lv-1)*(Lv-1)));
				bigframe:visible(true);
				seltext:settext(PROFILEMAN:GetProfile(Player):GetDisplayName());
				selLevel:settext(math.ceil(math.sqrt(PROFILEMAN:GetProfile(Player):GetTotalCaloriesBurned())) );
				selTotalCaloriesBurned:settext((math.ceil(PROFILEMAN:GetProfile(Player):GetCaloriesBurnedToday()))..' kCals.');
				selMostSongPlayed:Load(GetSongGPath(PROFILEMAN:GetProfile(Player):GetLastPlayedSong()));
				selMostSongPlayed:visible(false);
				--selSongsPlayed:settext(tostring(math.ceil(PROFILEMAN:GetProfile(Player):GetNumTotalSongsPlayed())));
				selLvBar:cropright(1-pcnt);
			
				selPlayerUID = PROFILEMAN:GetProfile(Player):GetGUID();
				
				selectPlayerUID:settext(string.upper(string.sub(selPlayerUID,1,4).."-"..string.sub(selPlayerUID,5,8)));
				local RadarFile = RageFileUtil:CreateRageFile()
	
				local selPlayerProf = PROFILEMAN:GetProfile(Player)

				local stype = GAMESTATE:GetCurrentStyle():GetStyleType()
				local style = ((stype == 'StyleType_OnePlayerTwoSides') or (stype == 'StyleType_TwoPlayersSharedSides'))
					and 'double'
					or 'single'
				
end

if GAMESTATE:IsPlayerEnabled(PLAYER_1) then
x[#x+1] = Def.ActorFrame {
			Name = 'P1Frame';
			InitCommand=cmd(x,SCREEN_CENTER_X-160;y,SCREEN_CENTER_Y+20;zoom,2);
			OnCommand=function(self)
				UpdateInternal(self, PLAYER_1);
			end;
			OffCommand=cmd();
			children = LoadPlayerStuff(PLAYER_1);
		};
end
if GAMESTATE:IsPlayerEnabled(PLAYER_2) then
x[#x+1] = Def.ActorFrame {
			Name = 'P2Frame';
			InitCommand=cmd(x,SCREEN_CENTER_X+160;y,SCREEN_CENTER_Y+20;zoom,2);
			OnCommand=function(self)
				UpdateInternal(self, PLAYER_2);
			end;
			OffCommand=cmd();
			children = LoadPlayerStuff(PLAYER_2);
		};
end


return x;