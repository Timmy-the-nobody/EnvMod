EnvMod = EnvMod or {}
EnvMod.Cfg = EnvMod.Cfg or {}

Package.Require( "libraries/includes.lua" )
Package.Require( "libraries/util.lua" )
Package.Require( "libraries/networked_vars.lua" )
Package.Require( "libraries/weather_reg.lua" )

for _, sPath in ipairs( Package.GetFiles( "Shared/weather_types", ".lua" ) ) do
    Package.Require( sPath )
end

Package.Require( "config.lua" )
Package.Require( "i18n/" .. EnvMod.Cfg.Language .. ".lua" )

Package.Require( "modules/day_handler.lua" )
Package.Require( "modules/timecycle.lua" )
Package.Require( "modules/weather.lua" )