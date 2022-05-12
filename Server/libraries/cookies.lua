EnvMod.DB = Database( DatabaseEngine.SQLite, "db=envmod.db timeout=2" )
EnvMod.DB:ExecuteSync( "CREATE TABLE IF NOT EXISTS envmod_cookies ( cookie_key VARCHAR( 100 ) PRIMARY KEY, cookie_value VARCHAR( 100 ) )" )

--[[

    EnvMod:SetCookie

]]--

function EnvMod:SetCookie( sKey, sValue )
    self.DB:Execute( "REPLACE INTO envmod_cookies (cookie_key, cookie_value) VALUES (:1, :2);", nil, sKey, sValue )
end

--[[

    EnvMod:GetCookie

]]--

function EnvMod:GetCookie( sKey, sFallback )
    local tCookie = self.DB:SelectSync( "SELECT cookie_value FROM envmod_cookies WHERE cookie_key=:1 LIMIT 1;", sKey )[ 1 ]
    if tCookie and tCookie.cookie_value then
        return tCookie.cookie_value
    end

    return sFallback
end