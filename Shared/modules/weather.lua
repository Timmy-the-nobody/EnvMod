EnvMod._MaxWindSpeed = 300

local tonumber = tonumber
local mathAbs = math.abs

--[[

    EnvMod:SetWeather
        desc: Set a weather type
        args: Weather type (string/number)

]]--

function EnvMod:SetWeather( xWeather )
    local tNewWeather = self:GetWeatherTypeByName( xWeather )
    if not tNewWeather and tonumber( xWeather ) then
        tNewWeather = self:GetWeatherType( tonumber( xWeather ) )
    end

    -- Invalid weather type or ID
    if not tNewWeather then
        Package.Warn( "[EnvMod] Attempting to set an invalid weather type (" .. tostring( xWeather or "N/A" ) .. ")" )
        return
    end

    local iCurWeatherID, iNewWeatherID = self:GetWeatherID(), tNewWeather:GetID()
    local tOldWeather = self:GetWeatherType( iCurWeatherID )

    if tOldWeather.OnEnd then
        tOldWeather:OnEnd()
    end

    if tNewWeather.OnStart then
        tNewWeather:OnStart()
    end

    if Server then
        self:SetNWVar( "weather", iNewWeatherID )
        self:SetCookie( "weather", iNewWeatherID )

        self:UpdateTemperature()
        self:UpdateWind()
    end

    if Client then
        self:OnWeatherChangeInternal( tNewWeather, tOldWeather )
    end

    Events.Call( "EnvMod:OnWeatherChange", tNewWeather, tOldWeather )

    return true
end

--[[

    EnvMod:GetWeatherID
        desc: Get the actual weather ID
        return: Weather ID (number)

]]--

function EnvMod:GetWeatherID()
    return self:GetNWVar( "weather", 1 )
end

--[[

    EnvMod:GetWeather
        desc: Get the current weather type
        return: Weather type (table)

]]--

function EnvMod:GetWeather()
    return self:GetWeatherType( self:GetWeatherID() )
end

--[[

    EnvMod:GetWeatherType
        desc: Return a weather type and it's metatables
        return: Weather type (table)

]]--

function EnvMod:GetWeatherType( iWeatherType )
    return self:GetWeatherTypesTable()[ iWeatherType ]
end

--[[

    EnvMod:IsRaining
        return: Is raining (bool)

]]--

function EnvMod:IsRaining()
    return self:GetWeather():GetRain()
end

--[[

    EnvMod:IsSnowing
        return: Is snowing (bool)

]]--

function EnvMod:IsSnowing()
    return self:GetWeather():GetSnow()
end

--[[

    EnvMod:IsThunder
        return: Is thunder (bool)

]]--

function EnvMod:IsThunder()
    return self:GetWeather():GetThunder()
end

-----------------------------------------------------------------------
-- TEMPERATURE
-----------------------------------------------------------------------

--[[ EnvMod:CelciusToFahrenheit ]]--
function EnvMod:CelciusToFahrenheit( fTemperature ) return ( fTemperature * 1.8 ) + 32 end

--[[ EnvMod:FahrenheitToCelcius ]]--
function EnvMod:FahrenheitToCelcius( fTemperature ) return ( fTemperature - 32 ) / 1.8 end

--[[

    EnvMod:GetTemperature

]]--

function EnvMod:GetTemperature( bFahrenheit )
    local fTemperature = self:GetNWVar( "temperature", 0 )
    return bFahrenheit and self:CelciusToFahrenheit( fTemperature ) or fTemperature
end

--[[

    EnvMode:GetFormattedTemperature

]]--

function EnvMod:GetFormattedTemperature( bFahrenheit )
    local fTemperature = self:GetTemperature()
    return bFahrenheit and ( self:CelciusToFahrenheit( fTemperature ) .. "°F" ) or fTemperature .. "°C"
end

-----------------------------------------------------------------------
-- WIND
-----------------------------------------------------------------------

--[[ EnvMod:GetWindSpeed ]]--
function EnvMod:GetWindSpeed()
    return self:GetNWVar( "windspeed", 8 )
end

--[[ EnvMod:GetFormattedWindSpeed ]]--
function EnvMod:GetFormattedWindSpeed( bMPH )
    return bMPH and ( math.Round( self:GetWindSpeed() / 1.609344, 1 ) .. "MPH" ) or ( self:GetWindSpeed() .. "Km/h" )
end

--[[ EnvMod:GetWindDirection ]]--
function EnvMod:GetWindDirection()
    return self:GetNWVar( "winddirection", 0 )
end

--[[ EnvMod:GetFormattedWindDirection ]]--
local tWindDir = {
    { range = -180, dir = "S" },
    { range = -135, dir = "S/W" },
    { range = -90, dir = "W" },
    { range = -45, dir = "N/W" },
    { range = 0, dir = "N" },
    { range = 45, dir = "N/E" },
    { range = 90, dir = "E" },
    { range = 135, dir = "S/E" },
    { range = 180, dir = "S" },
}

function EnvMod:GetFormattedWindDirection()
    local fAngle = self:GetWindDirection()
    local fClosest, iClosest = 360, 1

    for i, v in ipairs( tWindDir ) do
        if ( mathAbs( fAngle - v.range ) <= fClosest ) then
            fClosest = mathAbs( fAngle - v.range )
            iClosest = i
        end
    end

    return tWindDir[ iClosest ].dir
end