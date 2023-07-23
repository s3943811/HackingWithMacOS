# HackingWithMacOS
Repository for my projects from the Hacking with MacOS book by Paul Hudson. Currently I am going through the SwiftUI version. 

Find the book: https://www.hackingwithswift.com/store/hacking-with-macos 
(https://twostraws.gumroad.com/l/hwmacos/wwdc23)

And the repo with project files from Paul Hudson: https://github.com/twostraws/macOS

# Project 1: Storm Viewer :heavy_check_mark:
> Get started coding in Swift by making an image viewer app and learning key concepts.

A simple app that lets users scroll through a list of images then select one to view. 

# Project 2: Cows and Bulls :heavy_check_mark:
> Practice your List skills while learning about random numbers and text input.

A game that will let generate a random hidden number with 4 unique digit from 0 to 9, and the player has to guess the hidden number. If one of their digits is in the correct place it’s a “bull”, if it exists in the hidden number but is in the wrong place it’s a “cow”. 

## Project 2 Extention :heavy_check_mark:
As one of the challenges of project 3; Views and Modifiers; the result text should show different colours depending on how close the user is:
- Red for 0 bulls 0 Cows
- Yellow for 1 to 3 bulls and cows
- Green for 4 bulls and/or cows

Hard mode does not show any colour.

# Project 3: Views and Modifier :heavy_check_mark:
> Dive deep into Swift's rendering system.

A lesson on how and why Views and Modifiers work that way in SwiftUi.

# Project 4: Text Parser :heavy_check_mark:
> Tackle the command line with Swift Package Manager and the NaturalLanguage Framework

A command line project that will analyses text input using the natural language library as well as the swift-argument-parses library. 

# Project 5: MultiMap :heavy_check_mark:
> Learn to create maps and map pins by combining SwiftUI and MapKit.

An app that lets us search for and track multiple locations at the same time. 

# Project 6: Animation :heavy_check_mark:
> Spruce up your UI with springs, bounces and more.

A technique lesson in animation. There is no project here so the final code is the latest demo from the chapter. 

# Project 7: FastTrack :heavy_check_mark:
> Learn to fetch and parse JSON from the internet, displaying the results in a grid.

An app that searches the iTunes API displays, album covers, artist names, song titles and let users listen to a preview of each track.

# Project 8: Odd One Out :heavy_check_mark:
> Build a picture-matching game that's all but guaranteed to get you stumped.

A game where you have to choose the lone animal from the pairs to advance to the next round. 

For this project I added some extentions/challenges to make it feel more complete:
- A starting screen/view that describes the game.
- Three Strikes! If you get three guesses wrong in a row on any level, you lose and have to start again.
- A home context menu button and a home button on the lose and win screens to take you back to the start screen.
- Added some animation when switching through views and/or advancing to the next level.
- A level counter below the Title. 




Start Menu               |  Game View
:--------------------:|:-------------------------:
![Image of the game start menu](/images/Project8-Start.png)  |  ![Image of the game play view](/images/Project8-Game.png)
Won View              |  Lost View
![Image of the game won view](/images/Project8-Won.png)  |  ![Image of the game lost view](/images/Project8-Lost.png)

# Project 9: Drawing
> Use shapes, paths, colors, and more to create custom art for your app.
   
   
# Project 10: Time Buddy :heavy_check_mark:
> Expand your skills to the macOS menu bar and build a helpful utility for distributed teams.

An menu bar app that lets the you figure out the time across the world by time zones you care about to a list.
- Add, delete, move and copy time zones. 

Start View               |  View with added time zones
:--------------------:|:-------------------------:
![Image of the game start menu](/images/Project10-NoTimes.png)  |  ![Image of the game play view](/images/Project10-TimeList.png)
Error duplicate View              |  Quit warning View
![Image of the game won view](/images/Project10-Error.png)  |  ![Image of the game lost view](/images/Project10-Quit.png)

