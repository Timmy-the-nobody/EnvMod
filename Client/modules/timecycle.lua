local fSunSpeed = ( 86400 / EnvMod.Cfg.Time24hCycle )
local fTimeIncrement = EnvMod:GetTimeIncrement( 1 )

--[[

    Setup Nanos sun and time

]]--

Package.Subscribe( "Load", function()
    World.SpawnDefaultSun()
    World.SetSunSpeed( fSunSpeed )
    World.SetTime( EnvMod:GetHours(), EnvMod:GetMinutes() )
end )

--[[

    synchronizeTime

]]--

Events.Subscribe( "EnvMod:TimeUpdate", function( fTime )
    EnvMod:SetTime( fTime )
end )

--[[

    Time update

]]--

Timer.SetInterval( function()
    EnvMod:HandleTime( fTimeIncrement )
end, 1000 )