# Galáctica
#### Video Demo:  https://youtu.be/VArdc42wQVs
#### Description:
My project is about a space shooter video-game where you have to dodge or destroy meteorites and collect stars to increase your score. After reaching a certain number of points, the spaceship’s laser will level up and become stronger and faster.

<hr>

### File list:
* "Assets" folder
* "librerias" folder
* main.lua
* nave.lua
* bullet.lua
* enemigo.lua
* meteoro.lua
* meteorosDisplay.lua
* coin.lua


## main.lua
In the first place, we have *main.lua*, which is the main file of the entire game. Here, we call the other files and libraries that we'll need to run the game.

At the very start of the file, we declare a set of variables and functions that fulfill various roles:
- `love.window.setTitle` changes the title of the game window to ‘Project Galáctica’.
- Next, there are the variables "anchoPantalla" and "altoPantalla", which contain the width and height values of the window, respectively.
- Lastly, the game credits are printed to the console. 


### `love.load()`
This is the first function of all the program. Here we initialize auxiliary libraries, the game state, the “player” (the spaceship), the arrangement and order of meteorites appearance, several auxiliary arrays, and the assets used in the game (fonts, images, sounds, and BGM).


### `love.keypressed(key)`
This function checks which key has been pressed and acts in one of the following ways:

- If the game state is 0 ( title screen - default ) and the spacebar is pressed, it changes the state to 1 and starts the game.

- If the state is 1 ( main game ), it reads the keys ‘a’, ‘w’, ‘s’, ‘d’, and the arrow keys for spaceship movement, as well as the ‘z’ and ‘enter’ keys for shooting. Additionally, depending on the current Score, it will also adjust the shooting level and play a shooting sound.

- Finally, if the state is 2 ( game over ), it will read when the spacebar is pressed and switch back to state 0 (title screen).


### `love.update(dt)`
This function is responsible for updating the whole game logic frame by frame.

First, it updates the Tick function and the StarUpdate function (this last one responsible for generating the background stars).

Following that, we have a series of if-else statements that check the game’s state. Depending on each game state, the function does the following:
- If the game state is 0: It does nothing.

- If the game state is 1:
    * First, we start the BGM and initialize the Player (spaceship) and the obstacles (meteors).

    * Then we have a for-loop that updates each bullet, checks if it has collided with a meteor, and adds the meteor’s point value to the Score if it destroys the meteor.

    * Next, we have another for-loop that updates each meteor on the screen and detects if the spaceship has collided with it, subtracting life from the energy bar. It also checks if the energy is less than 0 to switch to the game state 2, the Game Over screen.

    * A third for-loop is responsible for updating the collectible stars, checking if they have touched the spaceship, and adding their value to the Score.

    * Finally, we have two additional for-loops responsible for removing objects from the game logic that have exceeded a certain threshold. This was implemented to prevent overloading the program with objects outside the game area.

- If the game state is 2: It stops the BGM initiated at the beginning of the state 1.


### `love.draw()`

At the end of this file, we have `love.draw()`, which is responsible for drawing all the graphics on the screen.

At the beginning of this function, the background stars are drawn, and they are independent of the actual game state.

Similar to love.update(dt), this function contains a series of if-else statements for each state:

* When the game state is 0, it draws the title screen with the game title and instructions for playing.

* When the game state is 1, it draws the gameplay area with the spaceship, meteors, energy bar, etc.

* Finally, when the game state is 2, it draws the game over screen with the obtained Score and credits.
