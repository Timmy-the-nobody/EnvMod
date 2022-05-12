local stringFormat = string.format

local tMonths = {
    [ 01 ] = { name = "January", days = 31 },
    [ 02 ] = { name = "February", days = 28 },
    [ 03 ] = { name = "March", days = 31 },
    [ 04 ] = { name = "April", days = 30 },
    [ 05 ] = { name = "May", days = 31 },
    [ 06 ] = { name = "June", days = 30 },
    [ 07 ] = { name = "July", days = 31 },
    [ 08 ] = { name = "August", days = 31 },
    [ 09 ] = { name = "September", days = 30 },
    [ 10 ] = { name = "October", days = 31 },
    [ 11 ] = { name = "November", days = 30 },
    [ 12 ] = { name = "December", days = 31 },
}

--[[

    EnvMod:GetDay
        desc: Get the current day
        return: Day (number)

]]--

function EnvMod:GetDay()
    return self:GetNWVar( "day", 1 )
end

--[[

    EnvMod:GetDay
        desc: Get the current day
        return: Day (number)

]]--

function EnvMod:SetDay( iDay )
    if iDay and ( type( iDay ) == "number" ) then
        self:SetNWVar( "day", math.floor( math.max( iDay, 1 ) ) )
    end
end

--[[

    EnvMod:GetDate
        desc: Get the day, month and year based on a day value
        args: [Day (number), Added years (number/internal)]
        return: Day (number), Month (number), Year (number)

]]--

function EnvMod:GetDate( iDay, iAddYears )
    iDay = math.max( ( iDay or self:GetDay() ), 1 )
    iAddYears = ( iAddYears or 0 )

    if ( iDay > 365 ) then
        iDay = ( iDay - 365 )
        return self:GetDate( iDay, ( iAddYears + 1 ) )
    end

    local iMonth, iYear = 1, ( self.Cfg.YearStart + iAddYears )

    for _, tMonth in ipairs( tMonths ) do
        if ( iDay > tMonth.days ) then
            iMonth = ( iMonth + 1 )
            iDay = iDay - tMonth.days
        else
            break
        end
    end

    return iDay, iMonth, iYear
end

--[[

    EnvMod:GetFormattedDate
        desc: Get the "clean" date
        args: [Numeric format (bool), Day (number)]
        return: Formatted date (string)

]]--

function EnvMod:GetFormattedDate( bNumeric, iDay )
    local iD, iM, iY = self:GetDate( iDay )
    local sD = stringFormat( "%02d", iD )
    local sM = bNumeric and stringFormat( "%02d", iM ) or tMonths[ iM ].name
    local sY = iY

    if EnvMod.Cfg.MMDDYYYYCalendar then
        local sSplitter = ( bNumeric and "-" or " " )
        return sM .. sSplitter .. sD .. sSplitter .. sY
    else
        local sSplitter = ( bNumeric and "/" or " " )
        return sD .. sSplitter .. sM .. sSplitter .. sY
    end
end