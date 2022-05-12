local aWindSound = Sound( Vector(), "package///envmod/Client/resource/audio/envmod_blizzard.ogg", true, false, SoundType.SFX, 0, 1, 0, 0, 0, false, SoundLoopMode.Forever )

local tVars = {
    [ "windspeed" ] = function( xValue )
        EnvMod:UpdateParticles()

        World.SetWind( xValue * 0.01 )

        local fWindVolume = ( xValue / EnvMod._MaxWindSpeed )
        aWindSound:SetVolume( fWindVolume * 0.8 )
    end,
    -- [ "temperature" ] = function( xValue )
    --      EnvMod:SetTemperature( xValue )
    -- end,
    [ "weather" ] = function( xValue )
        EnvMod:SetWeather( xValue )
    end
}

Events.Subscribe( "EnvMod:OnNWVarChange", function( sKey, xValue )
    if sKey and tVars[ sKey ] then
        tVars[ sKey ]( xValue )
    end
end )