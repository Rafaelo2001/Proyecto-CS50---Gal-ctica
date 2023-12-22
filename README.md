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
In the first place, we have **main.lua**, which is the main file of the entire game. Here, we call the other files and libraries that we'll need to run the game.

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


## nave.lua

This file handles everything related to the spaceship on the game screen (state 1): Its movement, its skin, the energy bar, and whether it gets hit by any object (collectible star or meteorite).

At the beginning of the file, we create a new class named "Nave" using the "Class" object, which comes from the **Classic.lua** library and was created in **main.lua**.


### `Nave:new(x, y, vidas, damage, speed)`

This function responsible for creating a new Nave object with the received parameters (coordinates, life, damage, and velocity). Additionally, it assigns the spaceship's skin, records its width and height, and calculates its radius to be used in the hitbox.


### `Nave:checkColision(e)`
This function is responsible for checking whether the spaceship has collided with an object _e_ (collectible star or meteor). 

To do so, it calculates the distance between the two objects (the ship and _e_): if the distance is less than the sum of their radii, there is contact, and it returns True; otherwise, there is no contact, and it returns False.


### `Nave:reciveDano(e, dt)`

This function checks, through Nave:checkCollision(e), whether the spaceship has been hit by a meteor _e_. If so, it decreases energy from the energy bar and plays a sound effect.


### `Nave:update(dt)`

This function is responsible for updating the logic of the spaceship, primarily its movement within the plane.

* At the beginning, we have several if-else statements that check the movement keys and move the spaceship accordingly. Additionally, if the ship's movement is vertical, a slight drag effect is applied to the ship's image to enhance the sense of motion.

* Next, we have a function that moves the spaceship toward the center of the screen if the spaceship is too close to the screen edges.

* Finally, there's a function responsible for constraining the spaceship's movement to a predefined area of the screen. Horizontally, it ranges from coordinate 20 to 600, and vertically, from coordinate 40 to 560.


### `Nave:drawLife()`

This function is responsible for drawing the ship's energy bar and gradually reducing it as the ship takes damage.


### `Nave:draw()`

This function draws the spaceship on the screen.



## bullet.lua

This file is responsible for generating the bullets fired by the ship and checking whether they collide with any meteors or not.

At the beginning of this file, we create a new class called "Bullet" using `Class:extend()`.


### `Bullet:new(x,y, type)`

This function is triggered each time a new bullet is created. It takes as arguments the current position of the ship (_x_, _y_) and the bullet level (_type_).

Depending on the level (l1, l2, or l3), each bullet will have specific parameters. Each subsequent level is more powerful and faster than the previous one, in addition to having a different skin and hitbox.

Regarding the hitbox of the bullets:
- Level l1 and l2 bullets, due to their elongated skin, have their hitbox at the right end, at their tip.
- In contrast, level l3 bullets have a complete circular hitbox that surrounds the entire skin.


### `Bullet:checkColision(e)`

This function is responsible for checking whether the bullet has collided with any meteor _e_. If it collides, it returns True; otherwise, it returns False.

To verify if it has collided with an object, this function works similarly to its counterpart in **nave.lua**: it continuously evaluates whether the distance between the center of the bullet and the center of the object (_e_) is less than the sum of their hitboxes.


### `Bullet:update(dt)`
This function updates the bullet's logic. It utilizes deltatime (dt) to update the bullet's position based on its “speed” in each frame.

### `Bullet:draw()`
This function draws the bullet on the screen.


## enemigo.lua

This file contains the base class for the game’s obstacles (meteors).

At the beginning of the file, we create a new class called ‘Enemigo’ using `Class:extend()`.


### `Enemigo:new(x, y, value, imagen)`

Create a new "Enemigo" with the received parameters:
- *x* and *y* represent the generation position.
- *value* is the score value added when the "enemy" is destroyed.
- *image* refers to the location of the "enemy's" skin within the game files.

Additionally, this function calculates the radius size of the hitbox.

The `Enemigo:update()` and `Enemigo:draw()` functions are empty and do not perform any actions. They are included in the code to maintain the basic structure of Love2D.
