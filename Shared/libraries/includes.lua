--[[

    table.Copy
        desc: Copy a table and it's metatable and returns it
        args: Target (table)
        return: Copied table (table)

]]--

function table.Copy( tTarget )
    if not tTarget or ( type( tTarget ) ~= "table" ) then
        return {}
    end

    local tNew = {}
    for xKey, xVal in pairs( tTarget ) do
        tNew[ xKey ] = xVal
    end

    return setmetatable( tNew, getmetatable( tTarget ) )
end

--[[

	table.IsEmpty

]]--

function table.IsEmpty( tTarget )
    for _, _ in pairs( tTarget ) do
        return false
    end
    return true
end

--[[

	table.Count

]]--

function table.Count( tTarget )
    if table.IsEmpty( tTarget ) then
        return 0
    end

    local iCount = 0
    for _, _ in pairs( tTarget ) do
        iCount = ( iCount + 1 )
    end

    return iCount
end

--[[

    math.Round

]]--

function math.Round( fInput, iDecimals )
	local fDecimalShift = ( 10 ^ ( iDecimals or 0 ) )
    return ( math.floor( ( fInput * fDecimalShift ) + 0.5 ) / fDecimalShift )
end

--[[

	string.StartWith

]]--

function string.StartWith( sInput, sStart )
    return ( string.sub( sInput, 1, #sStart ) == sStart )
end

--[[

	string.Split

]]--

function string.Split( sInput, sSeparator )
    local tOutput = {}
    local sRegex = ( "([^%s]+)" ):format( sSeparator )

    for sVal in sInput:gmatch( sRegex ) do
        tOutput[ #tOutput + 1 ] = sVal
    end

    return tOutput
end

--[[

	string.ToColor

]]--

function string.ToColor( sInput )
	local tColor = Color( 1, 1, 1, 1 )
	local sR, sG, sB, sA = sInput:match( "(%d+) (%d+) (%d+) (%d+)" )

	tColor.R = tonumber( sR ) or 1
	tColor.G = tonumber( sG ) or 1
	tColor.B = tonumber( sB ) or 1
	tColor.A = tonumber( sA ) or 1

	return tColor
end