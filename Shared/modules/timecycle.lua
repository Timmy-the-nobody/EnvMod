EnvMod.Time = ( NanosMath.Clamp( EnvMod.Cfg.TimeOnLoad or math.random( 0, 24 ), 0, 24 ) * 60 )

local osClock = os.clock
local mathFloor = math.floor
local mathRound = math.Round
local mathClamp = NanosMath.Clamp
local stringFormat = string.format

--[[

    EnvMod:SetTime
        desc: Set the current time in minutes
        args: Time (number)

]]--

function EnvMod:SetTime( fTime )
    self.Time = mathClamp( fTime, 0, 1440 )

    if Client then
        local tWorldTime = World.GetTime()

        if ( tWorldTime.hours ~= self:GetHours() ) and ( tWorldTime.minutes ~= self:GetMinutes() ) then
            World.SetTime( self:GetHours(), self:GetMinutes() )
        end
    end
end

--[[

    EnvMod:GetTime
        desc: Internally used to manipulate the cached time
        return: Current time in IG minutes (number)

]]--

function EnvMod:GetTime()
    return self.Time
end

--[[

    EnvMod:GetHours
        desc: Used to get the current hour running
        return: Past hours in the current day (number)

]]--

function EnvMod:GetHours()
    return mathFloor( self:GetTime() / 60 )
end

--[[

    EnvMod:GetMinutes
        desc: Used to get the current minutes running
        return: Minutes running in the current hour (number)

]]--

function EnvMod:GetMinutes()
    return mathFloor( ( ( self.Time / 60 ) - self:GetHours() ) * 60 )
end

--[[

    EnvMod:GetSeconds

]]--

function EnvMod:GetSeconds()
    return mathFloor( mathRound( ( self.Time % 1 ) * 60, 2 ) )
end

--[[

    EnvMod:GetFormattedTime
        return: Formatted time, with leading "0" for minutes and seconds (string)

]]--

function EnvMod:GetFormattedTime( bReturnSeconds )
    local iHours = self:GetHours()
    local sHours = stringFormat( "%02d", iHours )
    local sSuffix = ""

    if self.Cfg.AMPMClock then
        sSuffix = " " .. ( ( iHours >= 12 ) and "PM" or "AM" )

        iHours = ( iHours % 12 )
        iHours = ( iHours == 0 ) and 12 or iHours

        sHours = stringFormat( "%02d", iHours )
    end

    local sMinutes = stringFormat( "%02d", self:GetMinutes() )
    local sSeconds = ( bReturnSeconds and ":" .. stringFormat( "%02d", self:GetSeconds() ) or "" )

    return sHours .. ":" .. sMinutes .. sSeconds .. sSuffix
end

print( EnvMod:GetFormattedTime( ) )

--[[

    EnvMod:GetNightLength
        return: Nigh duration, in IG hours (number)

]]--

function EnvMod:GetNightLength()
    return ( self.Cfg.TimeNightStart - self.Cfg.TimeDayLength )
end

--[[

    EnvMod:IsNight
        desc: Used to know if you're in a "night" cycle, based on the config
        return: Is night (bool)

]]--

local function isBetween( fVal, iMin, iMax )
    return ( ( fVal >= iMin ) and ( fVal <= iMax ) )
end

function EnvMod:IsNight()
    local iHours = self:GetHours()

    if isBetween( iHours, self.Cfg.TimeNightStart, 24 ) then
        return true
    end

    if isBetween( iHours, 0, ( self:GetNightLength() - ( 23 - self.Cfg.TimeNightStart ) ) ) then
        return true
    end
end

--[[

    EnvMod:IsDay
        desc: Used to know if you're in a "day" cycle, based on the config
        return: Is day (bool)

]]--

function EnvMod:IsDay()
    return not self:IsNight()
end

--[[

    EnvMod:GetTimeIncrement
        desc: Minutes incremented depending on the update rate, used internal but feel free to use it for whatever you need to do
        args: Update rate (number)
        return: Incremented minutes (number)

]]--

function EnvMod:GetTimeIncrement( fUpdateRate )
    return ( ( 1440 / self.Cfg.Time24hCycle ) * fUpdateRate )
end

--[[

    EnvMod:HandleTime
        desc: Manipulate the cached time

]]--

if Server then
    EnvMod.fNextBroadcast = 0
end

function EnvMod:HandleTime( fTimeIncrement )
    local bIsNight = self:IsNight()

    local fTime = ( self:GetTime() + fTimeIncrement )
    if ( fTime >= 1440 ) then
        fTime = 0

        Events.Call( "EnvMod:OnNewDayStarted", self:GetDay() )

        if Server then
            self:SetDay( self:GetDay() + 1 )
            self:SetCookie( "day", self:GetNWVar( "day" ) )
        end
    end

    self:SetTime( fTime )

    if bIsNight then
        if self:IsDay() then
            Events.Call( "EnvMod:OnDayStart" )
        end
    else
        if self:IsNight() then
            Events.Call( "EnvMod:OnNightStart" )
        end
    end

    if Server then
        if ( osClock() >= self.fNextBroadcast ) then
            self.fNextBroadcast = ( osClock() + self.Cfg.ServerTimeBroadcast )
            Events.BroadcastRemote( "EnvMod:TimeUpdate", fTime )
        end
    end
end