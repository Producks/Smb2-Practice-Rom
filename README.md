# Super Mario Bros. 2 Practice Rom
A fork from [lui](https://github.com/Lui37/smb2u-hack/releases) practice rom

## How to Compile/Patch
You have 2 options, either compile the project or use one of the patch in the release section
### Patch an existing rom
You can find the latest patch [here]()  
This project was made for prg0. The hash is `a`  
You can check your rom hash [here](https://www.romhacking.net/hash/)

### Compiling
#### Windows
Run **build.bat**, the practice rom will be in the bin folder
#### Linux
Run **build.sh**, the practice rom will be in the bin folder
## Extra Features
* Best title screen this world has ever seen
* Level select on the title screen
* Option menu to replace the Hp bar function, click here for more details
* Pause now show the timers, can be toggle to be dynamic or fixed on the title screen


## Title screen controls

* `Start` to start the game duh
* `Up` or `Down` to move the cursor
* `Left` or `Right` to select options where the cursor is
* Holding `Left` or `Right` let you scroll faster for the level selections
### Custom  
In order for these controls to work, you need to have the cursor on the custom option
* `A` or `B` to change the **Lo** part of the custom adresss
* Holding `A` or `B` to move faster is also supported for this
* Holding `Select` + `A` or `B` while on the custom option will increment the **Hi** part of the adresss
* Holding `Select` + holding `A` or `B` also works

## Pause menu controls
* `Up` or `Down` to select a level
* `Select` to load that level

## Hp bar functions
The hp bar is easily replacable by a function now, which mean you can draw anything instead of the hitpoint.  
Here are a few throwaway functions I made  
More can be easily added in the future
* `Vanilla` is just like the original
* `Global timer` display the global timer
* `Sub pixel X` display the character X sub pixel
* `Sub pixel Y` display the character Y sub pixel
* `Lag frame` display the amount of lag frame that have happened in the current area
* `Sand timer` display the amount of frame you lost to digging
* `Can jump` display if you are allowed to jump or not
* `Custom` let you select which adress to display. See the custom control section for more info

## Credit
* Lui for the original pratice hack
* Xkeeper and kmac for making the smb2 disassembly
