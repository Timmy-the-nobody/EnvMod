EnvMod.NWVars = {}

local tAddEvents = {
    [ "windspeed" ] = "EnvMod:OnWindSpeedChange",
    [ "winddirection" ] = "EnvMod:OnWindDirectionChange",
    [ "temperature" ] = "EnvMod:OnTemperatureChange",
}

--[[

    EnvMod:SetNWVar

]]--

function EnvMod:SetNWVar( sKey, xValue )
    local xOld = self.NWVars[ sKey ]
    self.NWVars[ sKey ] = xValue

    if Server then
        Events.BroadcastRemote( "EnvMod:NWVarUpdate", sKey, xValue )
    end

    Events.Call( "EnvMod:OnNWVarChange", sKey, xValue, xOld )

    if tAddEvents[ sKey ] then
        Events.Call( tAddEvents[ sKey ], xValue, xOld )
    end
end

--[[

    EnvMod:GetNWVar

]]--

function EnvMod:GetNWVar( sKey, xFallback )
    return ( self.NWVars[ sKey ] ~= nil ) and self.NWVars[ sKey ] or xFallback
end

--[[ Packet transition ]]--

if Server then
    Package.Subscribe( "Load", function()
        Events.BroadcastRemote( "EnvMod:NWVarUpdateAll", JSON.stringify( EnvMod.NWVars ) )
    end )

    Player.Subscribe( "Ready", function( pPlayer )
        Events.CallRemote( "EnvMod:NWVarUpdateAll", pPlayer, JSON.stringify( EnvMod.NWVars ) )
    end )
end

if Client then
    Events.Subscribe( "EnvMod:NWVarUpdate", function( sKey, xValue )
        EnvMod:SetNWVar( sKey, xValue )
    end )

    Events.Subscribe( "EnvMod:NWVarUpdateAll", function( sJSON )
        for sKey, xValue in pairs( JSON.parse( sJSON ) ) do
            EnvMod:SetNWVar( sKey, xValue )
        end
    end )
end