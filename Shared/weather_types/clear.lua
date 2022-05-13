--[[

    Weather type config

        local WEATHER = EnvMod:AddWeatherType( "Weather Name" )            -- Register a new weather type, and set it's name
        WEATHER:SetChance( 50 )                                            -- Percentage of chance to switch to this weather type (0-100)
        WEATHER:SetRain( true )
        WEATHER:SetSnow( true )
        WEATHER:SetThunder( true )

        WEATHER:SetMinTemperature( -2 )                                    -- Minimal temperture
        WEATHER:SetMaxTemperature( 16 )                                    -- Maximal temperture

        WEATHER:SetMinWind( 100 )                                          -- Minimal wind speed
        WEATHER:SetMaxWind( 300 )                                          -- Maximal wind speed

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

local WEATHER = EnvMod:AddWeatherType( "Clear" )
WEATHER:SetChance( 60 )

WEATHER:SetMinTemperature( 18 )
WEATHER:SetMaxTemperature( 42 )

WEATHER:SetMinWind( 5 )
WEATHER:SetMaxWind( 20 )

WEATHER:SetSunLightIntensity( 150 )
WEATHER:SetFogDensity( 0.005 )
WEATHER:SetFogHeightFalloff( 0.2 )
WEATHER:SetSunLightColor( Color( 1.0, 0.9, 0.8 ) )
WEATHER:SetSkyRayleighScattering( Color( 0.17, 0.41, 1.0 ) )
WEATHER:SetSunTemperatureMultiplier( 1.0 )
WEATHER:SetSkyLightIntensity( 1.0 )