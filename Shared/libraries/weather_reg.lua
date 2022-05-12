local mt_Weather = {}
local tWeatherTypes = {}

--[[

    Weather type meta methods

]]--

-- Unique
function mt_Weather:GetID() return self.id end
function mt_Weather:GetName() return self.name end

-- Misc
AccessorFunc( mt_Weather, "Chance", "chance", TYPE_NUMBER )
AccessorFunc( mt_Weather, "Rain", "hasRain", TYPE_BOOL )
AccessorFunc( mt_Weather, "Snow", "hasSnow", TYPE_BOOL )
AccessorFunc( mt_Weather, "Thunder", "hasThunder", TYPE_BOOL )

AccessorFunc( mt_Weather, "MinTemperature", "minTemperature", TYPE_NUMBER )
AccessorFunc( mt_Weather, "MaxTemperature", "maxTemperature", TYPE_NUMBER )

AccessorFunc( mt_Weather, "MinWind", "minWind", TYPE_NUMBER )
AccessorFunc( mt_Weather, "MaxWind", "maxWind", TYPE_NUMBER )

-- World settings
AccessorFunc( mt_Weather, "FogDensity", "ws_fogDensity", TYPE_NUMBER )
AccessorFunc( mt_Weather, "FogHeightFalloff", "ws_fogHeightFalloff", TYPE_NUMBER )
AccessorFunc( mt_Weather, "SkyLightIntensity", "ws_skyLightIntensity", TYPE_NUMBER )
AccessorFunc( mt_Weather, "SkyRayleighScattering", "ws_skyRayleighScattering", TYPE_COLOR )
AccessorFunc( mt_Weather, "SunLightColor", "ws_sunLightColor", TYPE_COLOR )
AccessorFunc( mt_Weather, "SunLightIntensity", "ws_sunLightIntensity", TYPE_NUMBER )
AccessorFunc( mt_Weather, "SunTemperatureMultiplier", "ws_sunTemperatureMultiplier", TYPE_NUMBER )

--[[

    EnvMod:GetWeatherTypeByName

]]--

function EnvMod:GetWeatherTypeByName( sName )
    for _, tWeatherType in ipairs( tWeatherTypes ) do
        if ( tWeatherType:GetName() == sName ) then
            return tWeatherType
        end
    end
end

--[[

    EnvMod:AddWeatherType
        desc: Used to register a new weather type
        args: Weather name (string)
        return: Metatable containing the new weather type (table)

]]--

function EnvMod:AddWeatherType( sName )
    sName = tostring( sName or "" )

    local tExisting = self:GetWeatherTypeByName( sName )
    if tExisting then
        Package.Warn( "[EnvMod] The existing weather type '" .. sName .. "' will be overridden (name duplication)" )
        return tExisting
    end

    local tWeatherType = { id = ( #tWeatherTypes + 1 ), name = sName,
        chance = 25,
        hasRain = false,
        hasSnow = false,
        hasThunder = false,

        minTemperature = 10,
        maxTemperature = 35,

        minWind = 5,
        maxWind = 25,

        ws_fogDensity = 0.005,
        ws_fogHeightFalloff = 0.2,
        ws_skyLightIntensity = 1.0,
        ws_skyRayleighScattering = Color( 0.17, 0.41, 1.0 ),
        ws_sunLightColor = Color( 1.0, 0.9, 0.8 ),
        ws_sunLightIntensity = 150,
        ws_sunTemperatureMultiplier = 1.0
    }

    setmetatable( tWeatherType, { __index = mt_Weather } )
    tWeatherTypes[ tWeatherType.id ] = tWeatherType

    return tWeatherType
end

--[[

    EnvMod:GetWeatherTypesTable
        desc: Get a table containing all registered weather types
        return: Weather types (table)

]]--

function EnvMod:GetWeatherTypesTable()
    return tWeatherTypes
end