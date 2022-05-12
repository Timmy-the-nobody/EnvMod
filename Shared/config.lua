--[[ Misc. ]]--

EnvMod.Cfg.UseRealTime = false                                          -- If true, EnvMod will be based on real time
EnvMod.Cfg.UseRealWeather = false                                       -- If true, EnvMod will use real weather
EnvMod.Cfg.AMPMClock = false                                            -- Time format (`true` for 12h AM/PM clock, `false` for 24h clock)
EnvMod.Cfg.MMDDYYYYCalendar = false                                     -- Date format (`true` for MM-DD-YYYY, `false` for DD/MM/YYYY)

--[[

    Timecycle config
    Those settings will not be considered if `EnvMod.Cfg.UseRealTime = true`

]]--

EnvMod.Cfg.Time24hCycle = 7200                                          -- How long a 24h cycle lasts in real time seconds
EnvMod.Cfg.TimeNightStart = 22                                          -- Night start in in-game hours
EnvMod.Cfg.TimeDayLength = 16                                           -- Day duration in in-game hours
EnvMod.Cfg.TimeOnLoad = 6                                               -- Time on server start in in-game hours
EnvMod.Cfg.YearStart = 2022

--[[

    Weather config
    Those settings will not be considered if `EnvMod.Cfg.UseRealWeather = true`

]]--

EnvMod.Cfg.WeatherChangeDelay = 600                                     -- How often the weather will change (in real time seconds), can vary depending on the weather type probability
EnvMod.Cfg.WeatherTransitionSpeed = 0.4                                 -- How fast weather transitions are done (lower = faster)
EnvMod.Cfg.TemperatureUpdateFrequency = 20                              -- How often will the temperature be updated (lower = less frequent updates) : WeatherChangeDelay / TemperatureUpdateFrequency
EnvMod.Cfg.WindUpdateFrequency = 40                                     -- How often will the wind speed be updated (lower = less frequent updates) : WeatherChangeDelay / WindUpdateFrequency

--[[

    Performance

]]--

EnvMod.Cfg.ServerTimeUpdateRate = 1                                     -- How often the server will update the cached time (in real time seconds)
EnvMod.Cfg.ServerTimeBroadcast = 120                                    -- How often the server will broadcast time to all clients (in real time seconds)