If you want to contribute to EnvMod, please follow some conventions listed bellow.

## Basics

* Keep your code consistant
* Avoid redundant code, e.g: prefer a function to a pyramid of conditions
* Avoid passing packets through the network unnecessarily (e.g. using the broadcast parameter of `SetValue` when only one client needs it's data)
* Localize your functions/variables/tables/etc.. whenever it's possible
* Localize heavy globals on the top of your files when they're called often
* Avoid heavy operations in `Tick` events
* Triple check what's sent by clients throught the network
* Avoid looping through big tables
* Add validity checks in delayed callbacks (timers, SQL fetch, etc..)

## Syntax : Variables

* Global vars must be formatted in **PascalCase**
* Local vars must be formatted in **camelCase**
* Enum vars must be formatted in **UPPERCASE**

Indicate the type (usually with the first letter of the variable) for variables and objects, except functions and enums:

* **b**Bool
* **i**Int
* **f**Float
* **s**String
* **t**Table
* **p**Player
* **e**Entity
* **x**Undefined

## Syntax : Misc.

* Always use Lua operators
* Indent with 4 spaces
* Your code should contain spaces after :
  * Brackets
  * Square brackets
  * Commas
* Add brackets to your comparison operations, or your mathematical operations
