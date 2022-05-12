local tostring = tostring
local tonumber = tonumber

TYPE_BOOL = 1
TYPE_NUMBER = 2
TYPE_STRING = 3
TYPE_VECTOR = 4
TYPE_ANGLE = 5
TYPE_COLOR = 6

--[[

    ToBool
        desc: Converts any value to a boolean
        args: Value (any)
        return: Boolean (bool)

]]--

function ToBool( xVal )
    if not xVal or ( xVal == "false" ) or ( xVal == 0 ) or ( xVal == "0" ) then
        return false
    end

    return true
end

--[[

    ToColor
        desc: Converts any value to a color
        args: Value (any)
        return: Color (table)

]]--

function ToColor( xVal )
    if IsColor( xVal ) then
        return xVal
    end

    if IsVector( xVal ) then
        return Color( xVal.X, xVal.Y, xVal.Z )
    end

    xVal = tostring( xVal )

    local tColor = Color( 1, 1, 1, 1 )
	local sR, sG, sB, sA = xVal:match( "(%d+) (%d+) (%d+) (%d+)" )

	tColor.R = tonumber( sR ) or 1
	tColor.G = tonumber( sG ) or 1
	tColor.B = tonumber( sB ) or 1
	tColor.A = tonumber( sA ) or 1

	return tColor
end

--[[

    valueToType
        desc: Attempts to converts a value to a specified type
        args: Value (any)[, Type (int)]
        return: Converted value (any)

]]--

local function valueToType( xVal, iType )
    if not iType then
        return xVal
    end

    if ( iType == TYPE_NUMBER ) then return tonumber( xVal ) end
    if ( iType == TYPE_STRING ) then return tostring( xVal ) end
    if ( iType == TYPE_BOOL ) then return ToBool( xVal ) end
    if ( iType == TYPE_COLOR ) then return ToColor( xVal ) end

    return xVal
end

--[[

    AccessorFunc
        desc: Create Get/Set functions on a provided metatable
        args: Metatable (table), Function name (string), Table key (string)[, Forced type (int), Default value (any)]

]]--

function AccessorFunc( metaTable, sName, sKey, iType, xDefault )
    if not metaTable or ( type( metaTable ) ~= "table" ) or not sName or not sKey then
        return
    end

    sName = tostring( sName )

    if metaTable[ "Set" .. sName ] or metaTable[ "Get" .. sName ] then
        return
    end

    sKey = tostring( sKey )

    metaTable[ "Set" .. sName ] = function( self, xVal )
        self[ sKey ] = valueToType( xVal, iType )
        return self
    end

    metaTable[ "Get" .. sName ] = function( self )
        return ( self[ sKey ] ~= nil ) and self[ sKey ] or xDefault
    end
end

--[[

    checkTableType
        desc: Internally used function

]]--

local function checkTableType( tInput, tKeys )
    if ( type( tInput ) == "table" ) then
        for sKey, xVal in pairs( tInput ) do
            if not tKeys[ sKey ] or not ( type( xVal ) == "number" ) then
                return
            end
        end

        return true
    end
end

--[[

    isColor
        desc: Internally used function to check if a var is a color
        args: Var (any)
        return: Is color (bool)

]]--

local tColorKeys = { [ "R" ] = true, [ "G" ] = true, [ "B" ] = true, [ "A" ] = true }

function IsColor( x )
    return checkTableType( x, tColorKeys )
end

--[[

    isVector
        desc: Internally used function to check if a var is a color
        args: Var (any)
        return: Is color (bool)

]]--

local tVectorKeys = { [ "X" ] = true, [ "Y" ] = true, [ "Z" ] = true }

function IsVector( x )
    return checkTableType( x, tVectorKeys )
end