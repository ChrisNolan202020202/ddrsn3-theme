local function LoadMetric(name, isBoolean)
    local metricValue = THEME:GetMetric("SNDifficultyList", name)
    assert(metricValue, "SNDifficultyList: can't load metric "..name)
    --only numbers and booleans are supported right now
    if isBoolean then
        return (metricValue == "true") or (metricValue=="1")
    else
        local n = tonumber(metricValue)
        assert(n, "SNDifficultyList: metric "..name.." must be a number but is not")
        return n
    end
end

local function DiffToColor(diff, dark)
    local color = CustomDifficultyToColor(ToEnumShortString(diff))
    if dark then
        return ColorDarkTone(color)
    else
        return color
    end
end

--we need this function because we need to get the current Steps for non-human players.
--however, non-human players don't actually have a current Steps.
local function GetCurrentSteps(pn)
	if not GAMESTATE:IsHumanPlayer(pn) then
		return GAMESTATE:GetCurrentSteps(GAMESTATE:GetMasterPlayerNumber())
	end
	return GAMESTATE:GetCurrentSteps(pn)
end

local function AnyPlayerThisDiff(diff)
    for _, pn in pairs(GAMESTATE:GetEnabledPlayers()) do
        if GetCurrentSteps(pn):GetDifficulty()==diff then return true end
    end
    return false
end

local function PlayerLabelName(pn)
	local name = GAMESTATE:IsHumanPlayer(pn) and string.lower(ToEnumShortString(pn)) or "cpu"
	return 'SNDifficultyList player label '..name..' (doubleres)'
end

local difficultiesToDraw = {
    'Difficulty_Beginner',
    'Difficulty_Easy',
    'Difficulty_Medium',
    'Difficulty_Hard',
    'Difficulty_Challenge'
}

local invDifficultiesToDraw = {}
for k, v in pairs(difficultiesToDraw) do
    invDifficultiesToDraw[v] = k
end

local startPos = LoadMetric "StartPositionY"
local itemSpacingY = LoadMetric "ItemSpacingY"
local labelPos = LoadMetric "LabelPositionX"
local tickPos = LoadMetric "TickPositionX"
local glowFeet = LoadMetric("GlowIfMeterAbove10", true)
local indWidth = LoadMetric "IndicatorWidth"
local indX = LoadMetric "IndicatorX"
local plabelX = LoadMetric "PlayerLabelXOffset"

local lastSong = nil
local lastSteps = {PlayerNumber_P1=nil, PlayerNumber_P2=nil}

local function DiffToYPos(diff)
    if invDifficultiesToDraw[diff] == nil then return nil end
    return startPos + ( itemSpacingY*( invDifficultiesToDraw[diff]-1 ) )
end

local function SetXFromPlayerNumber(that, pn)
    if pn == 'PlayerNumber_P1' then
        that:x(indX-(indWidth/2)-plabelX)
    elseif pn == 'PlayerNumber_P2' then
        that:x(indX+(indWidth/2)+plabelX)
    end
end

local function Update(self, _)
    if GAMESTATE then
        local song = GAMESTATE:GetCurrentSong()
        local steps = {}
        local anyStepsChanged = false
        for _, pn in pairs(GAMESTATE:GetEnabledPlayers()) do
            steps[pn] = GetCurrentSteps(pn)
            if steps[pn] ~= lastSteps[pn] then anyStepsChanged = true break end
        end
        local songChanged = song~=lastSong
        if songChanged or anyStepsChanged then
            MESSAGEMAN:Broadcast("SNDLUpdate", {SongChanged=songChanged, StepsChanged=anyStepsChanged})
        end
        lastSong = song
        lastSteps = steps
    end
end

local ret = Def.ActorFrame{InitCommand=function(self) self:xy(SCREEN_LEFT+120,SCREEN_CENTER_Y+90):hibernate(1.25):SetUpdateFunction(Update) end,
    OffCommand=function(self) self:sleep(0.5):visible(false) end}

for _, pn in pairs(PlayerNumber) do
    local indicator = Def.ActorFrame{
        Name='Indicator'..pn,
        InitCommand=function(self) self:visible(false) end,
        SNDLUpdateMessageCommand=function(self)
			if not GAMESTATE:IsPlayerEnabled(pn) then return end
            self:finishtweening()
            local currentlyVisible = self:GetVisible()
            local steps = GetCurrentSteps(pn)
            if steps and GAMESTATE:GetCurrentSong() then
                if currentlyVisible then
                    self:linear(0.1)
                end
                local yPos = DiffToYPos(steps:GetDifficulty())
                if yPos then
                    self:visible(true)
                    self:y(yPos)
                    return
                end
            end
            self:visible(false)
        end,
        Def.Quad{
            Name='Background',
            InitCommand=function(self) self:diffuse{0,0,0,0.5}:zoomx(indWidth):zoomy(itemSpacingY):x(indX) end,
        },
        Def.Sprite{
            Name='PlayerLabel',
            Texture=PlayerLabelName(pn),
            InitCommand=function(self) SetXFromPlayerNumber(self:draworder(1000), pn) end,
			PlayerJoinedMessageCommand=function(self,p) 
				if p.Player==pn then self:Load(ResolveRelativePath(PlayerLabelName(pn),1)) end
			end
        }
    }
    table.insert(ret, indicator)
end


for idx, diff in pairs(difficultiesToDraw) do
    local element = Def.ActorFrame{
        Name = "Row"..diff,
        SNDLUpdateMessageCommand = function(self) for _, item in pairs(self:GetChildren()) do item:playcommand("Update") end end,
        InitCommand = function(self) self:y( DiffToYPos(diff) ) end,
        Def.Sprite{
            Name = "Label",
            Texture = "SNDifficultyList labels 1x5 (doubleres).png",
            InitCommand = function(self) self:setstate(idx-1):SetAllStateDelays(math.huge):x(labelPos):diffuse{0.5,0.5,0.5,1} end,
            SNDLUpdateMessageCommand=function(self)
                local song = GAMESTATE:GetCurrentSong()
                if song then
                    if AnyPlayerThisDiff(diff) then
                        self:diffuse(DiffToColor(diff))                        
                    elseif song:HasStepsTypeAndDifficulty(GAMESTATE:GetCurrentStyle():GetStepsType(), diff) then
                        self:diffuse{1,1,1,1}
                    else
                        self:diffuse{0.5,0.5,0.5,1}
                    end
                else
                    self:diffuse{0.5,0.5,0.5,1}
                end
            end
        },
        Def.Sprite{
            Name = "TicksBright",
            Texture = "ticks",
            InitCommand = function(self) self:x(tickPos-80):diffuse(DiffToColor(diff)):halign(0):cropright(1):draworder(2) end,
            SNDLUpdateMessageCommand=function(self, params)
                local song = GAMESTATE:GetCurrentSong()
                if song then
                    if params.SongChanged then self:stopeffect() end
                    local steps = song:GetOneSteps(GAMESTATE:GetCurrentStyle():GetStepsType(), diff)
                    if steps then
                        local meter = steps:GetMeter()
                        if meter > 10 then
                            self:cropright(0):glowshift():effectcolor1(DiffToColor(diff)):effectcolor2(color "#FFFFFF")
                        else
                            self:stopeffect():cropright(1-meter/10)
                        end
                    else
                        self:stopeffect():cropright(1)
                    end
                else
                    self:stopeffect():cropright(1)
                end
            end,
        },
        Def.Sprite{
            Name="TicksDark",
            Texture="ticks",
            InitCommand = function(self) self:x(tickPos-5):diffuse(DiffToColor(diff,true)):draworder(1) end,
        }
    }
    table.insert(ret, element)
end

return ret
