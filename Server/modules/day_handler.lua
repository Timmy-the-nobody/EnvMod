Package.Subscribe( "Load", function()
    EnvMod:SetDay( tonumber( EnvMod:GetCookie( "day", 1 ) ) )
end )