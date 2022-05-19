# pokemon_project


## Version 1:
This version takes all the data from **pokeapi.co**, at every full scroll the App will call the API 
for the next 20 pokemon.
Unfortunately this mechanism makes it impossible to implement a dynamic search with autocomplete
the user needs to give a valid id number or the pokemon full name in order to obtain a match,
since it makes another API call with the user input, validated and sanitized, as a parameter.
To cope with this limitation when no results are found it will also search for partial match inside the App memory,
which will have all the pokemon the user scrolled through.

## Version 2:
This version is much faster and has more flexibility since its data comes from a local JSON with the complete
pokemon list. It will only make an API call when a specific pokemon is selected to gather its detailed information.
Accordingly the search tool is able to provide suggestions based on the user input.
Like the other pages the results, if necessary, will also be displayed following the same pagination principle: 
20 at a time.

## File checked:
1. Constants ALL
2. Services ALL
3. Models ALL
4. Controllers (Provider)

## Improvements:
1. Route names are hard coded;
2. Implements equality operator and hashCode overrides for the models;

## Constructors in dart
https://dart.dev/guides/language/language-tour#using-constructors
https://www.freecodecamp.org/news/constructors-in-dart/

