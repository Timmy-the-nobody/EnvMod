[1]:https://docs.nanos.world/docs/scripting-reference/glossary/basic-types#boolean
[2]:https://docs.nanos.world/docs/scripting-reference/glossary/basic-types#number
[3]:https://docs.nanos.world/docs/scripting-reference/glossary/basic-types#string

[client]:https://docs.nanos.world/docs/next/core-concepts/scripting/authority-concepts#client-side
[server]:https://docs.nanos.world/docs/next/core-concepts/scripting/authority-concepts#server-side
[both]:https://docs.nanos.world/docs/next/core-concepts/scripting/authority-concepts#both-sides

# **EnvMod API**
Here you'll find a list of usefull functions to interract with EnvMod

## ***Wind functions***

<!-- ### [🔹][server] `EnvMod:SetWindSpeed( fSpeed )`
Set the actual wind speed (will be networked to all players)
###### Parameters
| Type                  | Parameter         | Default Value     | Description  |
| --------------------  |:----------------  |:----------------- |:------------- 
| [number][2]           | fSpeed            |                   | The wind speed to set
### [🔹][server] `EnvMod:SetWindDirection( fDirection )`
Set the actual wind direction between -180 and 180 (will be networked to all players)
###### Parameters
| Type                  | Parameter         | Default Value     | Description  |
| --------------------  |:----------------  |:----------------- |:------------- 
| [number][2]           | fDirection        |                   | The wind direction to set -->
### [🔹🔸][both] `EnvMod:GetWindSpeed()`
Get the current wind speed
###### Returns
| Type                  | Description  |
| --------------------  |:------------- 
| [number][2]           | Current wind speed, in Km/h
### [🔹🔸][both] `EnvMod:GetWindDirection()`
Get the current wind direction between -180 and 180
###### Returns
| Type                  | Description  |
| --------------------  |:------------- 
| [number][2]           | Current wind direction
### [🔹🔸][both] `EnvMod:GetFormattedWindSpeed( bMPH )`
Return the actual formatted wind speed, formatted in the format "00UNIT" (30Km/h, 98MPH, etc..)
###### Parameters
| Type                  | Parameter         | Default Value     | Description  |
| --------------------  |:----------------  |:----------------- |:------------- 
| [boolean][1]          | bMPH              | `false`           | Use the MPH unit instead of Km/h
###### Returns
| Type                  | Description  |
| --------------------  |:------------- 
| [string][3]           | Formatted wind speed
### [🔹🔸][both] `EnvMod:GetFormattedWindDirection()`
Return the actual formatted wind direction (N/E, S/W, N, etc..)
###### Returns
| Type                  | Description  |
| --------------------  |:------------- 
| [string][3]           | Formatted wind direction

# ***Temperature functions***

### [🔹][server] `EnvMod:SetTemperature( fTemperature, bFahrenheit )`
Set the current temperature on the server (will be networked to all players)
###### Parameters
| Type                  | Parameter         | Default Value     | Description  |
| --------------------  |:----------------  |:----------------- |:------------- 
| [number][2]           | fTemperature      |                   | The temperature to set
| [boolean][1]          | bFahrenheit       | `false`           | Use the fahrenheit unit instead of celcius
### [🔹🔸][both] `EnvMod:GetTemperature( bFahrenheit )`
Get the current temperature
###### Parameters
| Type                  | Parameter         | Default Value     | Description  |
| --------------------  |:----------------  |:----------------- |:------------- 
| [boolean][1]          | bFahrenheit       | `false`           | Use the fahrenheit unit instead of celcius
###### Returns
| Type                  | Description  |
| --------------------  |:------------- 
| [number][2]           | Current temperature
### [🔹🔸][both] `EnvMod:GetFormattedTemperature( bFahrenheit )`
Get the current temperature, formatted in the format "00°UNIT" (30°C, 98°F, etc..)
###### Parameters
| Type                  | Parameter         | Default Value     | Description  |
| --------------------  |:----------------  |:----------------- |:------------- 
| [boolean][1]          | bFahrenheit       | `false`           | Use the fahrenheit unit instead of celcius
###### Returns
| Type                  | Description  |
| --------------------  |:------------- 
| [string][3]           | Formatted temperature


# Util functions
| Functions             | Description   | Argument(s)  | Return  |
| --------------------  |:------------- |:---------  |:--------- 
| 🔹🔸 EnvMod:CelciusToFahrenheit | | °C temperature (number) | °F temperature (number)
| 🔹🔸 EnvMod:FahrenheitToCelcius | | °F temperature (number) | °C temperature (number)

### Weather
| Functions             | Description   | Argument(s)  | Return  |
| --------------------  |:------------- |:---------  |:--------- 
| 🔹🔸 EnvMod:SetWeather                | Set the weather type            | Weather type (string/number) | Success (bool)
| 🔹🔸 EnvMod:GetWeather                | Get the current weather metatable  | | Weather type (table)
| 🔹🔸 EnvMod:GetWeatherType            | Get the passed weather metatable | Weather ID (number) | Weather type (table)
| 🔹🔸 EnvMod:GetWeatherID              | Get the actual weather ID     | | Weather ID (number)
| 🔹🔸 EnvMod:IsRaining                 | Return if it's raining | | Is raining (bool)
| 🔹🔸 EnvMod:IsSnowing                 | Return if it's snowing | | Is snowing (bool)
| 🔹🔸 EnvMod:IsThunder                 | Return if there's thunder | | Is thunder (bool)

<!-- ### Temperature
| Functions             | Description   | Argument(s)  | Return  |
| --------------------  |:------------- |:---------  |:--------- 
| 🔹🔸 EnvMod:GetTemperature            | Return the actual temperature | [Fahrenheit (bool)] | Temperature (number)
| 🔹🔸 EnvMod:GetFormattedTemperature   | Return the formatted temperture (30°C) | [Fahrenheit (bool)] | Temperature (string)
| 🔹 EnvMod:SetTemperature            | Set the actual temperature | Temperature (number)[, Fahrenheit (bool)] | -->
<!-- 
### Wind
| Functions             | Description   | Argument(s)  | Return  |
| --------------------  |:------------- |:---------  |:--------- 
| 🔹🔸 EnvMod:GetWindSpeed  | Return the actual wind speed | | Wind speed (number)
| 🔹🔸 EnvMod:GetFormattedWindSpeed  | Return the actual formatted wind speed | [Use MPH (bool)] | Formatted wind speed (string)
| 🔹🔸 EnvMod:GetWindDirection  | Return the actual wind direction (-180, 180) | | Wind direction (number)
| 🔹🔸 EnvMod:GetFormattedWindDirection  | Return the actual formatted wind direction (N/E) | | Formatted wind direction (string)
| 🔹 EnvMod:SetWindSpeed        | Set the actual wind speed | Wind speed (number)
| 🔹 EnvMod:SetWindDirection    | Set the actual wind direction (-180, 180) | Wind direction (number) -->