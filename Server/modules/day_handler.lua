--[[

    EnvMod:SetDay
        desc: Set the current day
        return: Day (number)

]]--

function EnvMod:SetDay( iDay )
    if iDay and ( type( iDay ) == "number" ) then
        self:SetNWVar( "day", math.floor( math.max( iDay, 1 ) ) )
    end
end

Package.Subscribe( "Load", function()
    EnvMod:SetDay( tonumber( EnvMod:GetCookie( "day", NanosMath.Clamp( EnvMod.Cfg.DayStart or 1, 1, 365 ) ) ) )
end )