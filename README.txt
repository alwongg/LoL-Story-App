Welcome!

WHEN BUILDING AND ACCESSING THE APP, REPLACE THE APIKey CONSTANT WITH YOUR OWN!

* Locate the RiotConstants file in the app and go to https://developer.riotgames.com to generate your own APIKey.

* Copy and paste your APIKey in between the double quotes beside “static let APIKey =“

* Run the project!

This is my final project in the Udacity iOS Nanodegree program. It is an iOS app that allows you to read stories regarding each League of Legends Champions. Want to know more about a champion’s past? Click on the champion you are interested in and it will take you to another ViewController which contains their name, title and their lore. 

The app starts with a Startup screen image and displays all the champions in League of Legends in a collection view. This list is downloaded from the Riotgames API with the GET method /lol/static-data/v3/champions and is retrieving the image and lore tags only at the moment. If you want to know about a champion’s background, click on their image and it will take you to their lore page which you can read all about their stories in a textview within a scrollview in portrait mode.

If you want to add upcoming stories you are planning to read for later, click the compose button at the top left corner and add any stories you’re planning to read! If they are important, make sure the switch is on, if not, then leave it off.
