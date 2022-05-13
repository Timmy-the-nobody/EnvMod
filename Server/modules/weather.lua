local mathRandom = math.random
local mathRound = math.Round

--[[

    EnvMod:UpdateTemperature
        desc: Handle temperature variations

]]--

function EnvMod:UpdateTemperature()
    local tWeather = self:GetWeather()
    local fTemperature = self:GetTemperature() + mathRandom( -5, 5 )
    local fNewTemp = NanosMath.Clamp( fTemperature, tWeather:GetMinTemperature(), tWeather:GetMaxTemperature() )

    self:SetTemperature( fNewTemp )
end

--[[

    EnvMod:UpdateTemperature
        desc: Handle wind speed and angle variations

]]--

function EnvMod:UpdateWind()
    -- Wind speed
    local tWeather = self:GetWeather()
    local fWindSpeed = self:GetWindSpeed() + mathRandom( -10, 10 )
    local fNewWindSpeed = NanosMath.Clamp( fWindSpeed, tWeather:GetMinWind(), tWeather:GetMaxWind() )

    self:SetWindSpeed( fNewWindSpeed )

    -- Wind angle
    local fWindAngle = self:GetWindDirection() + mathRandom( -25, 25 )
    self:SetWindDirection( NanosMath.NormalizeAxis( fWindAngle ) )
end

--[[

    initTimers
        desc: Init the weather and temperature timers

]]--

local function initTimers()
    -- Weather init
    local iSavedWeather = tonumber( EnvMod:GetCookie( "weather", 1 ) )
    local tWeatherTypesTable = EnvMod:GetWeatherTypesTable()

    EnvMod:SetWeather( tWeatherTypesTable[ iSavedWeather ] and iSavedWeather or 1 )

    -- Temperature update
    Timer.SetInterval( function()
        EnvMod:UpdateTemperature()
    end, ( EnvMod.Cfg.WeatherChangeDelay / EnvMod.Cfg.TemperatureUpdateFrequency ) * 1000 )

    -- Wind update
    Timer.SetInterval( function()
        EnvMod:UpdateWind()
    end, ( EnvMod.Cfg.WeatherChangeDelay / EnvMod.Cfg.WindUpdateFrequency ) * 1000 )

    -- Weather type change
    if ( #tWeatherTypesTable <= 1 ) then
        Package.Warn( "[EnvMod] Random weather is disabled (not enought weather types)" )
        return
    end

    Timer.SetInterval( function()
        local tMarked = {}
        for iWeather, tWeather in ipairs( tWeatherTypesTable ) do
            if ( mathRandom( 0, 100 ) <= tWeather.chance ) then
                tMarked[ #tMarked + 1 ] = iWeather
            end
        end

        if ( #tMarked >= 1 ) then
            EnvMod:SetWeather( tMarked[ mathRandom( 1, #tMarked ) ] )
        end
    end, ( EnvMod.Cfg.WeatherChangeDelay * 1000 ) )
end

Package.Subscribe( "Load", initTimers )

-----------------------------------------------------------------------
-- TEMPERATURE
-----------------------------------------------------------------------

--[[ EnvMod:SetTemperature ]]--
function EnvMod:SetTemperature( fTemperature, bFahrenheit )
    fTemperature = tonumber( fTemperature or 0 )
    fTemperature = mathRound( ( bFahrenheit and self:FahrenheitToCelcius( fTemperature ) or fTemperature ), 2 )

    EnvMod:SetNWVar( "temperature", fTemperature )
end

-----------------------------------------------------------------------
-- WIND
-----------------------------------------------------------------------

--[[ EnvMod:SetWindSpeed ]]--
function EnvMod:SetWindSpeed( fSpeed )
    EnvMod:SetNWVar( "windspeed", math.min( tonumber( fSpeed or 0 ), self._MaxWindSpeed ) )
end

--[[ EnvMod:SetWindDirection ]]--
function EnvMod:SetWindDirection( fAngle )
    EnvMod:SetNWVar( "winddirection", NanosMath.NormalizeAxis( tonumber( fAngle or 0 ) ) )
end