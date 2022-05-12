--[[

    Weather type config

        local WEATHER = EnvMod:AddWeatherType( "Weather Name" )            -- Register a new weather type, and set it's name
        WEATHER:SetChance( 50 )                                            -- Percentage of chance to switch to this weather type (0-100)
        WEATHER:SetSunLightIntensity( 150 )                                -- Sun light intensity
        WEATHER:SetFogDensity( 0.005 )                                     -- Fog density
        WEATHER:SetFogHeightFalloff( 0.2 )                                 -- Fog height falloff
        WEATHER:SetSunLightColor( Color( 1.0, 0.9, 0.8 ) )                 -- Sun light color
        WEATHER:SetSkyRayleighScattering( Color( 0.17, 0.41, 1.0 ) )       -- Sky rayleigh scattering color
        WEATHER:SetSunTemperatureMultiplier( 1.0 )                         -- Sun temperature multiplier
        WEATHER:SetSkyLightIntensity( 1.0 )                                -- Sky light intensity

        function WEATHER:OnStart()                                         -- Function called on weather start
        end

        function WEATHER:OnEnd()                                           -- Function called on weather end
        end

]]--

local WEATHER = EnvMod:AddWeatherType( "Rainy" )
WEATHER:SetChance( 25 )
-- WEATHER:SetRain( true )
WEATHER:SetSnow( true )

WEATHER:SetMinTemperature( -1 )
WEATHER:SetMaxTemperature( 18 )

WEATHER:SetSunLightIntensity( 10 )
WEATHER:SetFogDensity( 0.025 )
WEATHER:SetFogHeightFalloff( 0.03 )
WEATHER:SetSunLightColor( Color( 0.82, 0.9, 1.0 ) )
WEATHER:SetSkyRayleighScattering( Color( 0.73, 0.8, 1.0 ) )
WEATHER:SetSunTemperatureMultiplier( 2 )
WEATHER:SetSkyLightIntensity( 0.3 )

function WEATHER:OnStart()
end

function WEATHER:OnEnd()
end