Package.Require( "libraries/cookies.lua" )

Package.Require( "modules/timecycle.lua" )
Package.Require( "modules/day_handler.lua" )
Package.Require( "modules/weather.lua" )
Package.Require( "modules/commands.lua" )

Events.Call( "EnvMod:OnLoaded" )