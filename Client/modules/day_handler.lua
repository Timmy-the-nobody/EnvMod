local aWindSound = Sound( Vector(), "package///envmod/Client/resource/audio/envmod_blizzard.ogg", true, false, SoundType.SFX, 0, 1, 0, 0, 0, false, SoundLoopMode.Forever )


-- CANVAS
local cDebug = false
if EnvMod.Cfg.DrawDebugCanvas then
    cDebug = Canvas( true, Color.TRANSPARENT, -1 )

    local tInfos = {
        function() return "Time: " .. EnvMod:GetFormattedTime( true ) end,
        function() return "Date: " .. EnvMod:GetFormattedDate( true ) .. " [Day " .. EnvMod:GetDay() .. "]" end,
        function() return "Cycle: " .. ( EnvMod:IsDay() and "Day" or "Night" ) end,
        function() return "" end,
        function() return "Weather type: " .. EnvMod:GetWeather():GetName() .. " [" .. EnvMod:GetWeather():GetID() .. "]" end,
        function() return "Rain: " .. ( EnvMod:IsRaining() and "Yes" or "No" ) end,
        function() return "Snow: " .. ( EnvMod:IsSnowing() and "Yes" or "No" ) end,
        function() return "Thunder: " .. ( EnvMod:IsThunder() and "Yes" or "No" ) end,
        function() return "" end,
        function() return "Temperture: " .. ( EnvMod:GetFormattedTemperature() .. " [" .. EnvMod:GetFormattedTemperature( true ) ) .. "]" end,
        function() return "Wind speed: " .. EnvMod:GetFormattedWindSpeed() .. " [" .. EnvMod:GetFormattedWindSpeed( true ) .. "]" end,
        function() return "Wind direction: " .. EnvMod:GetFormattedWindDirection() .. " [" .. EnvMod:GetWindDirection() .. "°]" end
    }

    cDebug:Subscribe("Update", function( self, iW, iH )
        for k, v in ipairs( tInfos ) do
            self:DrawText( v(), Vector2D( 15, ( k * 18 ) ), FontType.Oswald )
        end
    end )

    cDebug:Repaint()
end

function EnvMod:UpdateDebugCanvas()
    if cDebug then
        cDebug:Repaint()
    end
end
-- CANVAS END


local tVars = {
    [ "windspeed" ] = function( xValue )
        EnvMod:UpdateParticles()

        World.SetWind( xValue * 0.01 )

        local fWindVolume = ( xValue / EnvMod._MaxWindSpeed )
        aWindSound:SetVolume( fWindVolume * 0.8 )

        EnvMod:UpdateDebugCanvas()
    end,
    [ "winddirection" ] = function()
        EnvMod:UpdateDebugCanvas()
    end,
    [ "temperature" ] = function( xValue )
        EnvMod:UpdateDebugCanvas()
    end,
    [ "weather" ] = function( xValue )
        EnvMod:SetWeather( xValue )
        EnvMod:UpdateDebugCanvas()
    end
}

Events.Subscribe( "EnvMod:OnNWVarChange", function( sKey, xValue )
    if sKey and tVars[ sKey ] then
        tVars[ sKey ]( xValue )
    end
end )

Events.Subscribe( "EnvMod:OnTimeChange", function()
    EnvMod:UpdateDebugCanvas()
end )