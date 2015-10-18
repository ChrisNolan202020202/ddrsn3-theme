local instructionPage = "normal"

if GAMESTATE:GetPlayMode() == 'PlayMode_Nonstop' then instructionPage = "nonstop"
elseif GAMESTATE:GetPlayMode() == 'PlayMode_Oni' then instructionPage = "oni"
end

return Def.ActorFrame{
	LoadActor(THEME:GetPathG("_instructions",instructionPage))..{
		InitCommand=cmd(x,SCREEN_CENTER_X+600;y,SCREEN_CENTER_Y);
		OnCommand=cmd(sleep,0.5;linear,1;addx,-600);
		OffCommand=cmd(sleep,1.5;linear,1;addx,-600);
	};
};