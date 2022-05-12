local stringStartWith = string.StartWith
EnvMod.Commands = {}

--[[

    EnvMod:AddCommand
        desc: Register a new command

]]--

function EnvMod:AddCommand( sCmd, func, tArgs, sDesc )
    if not sCmd or ( type( sCmd ) ~= "string" ) then
        return
    end

    if not func or ( type( func ) ~= "function" ) then
        Package.Warn( "[EnvMod] Unable to register command '" .. sCmd .. "', function is missing (2nd arg)" )
        return
    end

    self.Commands[ #self.Commands + 1 ] = {
        cmd = sCmd,
        func = func,
        args = tArgs or {},
        desc = sDesc or false
    }
end

--[[ showHelp ]]--

local function showHelp()
    Package.Warn( "[EnvMod] COMMANDS LIST:" )

    local sCmds = ""
    for _, v in ipairs( EnvMod.Commands ) do
        local sArgs = " "
        if v.args then
            for i, sArg in ipairs( v.args ) do
                sArgs = sArgs .. "[" .. i .. ": " .. sArg .. "]" .. ( v.args[ i + 1 ] and ", " or "" )
            end
        end

        sCmds = sCmds .. "\n" .. string.rep( "\t", 4 ) .. " - envmod " .. v.cmd .. sArgs .. ( v.desc and ( "\n\t\t\t\t\t" .. v.desc ) or "" ) .. "\n"
    end

    Package.Log( sCmds )
end

--[[

    Console

]]--

Server.Subscribe( "Console", function( sText )
    if stringStartWith( sText, "envmod" ) then
        local tSplit = string.Split( sText, " " )
        local sCmd = tSplit[ 2 ]
        if not sCmd then
            Package.Warn( "[EnvMod] Invalid command, type `envmod help` to show all valid commands" )
            return
        end

        local tCmd = false
        for _, v in ipairs( EnvMod.Commands ) do
            if ( v.cmd == sCmd ) then
                tCmd = v
                break
            end
        end

        if tCmd then
            tCmd.func( tSplit[ 3 ] or "", tSplit[ 4 ] or "" )
        else
            Package.Warn( "[EnvMod] Invalid command, type `envmod help` to show all valid commands" )
        end
    end
end )

-----------------------------------------------------------------------
-- COMMANDS LIST
-----------------------------------------------------------------------

-- envmod help
EnvMod:AddCommand( "help", showHelp, nil, "Display the commands list" )

-- envmod gettime
EnvMod:AddCommand( "gettime", function()
    Package.Log( "[EnvMod] Current time: " .. EnvMod:GetFormattedTime( true ) )
end, nil, "Display the current time" )

-- envmod settime
EnvMod:AddCommand( "settime", function( iHours, iMinutes )
    iHours, iMinutes = tonumber( iHours ), tonumber( iMinutes )
    if not iHours then
        Package.Warn( "[EnvMod] Invalid time in `envmod settime`" )
        return
    end

    EnvMod:SetTime( ( iHours * 60 ) + ( iMinutes or 0 ) )
    Events.BroadcastRemote( "EnvMod:TimeUpdate", EnvMod:GetTime() )
end, { "hours (number)", "minutes (number)" }, "Set the current time" )

-- envmod getdate
EnvMod:AddCommand( "getdate", function()
    Package.Log( "[EnvMod] Current date: " .. EnvMod:GetFormattedDate() )
end, nil, "Display the current date" )

-- envmod getweather
EnvMod:AddCommand( "getweather", function()
    Package.Log( "[EnvMod] Current weather: " .. EnvMod:GetWeather():GetName() )
end, nil, "Display the current weather" )

-- envmod setweather
EnvMod:AddCommand( "setweather", function( xWeatherType )
    if EnvMod:SetWeather( xWeatherType ) then
        Package.Log( "[EnvMod] New weather: " .. EnvMod:GetWeather():GetName() )
    end
end, { "weather type (number/string)" }, "Set the current weather" )

-- envmod getwindspeed
EnvMod:AddCommand( "getwindspeed", function()
    Package.Log( "[EnvMod] Wind speed: " .. EnvMod:GetWindSpeed() )
end, nil, "Display the wind speed" )

-- envmod setwindspeed
EnvMod:AddCommand( "setwindspeed", function( fSpeed )
    EnvMod:SetWindSpeed( fSpeed )
    Package.Log( "[EnvMod] New wind speed: " .. EnvMod:GetWindSpeed() )
end, { "wind speed (number)" }, "Set the current wind speed" )

-- envmod getwindangle
EnvMod:AddCommand( "getwindangle", function()
    Package.Log( "[EnvMod] Wind angle: " .. EnvMod:GetWindAngle() .. "° (" .. EnvMod:GetWindDirection() .. ")" )
end, nil, "Display the wind angle" )

-- envmod setwindangle
EnvMod:AddCommand( "setwindangle", function( fAngle )
    EnvMod:SetWindAngle( fAngle )
    Package.Log( "[EnvMod] New wind angle: " .. EnvMod:GetWindAngle() )
end, { "wind direction angle (number)" }, "Set the current wind angle" )