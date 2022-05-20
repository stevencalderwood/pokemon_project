# pokemon_project

A Flutter App project using data from the [pokeapi.co](https://pokeapi.co/api/v2/pokemon/).

The two versions use the same three views (**Home**, **Search**, **Info**) but differs in the capability of their 
controller.

Packages used: [http 0.13.4](https://pub.dev/packages/http).

## Version 1:
This version takes all the data from the API, at every full scroll the App make a request for the next 20 Pokemon.
Unfortunately this mechanism makes it impossible to implement a dynamic search with autocomplete
the user needs to give a valid Id number or the Pokemon full name in order to obtain a match,
since it makes another API call with the user input, validated and sanitized, as a parameter.
To cope with this limitation when no results are found it will also search for partial match inside the App memory,
which will have all the pokemon the user scrolled through.

## Version 2:
This version is much faster and has more flexibility since its data comes from a local JSON with the complete
pokemon list. It will only make an API call when a specific pokemon is selected to gather its detailed information.
Accordingly the search tool is able to provide suggestions based on the user input.
Like the other pages the Pokemon Widgets, if necessary, are displayed following the same pagination principle: 20 at 
a time.

