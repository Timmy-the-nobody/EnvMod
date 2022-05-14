[boolean]:https://docs.nanos.world/docs/scripting-reference/glossary/basic-types#boolean
[number]:https://docs.nanos.world/docs/scripting-reference/glossary/basic-types#number
[string]:https://docs.nanos.world/docs/scripting-reference/glossary/basic-types#string
[table]:https://docs.nanos.world/docs/scripting-reference/glossary/basic-types#table

[client]:https://docs.nanos.world/docs/next/core-concepts/scripting/authority-concepts#client-side
[server]:https://docs.nanos.world/docs/next/core-concepts/scripting/authority-concepts#server-side
[both]:https://docs.nanos.world/docs/next/core-concepts/scripting/authority-concepts#both-sides

**📘 EnvMod Wiki**

## 🛠️ Configuration
Edit the script to your liking by going to `envmod/Shared/config.lua`, some settings require a server restart

## 🖥️ Console commands
Type `envmod help` in your server-side console to display all available commands, their arguments and their descriptions.

## ⛅ Weather types
To create a new weather type, copy one of the existing weather types in `envmod/Shared/weather_types/` and paste it in the same folder, by remaning it to something unique like `YOUR_NEW_WEATHER.lua`

You'll find all the data needed to create your new weather type at the top of the file you just copied.

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

<!-- | 🔹🔸 EnvMod:SetWeather                | Set the weather type            | Weather type (string/number) | Success (bool)
| 🔹🔸 EnvMod:GetWeather                | Get the current weather metatable  | | Weather type (table)
| 🔹🔸 EnvMod:GetWeatherType            | Get the passed weather metatable | Weather ID (number) | Weather type (table)
| 🔹🔸 EnvMod:GetWeatherID              | Get the actual weather ID     | | Weather ID (number)
| 🔹🔸 EnvMod:IsRaining                 | Return if it's raining | | Is raining (bool)
| 🔹🔸 EnvMod:IsSnowing                 | Return if it's snowing | | Is snowing (bool)
| 🔹🔸 EnvMod:IsThunder                 | Return if there's thunder | | Is thunder (bool)
-->
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

<!-- ### [🔹][server] `EnvMod:SetWindSpeed( fSpeed )`
Set the actual wind speed (will be networked to all players)
###### Parameters
| Type                  | Parameter         | Default Value     | Description  |
| --------------------  |:----------------  |:----------------- |:------------- 
| [number][number]           | fSpeed            |                   | The wind speed to set
### [🔹][server] `EnvMod:SetWindDirection( fDirection )`
Set the actual wind direction between -180 and 180 (will be networked to all players)
###### Parameters
| Type                  | Parameter         | Default Value     | Description  |
| --------------------  |:----------------  |:----------------- |:------------- 
| [number][number]           | fDirection        |                   | The wind direction to set -->
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

<!-- ### [🔹][server] `EnvMod:SetTemperature( fTemperature, bFahrenheit )`
Set the current temperature on the server (will be networked to all players)
###### Parameters
| Type                  | Parameter         | Default Value     | Description  |
| --------------------  |:----------------  |:----------------- |:------------- 
| [number]              | fTemperature      |                   | The temperature to set
| [boolean]             | bFahrenheit       | `false`           | Use the fahrenheit unit instead of celcius -->

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