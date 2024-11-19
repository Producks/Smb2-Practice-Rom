# Super Mario Bros. 2 Practice Rom
A fork from [lui](https://github.com/Lui37/smb2u-hack/releases) practice rom

## How to Compile/Patch
You have two options: either compile the project or use one of the patches in the release section
### Patch an existing rom
This project was made for the NTSC PRG0 version of the game.  
The SHA256 hash is `47ba60fad332fdea5ae44b7979fe1ee78de1d316ee027fea2ad5fe3c0d86f25a`  
You can check your rom hash [here](https://emn178.github.io/online-tools/sha256_checksum.html)  
You can patch the bps file using [this](https://www.smwcentral.net/?a=details&id=11474&p=section)  
You can patch the ips file using [this](https://www.romhacking.net/utilities/240/)  

### Compiling
#### Windows
Run **build.bat**; the practice ROM will be in the **bin** folder.
#### Linux
Run **build.sh**; the practice ROM will be in the **bin** folder.
## Extra Features
* Best title screen this world has ever seen
* Level select on the title screen
* Option menu to replace the Hp bar function, click here for more details
* Pause screen now shows timers, which can be toggled to be dynamic or fixed via the title screen.


## Title screen controls

* `Start` to start the game (duh)
* `Up` or `Down` to move the cursor
* `Left` or `Right` to change the option where the cursor is
* Hold `Left` or `Right` to scroll faster through the level selection options
### Custom
To use these controls, ensure the cursor is on the Custom option
* `A` or `B` to change the **Lo** part of the custom adress
* Hold `A` or `B` to move faster when changing the Lo part.
* Hold `Select` + `A` or `B` to increment the Hi part of the address
* Holding both `Select` and `A` or `B` simultaneously also works for faster changes

## Pause menu controls
* `Up` or `Down` to select a level
* `Select` to load that level

## Hp bar functions
The HP bar is now easily replaceable with a custom function, meaning you can draw anything instead of displaying hit points  
Here are a few example functions already implemented (more can be added in the future) 
* `Vanilla`: Functions just like the original HP bar
* `Global timer`: Displays the global timer
* `Sub pixel X`: Shows the character's X-axis sub-pixel position
* `Sub pixel Y`: Shows the character's Y-axis sub-pixel position
* `Lag frame`: Displays the number of lag frames that have occurred in the current area
* `Sand timer`: Tracks the number of frames where you could dig.  
The implementation of this is a bit weird, and I currently don't have an ideal way to track states.  
As a result, it's normal to lose a frame after each dig if you're perfect.  
The initial dig can have 0 frames of delay, but any subsequent dig, where you're waiting for the animation, will always add +1 frame if executed perfectly.
* `Can jump`: Indicates whether jumping is currently allowed
* `Custom`: Allows you to select which address to display. See the custom control section for more information.  
[Here a list](https://github.com/Producks/Smb2-Practice-Rom/blob/Practice/src/ram.asm) of the ram adresses

## Credit
* **Lui**: For the original practice hack.
* **Xkeeper0** and **Kmck**: For their work on the [smb2 disassembly](https://github.com/Xkeeper0/smb2)
