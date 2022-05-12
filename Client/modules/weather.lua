local fTransitionSpeed = ( EnvMod.Cfg.WeatherTransitionSpeed or 0.5 )
local onTickTransition = false

local World = World
local Vector = Vector

local lerp = NanosMath.FInterpTo
local lerpVector = NanosMath.VInterpTo

local IsColor = IsColor
local ToColor = ToColor
local copyTable = table.Copy
local stringSub = string.sub
local type = type

--[[

    World settings

]]--

local tApplySetting = {
    [ "ws_sunLightIntensity" ]         = function( fVal ) World.SetSunLightIntensity( fVal ) end,
    [ "ws_fogDensity" ]                = function( fVal ) World.SetFogDensity( fVal, 0 ) end,
    [ "ws_fogHeightFalloff" ]          = function( fVal ) World.SetFogHeightFalloff( fVal ) end,
    [ "ws_sunLightColor" ]             = function( vCol ) World.SetSunLightColor( ToColor( vCol ) ) end,
    [ "ws_skyRayleighScattering" ]     = function( vCol ) World.SetSkyRayleighScattering( ToColor( vCol ) ) end,
    [ "ws_sunTemperatureMultiplier" ]  = function( fVal ) World.SetSunTemperatureMultiplier( fVal ) end,
    [ "ws_skyLightIntensity" ]         = function( fVal ) World.SetSkyLightIntensity( fVal ) end,
    -- [ "ws_wind" ]                      = function( fVal ) World.SetWind( fVal ) end
}

--[[

    copyWorldSettings
        desc: Copy only world settings from a weather type

]]--

local function copyWorldSettings( tWeatherType )
    local tNew = {}
    for sKey, xVal in pairs( tWeatherType ) do
        if ( stringSub( sKey, 1, 3 ) == "ws_" ) then
            if IsColor( xVal ) then
                tNew[ sKey ] = Vector( xVal.R, xVal.G, xVal.B )
            else
                if ( type( xVal ) == "number" ) then
                    tNew[ sKey ] = xVal
                end
            end
        end
    end

    return tNew
end

--[[

    doWeatherTransition
        desc: Performs the weather transition to the next weather type

]]--

local tWeatherCurrent = copyWorldSettings( EnvMod:GetWeather() )
local tWeatherTarget = copyTable( tWeatherCurrent )

local function doWeatherTransition( iNewWeather )
    tWeatherTarget = copyWorldSettings( EnvMod:GetWeatherType( iNewWeather ) )

    if onTickTransition then
        Client.Unsubscribe( "Tick", onTickTransition )
    end

    local fTransitionProg = 0

    onTickTransition = Client.Subscribe( "Tick", function( fDelta )
        fTransitionProg = lerp( fTransitionProg, 100, fDelta, fTransitionSpeed )

        for sKey, xValue in pairs( tWeatherCurrent ) do
            if tApplySetting[ sKey ] then
                if ( type( xValue ) == "number" ) then
                    tWeatherCurrent[ sKey ] = lerp( xValue, tWeatherTarget[ sKey ], fDelta, fTransitionSpeed )
                else
                    tWeatherCurrent[ sKey ] = lerpVector( xValue, tWeatherTarget[ sKey ], fDelta, fTransitionSpeed )
                end

                tApplySetting[ sKey ]( tWeatherCurrent[ sKey ] )
            end
        end

        if ( fTransitionProg >= 99.5 ) then
            for sKey, _ in pairs( tWeatherCurrent ) do
                if tApplySetting[ sKey ] then
                    tWeatherCurrent[ sKey ] = tWeatherTarget[ sKey ]
                    tApplySetting[ sKey ]( tWeatherCurrent[ sKey ] )
                end
            end

            Client.Unsubscribe( "Tick", onTickTransition )
            onTickTransition = false
        end
    end )
end

--[[

    EnvMod:OnWeatherChangeInternal

]]--

local tWeatherFX = {
    [ "Rain" ] = {
        soundPath = "package///envmod/Client/resource/audio/envmod_rain.ogg",
        soundVolume = 0.5,
        particle = "envmod-assets::NS_Rain",
        particleZGravity = -2000,
        particleMaxAngularGravity = 20000
    },
    [ "Snow" ] = {
        soundPath = "package///envmod/Client/resource/audio/envmod_snow.ogg",
        soundVolume = 0.5,
        particle = "envmod-assets::NS_Snow",
        particleZGravity = -400,
        particleMaxAngularGravity = 300
    },
    [ "Thunder" ] = {
        soundPath = "package///envmod/Client/resource/audio/envmod_thunder.ogg",
        soundVolume = 0.5,
    },
}

local tActiveSounds = {}
local tActiveParticles = {}

local fNextPosUpdate = 0
local particlesPosTick = false

function EnvMod:OnWeatherChangeInternal( tNewWeather, tOldWeather )
    doWeatherTransition( tNewWeather:GetID() )

    for sFunc, tFX in pairs( tWeatherFX ) do
        if tNewWeather[ "Get" .. sFunc ]( tNewWeather ) then
            -- Add sound
            if tFX.soundPath then
                if not tActiveSounds[ sFunc ] or not tActiveSounds[ sFunc ]:IsValid() then
                    tActiveSounds[ sFunc ] = Sound( Vector(), tFX.soundPath, true, false, SoundType.SFX, ( tFX.soundVolume or 1 ), 1, 0, 0, 0, false, SoundLoopMode.Forever )
                else
                    if not tActiveSounds[ sFunc ]:IsPlaying() then
                        tActiveSounds[ sFunc ]:FadeIn( 3, 1, 0 )
                    end
                end
            end

            -- Add particle
            if tFX.particle then
                if not tActiveParticles[ sFunc ] or not tActiveParticles[ sFunc ]:IsValid() then
                    tActiveParticles[ sFunc ] = Particle( Client.GetLocalPlayer():GetCameraLocation(), Rotator(), tFX.particle, false, true )
                    tActiveParticles[ sFunc ]:SetValue( "ZGravity", tFX.particleZGravity )
                    tActiveParticles[ sFunc ]:SetValue( "MaxAngularGravity", tFX.particleMaxAngularGravity )
                    --tActiveParticles[ sFunc ]:SetParameterFloat( "SpawnRate", 250000 )

                    if not particlesPosTick then
                        particlesPosTick = Client.Subscribe( "Tick", function( fDelta )
                            if ( os.clock() > fNextPosUpdate ) then
                                for _, eParticle in pairs( tActiveParticles ) do
                                    eParticle:SetLocation( Client.GetLocalPlayer():GetCameraLocation() )
                                    fNextPosUpdate = ( os.clock() + 0.1 )
                                end
                            end
                        end )
                    end
                end
            end
        else
            -- Clear sound
            if tActiveSounds[ sFunc ] and tActiveSounds[ sFunc ]:IsValid() then
                tActiveSounds[ sFunc ]:FadeOut( 3, 0, true )
            end

            -- Clear particle
            if tActiveParticles[ sFunc ] and tActiveParticles[ sFunc ]:IsValid() then
                tActiveParticles[ sFunc ]:Deactivate()

                Timer.SetTimeout( function()
                    if tActiveParticles[ sFunc ] and tActiveParticles[ sFunc ]:IsValid() then
                        tActiveParticles[ sFunc ]:Destroy()
                        tActiveParticles[ sFunc ] = nil
                    end
                end, 5000 )
            end
        end
    end

    EnvMod:UpdateParticles()
end

--[[

    EnvMod:UpdateParticles

]]--

function EnvMod:UpdateParticles()
    local fWindSpeed = self:GetWindSpeed()
    local tWindDir = Rotator( 0, self:GetWindDirection(), 0 )

    for _, eParticle in pairs( tActiveParticles ) do
        local tWindForward = tWindDir:GetForwardVector() * ( fWindSpeed * ( eParticle:GetValue( "MaxAngularGravity", 0 ) / self._MaxWindSpeed ) )
        tWindForward.Z = eParticle:GetValue( "ZGravity", -400 )

        eParticle:SetParameterVector( "Gravity", tWindForward )
    end
end