EnvMod.Time = tonumber( EnvMod:GetCookie( "time", 6 ) )
local fTimeIncrement = EnvMod:GetTimeIncrement( EnvMod.Cfg.ServerTimeUpdateRate )

--[[

]]--

Package.Subscribe( "Load", function()
    Events.BroadcastRemote( "EnvMod:TimeUpdate", EnvMod:GetTime() )

    Timer.SetInterval( function()
        EnvMod:SetCookie( "time", math.Round( EnvMod:GetTime(), 2 ) )
    end, 1000 * 5 )
end )

--[[

    On player ready
        desc: Synchronize the current server time with the player

]]--

Player.Subscribe( "Ready", function( pPlayer )
    Events.CallRemote( "EnvMod:TimeUpdate", pPlayer, EnvMod:GetTime() )
end )

--[[

    Time update

]]--

Timer.SetInterval( function()
    EnvMod:HandleTime( fTimeIncrement )
end, ( 1000 * EnvMod.Cfg.ServerTimeUpdateRate ) )