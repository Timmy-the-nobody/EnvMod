[boolean]:https://docs.nanos.world/docs/scripting-reference/glossary/basic-types#boolean
[number]:https://docs.nanos.world/docs/scripting-reference/glossary/basic-types#number
[string]:https://docs.nanos.world/docs/scripting-reference/glossary/basic-types#string
[table]:https://docs.nanos.world/docs/scripting-reference/glossary/basic-types#table

[client]:https://docs.nanos.world/docs/next/core-concepts/scripting/authority-concepts#client-side
[server]:https://docs.nanos.world/docs/next/core-concepts/scripting/authority-concepts#server-side
[both]:https://docs.nanos.world/docs/next/core-concepts/scripting/authority-concepts#both-sides

**📘 EnvMod Wiki**

## 📦 Installation
- Download EnvMod and add it in the `/Server/Packages/` folder on your server
- Then go to `/Server/Config.toml` and add `envmod` (or the package name) in the `packages` array.
- Download [EnvMod assets pack](https://github.com/Timmy-the-nobody/EnvMod-assets) and install it in `/Server/Assets`

> #### Note for scripters: 
> You'll only be able to use EnvMod functions in the script package if you load it that way, if you want to be able to use EnvMod methods in another package use [`Package.RequirePackage`](https://docs.nanos.world/docs/scripting-reference/static-classes/package#requirepackage) in the other package.
Unlike functions, EnvMod events will be sent to all packages

## 🛠️ Configuration
- Edit the script to your liking by going to [`envmod/Shared/config.lua`](https://github.com/Timmy-the-nobody/EnvMod/blob/main/Shared/config.lua), some settings require a server restart

## 🖥️ Console commands
- Type `envmod help` in your server-side console to display all available commands, their arguments and their descriptions.

## ⛅ Weather types
- To create a new weather type, copy one of the existing weather types in `envmod/Shared/weather_types/` and paste it in the same folder, by remaning it to something unique like `YOUR_NEW_WEATHER.lua`

- You'll find all the data needed to create your new weather type at the top of the file you just copied.

## 📜 Scripting (Events)
<details><summary>✨ Events</summary>

### [🔹🔸][both] `"EnvMod:OnLoaded"`
###### Called once EnvMod if fully loaded

### [🔹🔸][both] `"EnvMod:OnTimeChange"`
###### Called after a time updated
<details><summary>Parameters</summary>

| Type                  | Description  |
| --------------------  |:------------- 
| [number]              | The new time (from 0 to 1440)
</details>

### [🔹🔸][both] `"EnvMod:OnNewDayStarted"`
###### Called when a new day started
<details><summary>Parameters</summary>

| Type                  | Description  |
| --------------------  |:------------- 
| [number]              | The new day
</details>

### [🔹🔸][both] `"EnvMod:OnDayStart"`
###### Called when the day cycle started

### [🔹🔸][both] `"EnvMod:OnNightStart"`
Called when the night cycle started

### [🔹🔸][both] `"EnvMod:OnWeatherChange"`
###### Called on weather change
<details><summary>Parameters</summary>

| Type                  | Description  |
| --------------------  |:------------- 
| [table]               | The new weather type
| [table]               | The old weather type
</details>

### [🔹🔸][both] `"EnvMod:OnWindSpeedChange"`
###### Called after the wind speed has changed
<details><summary>Parameters</summary>

| Type                  | Description  |
| --------------------  |:------------- 
| [number]              | The new wind speed
| [number]              | The old wind speed
</details>

### [🔹🔸][both] `"EnvMod:OnWindSpeedChange"`
###### Called after the wind direction has changed
<details><summary>Parameters</summary>

| Type                  | Description  |
| --------------------  |:------------- 
| [number]              | The new wind direction
| [number]              | The old wind direction
</details>

### [🔹🔸][both] `"EnvMod:OnTemperatureChange"`
###### Called after the temperature has changed
<details><summary>Parameters</summary>

| Type                  | Description  |
| --------------------  |:------------- 
| [number]              | The new temperature
| [number]              | The old temperature
</details>
</details>

## 📜 Scripting (Functions)

<details><summary>⛅ Weather functions</summary>

### [🔹🔸][both] `EnvMod:SetWeather( xWeather )`
Set the current weather type (will be networked to all players when called on server)
###### Parameters
| Type                  | Parameter         | Default Value     | Description  |
| --------------------  |:----------------  |:----------------- |:------------- 
| [number] or [string]  | xWeather          |                   | Weather type (ID or name)
###### Returns
| Type                  | Description  |
| --------------------  |:------------- 
| [boolean]             | If weather was changed successfully


### [🔹🔸][both] `EnvMod:GetWeather()`
Get the current weather type metatable, usefull to access it's functions
###### Returns
| Type                  | Description  |
| --------------------  |:------------- 
| [table]               | Weather type

### [🔹🔸][both] `EnvMod:GetWeatherType( iWeatherID )`
Get a weather type metatable, usefull to access it's functions
###### Parameters
| Type                  | Parameter         | Default Value     | Description  |
| --------------------  |:----------------  |:----------------- |:------------- 
| [number]              | iWeatherID        |                   | Weather type (ID)
###### Returns
| Type                  | Description  |
| --------------------  |:------------- 
| [table]               | Weather type

### [🔹🔸][both] `EnvMod:GetWeatherID()`
Get the actual weather ID
###### Returns
| Type                  | Description  |
| --------------------  |:------------- 
| [number]              | Weather ID

### [🔹🔸][both] `EnvMod:IsRaining()`
Return if it's raining
###### Returns
| Type                  | Description  |
| --------------------  |:------------- 
| [boolean]             | Is raining

### [🔹🔸][both] `EnvMod:IsSnowing()`
Return if it's snowing
###### Returns
| Type                  | Description  |
| --------------------  |:------------- 
| [boolean]             | Is snowing

### [🔹🔸][both] `EnvMod:IsThunder()`
Return if there's thunder
###### Returns
| Type                  | Description  |
| --------------------  |:------------- 
| [boolean]             | Is thunder
</details>

<details><summary>⌚ Time functions</summary>

### [🔹🔸][both] `EnvMod:SetTime( iTime )`
Set the current time (will be networked to all players when called on server)
###### Parameters
| Type                  | Parameter         | Default Value     | Description  |
| --------------------  |:----------------  |:----------------- |:------------- 
| [number]              | iTime             |                   | Time (0-1440)

### [🔹🔸][both] `EnvMod:GetTime()`
Returns the current time
###### Returns
| Type                  | Description  |
| --------------------  |:------------- 
| [number]              | Actual time (0-1440)

### [🔹🔸][both] `EnvMod:GetHours()`
Returns the current hours
###### Returns
| Type                  | Description  |
| --------------------  |:------------- 
| [number]              | Actual hours (0-24)

### [🔹🔸][both] `EnvMod:GetMinutes()`
Returns the current minutes
###### Returns
| Type                  | Description  |
| --------------------  |:------------- 
| [number]              | Actual minutes (0-60)

### [🔹🔸][both] `EnvMod:GetSeconds()`
Returns the current seconds
###### Returns
| Type                  | Description  |
| --------------------  |:------------- 
| [number]              | Actual minutes (0-60)

### [🔹🔸][both] `EnvMod:GetFormattedTime( bReturnSeconds )`
Formatted time, with leading "0" for minutes and seconds, in the "00:00" format
###### Parameters
| Type                  | Parameter         | Default Value     | Description  |
| --------------------  |:----------------  |:----------------- |:------------- 
| [boolean]             | bReturnSeconds    | `false`           | Show seconds
###### Returns
| Type                  | Description  |
| --------------------  |:------------- 
| [string]               | Formatted time

### [🔹🔸][both] `EnvMod:IsDay()`
Returns if we're in a day cycle
###### Returns
| Type                  | Description  |
| --------------------  |:------------- 
| [boolean]             | Is day

### [🔹🔸][both] `EnvMod:IsNight()`
Returns if we're in a night cycle
###### Returns
| Type                  | Description  |
| --------------------  |:------------- 
| [boolean]             | Is night
</details>

<details><summary>📆 Date functions</summary>

### [🔹][server] `EnvMod:SetDay( iDay )`
Set the current day (will be networked to all players)
###### Parameters
| Type                  | Parameter         | Default Value     | Description  |
| --------------------  |:----------------  |:----------------- |:------------- 
| [number]              | iDay              |                   | The day to set

### [🔹🔸][both] `EnvMod:GetDay()`
Returns the current day
###### Returns
| Type                  | Description  |
| --------------------  |:------------- 
| [number]              | Day

### [🔹🔸][both] `EnvMod:GetDate( iDay )`
Returns a date, month and year, based on a certain day
###### Parameters
| Type                  | Parameter         | Default Value         | Description  |
| --------------------  |:----------------  |:-----------------     |:------------- 
| [number]              | iDay              | `nil` (actual day)    | The day you want to convert to dd, mm, yyyy
###### Returns
| Type                  | Description  |
| --------------------  |:------------- 
| [number]              | Day
| [number]              | Month
| [number]              | Year

### [🔹🔸][both] `EnvMod:GetFormattedDate( bNumeric, iDay )`
Returns the formatted date
###### Parameters
| Type                  | Parameter         | Default Value         | Description  |
| --------------------  |:----------------  |:-----------------     |:------------- 
| [number]              | bNumeric          | `false`               | true: Format to DD-MM-YYYY if true, false: DD Month YYYY
| [number]              | iDay              | `nil` (actual day)    | The day you want to format
###### Returns
| Type                  | Description  |
| --------------------  |:------------- 
| [string]              | Formatted date
</details>

<details><summary>💨 Wind functions</summary>

### [🔹🔸][both] `EnvMod:GetWindSpeed()`
Get the current wind speed
###### Returns
| Type                  | Description  |
| --------------------  |:------------- 
| [number]              | Current wind speed, in Km/h

### [🔹🔸][both] `EnvMod:GetWindDirection()`
Get the current wind direction between -180 and 180
###### Returns
| Type                  | Description  |
| --------------------  |:------------- 
| [number]              | Current wind direction

### [🔹🔸][both] `EnvMod:GetFormattedWindSpeed( bMPH )`
Return the actual formatted wind speed, formatted in the format "00UNIT" (30Km/h, 98MPH, etc..)
###### Parameters
| Type                  | Parameter         | Default Value     | Description  |
| --------------------  |:----------------  |:----------------- |:------------- 
| [boolean]             | bMPH              | `false`           | Use the MPH unit instead of Km/h
###### Returns
| Type                  | Description  |
| --------------------  |:------------- 
| [string]              | Formatted wind speed

### [🔹🔸][both] `EnvMod:GetFormattedWindDirection()`
Return the actual formatted wind direction (N/E, S/W, N, etc..)
###### Returns
| Type                  | Description  |
| --------------------  |:------------- 
| [string]              | Formatted wind direction
</details>

<details><summary>🌡️ Temperature functions</summary>

### [🔹🔸][both] `EnvMod:GetTemperature( bFahrenheit )`
Get the current temperature
###### Parameters
| Type                  | Parameter         | Default Value     | Description  |
| --------------------  |:----------------  |:----------------- |:------------- 
| [boolean]             | bFahrenheit       | `false`           | Use the fahrenheit unit instead of celcius
###### Returns
| Type                  | Description  |
| --------------------  |:------------- 
| [number]              | Current temperature

### [🔹🔸][both] `EnvMod:GetFormattedTemperature( bFahrenheit )`
Get the current temperature, formatted in the format "00°UNIT" (30°C, 98°F, etc..)
###### Parameters
| Type                  | Parameter         | Default Value     | Description  |
| --------------------  |:----------------  |:----------------- |:------------- 
| [boolean]             | bFahrenheit       | `false`           | Use the fahrenheit unit instead of celcius
###### Returns
| Type                  | Description  |
| --------------------  |:------------- 
| [string]              | Formatted temperature

### [🔹🔸][both] `EnvMod:CelciusToFahrenheit( fTemperature )`
Util function that converts a temperature in Celcius to Fehrenheit
###### Parameters
| Type                  | Parameter         | Default Value     | Description  |
| --------------------  |:----------------  |:----------------- |:------------- 
| [number]              | fTemperature      |                   | Temperature to convert, in °C
###### Returns
| Type                  | Description  |
| --------------------  |:------------- 
| [number]              | Converted temperature, in °F

### [🔹🔸][both] `EnvMod:FahrenheitToCelcius( fTemperature )`
Util function that converts a temperature in Fehrenheit to Celcius
###### Parameters
| Type                  | Parameter         | Default Value     | Description  |
| --------------------  |:----------------  |:----------------- |:------------- 
| [number]              | fTemperature      |                   | Temperature to convert, in °F
###### Returns
| Type                  | Description  |
| --------------------  |:------------- 
| [number]              | Converted temperature, in °C

</details>