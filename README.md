# Godot Retro

![Logo](https://raw.githubusercontent.com/Ahopness/GodotRetro/main/icon.png "Logo")

- - - - - - -

[![License](https://img.shields.io/github/license/Ahopness/GodotRetro?color=b339e3&style=flat-square "License")](http://github.com/Ahopness/GodotRetro/blob/main/LICENSE "License")
[![Stars](https://img.shields.io/github/stars/Ahopness/GodotRetro?color=b339e3&style=flat-square "Stars")](http://github.com/Ahopness/GodotRetro/stargazers "Stars")
[![Forks](https://img.shields.io/github/forks/Ahopness/GodotRetro?color=b339e3&style=flat-square "Forks")](http://github.com/Ahopness/GodotRetro/network/member "Forks")
[![Releases](https://img.shields.io/badge/version-2.0.0-b339e3?style=flat-square "Releases")](http://github.com/Ahopness/GodotRetro/releases "Releases")
![Repo Size](https://img.shields.io/github/repo-size/Ahopness/GodotRetro?color=b339e3&style=flat-square "Repo Size")
![Last Commition](https://img.shields.io/github/last-commit/Ahopness/GodotRetro?color=b339e3&style=flat-square "Last Commition")
[![Twitter](https://img.shields.io/badge/Twitter-Ahopness-b339e3?style=flat-square "Twitter")](http://twitter.com/ahopness "Twitter")



## Content

* [About](#about)
* [License](#license)
* [Shaders](#shaders)
* [Instalation](#instalation)
* [Demo](#demo)
* [Features](#features)
* [Limitations](#limitations)
* [TODO](#todo)
* [Credits](#credits)



## About

**Godot Retro** is a shader pack for godot, with various ports of shades from *ShaderToy*, *Unity* and The *Book Of Shaders*. 



## License

Godot Retro is free to use and modify by everybody, *however*, the name of the developer and porter(me) of the used shader must be credited.

Godot Retro uses the [MIT License](https://github.com/Ahopness/GodotRetro/blob/main/LICENSE).



## Shaders

### PSX

*A modified psx shader.*

![PSX](https://i.imgur.com/x4j1O7U.gif "PSX")


### COLOR PRECISION

*A color precision screen space shader.*

![Color Precision](https://i.imgur.com/9gZrMev.gif "Color Precision")


### BLACK & WHITE

*A B&W screen space shader.* 

![B&W](https://i.imgur.com/i9TAX9f.gif "B&W")


### GRAIN

*A film grain screen space shader.* 

![Grain](https://i.imgur.com/gMdSFef.gif "Grain")


### SIMPLE GRAIN

*A simple film grain screen space shader.* 

![sGrain](https://i.imgur.com/unmRiis.gif "sGrain")


### BETTER COLOR CORRECTION

*A color correction screen space shader that adds more options then the godot's built-in CC.* 

![BCC](https://i.imgur.com/9YgI8gv.gif "BCC")


### LENS DISTORTION

*A lens distortion screen space shader.* 

![LD](https://i.imgur.com/DaO5dSu.gif "LD")


### SHARPNESS

*A sharpness screen space shader.* 

![S](https://i.imgur.com/IbG1rk4.gif "S")


### TV

*A TV screen space shader.* 

![TV](https://i.imgur.com/3pzUdaa.gif "TV")


### VHS

*A VHS screen space shader.* 

![VHS](https://i.imgur.com/o2IYf8i.gif "VHS")


### VHS Glitch

*A VHS Glitch screen space shader.* 

![VHSG](https://i.imgur.com/NJlnwkY.gif "VHSG")


### VHS Pause

*A VHS Pause screen space shader.*

![VHSP](https://i.imgur.com/TU9CD8f.gif "VHSP")


### VHS Simple Glitch

*A VHS Simple Glitch screen space shader.*

![VHSsG](https://i.imgur.com/yqrmWZr.gif "VHSsG")



## Instalation

**To use the shaders you gotta** :

1. Copy the _GodotRetro_ folder to your project (can be anywhere)


***For normal shader*** :

2. Just add the shader script to a shader material.


***For screen space shaders*** :

2. Add the shader on a TextureRect with the _white.png_ as texture.


**Example : **

![example](https://i.imgur.com/sTRhlJU.png)


**Done!** Have fun!


### DISCLAMER :

- To use 2+ shaders at the same time, you gotta use a BackBufferCopy set as Viewport for each effect.

- For UI, be sure to set it above the shaders for then to be aplied for more imersion.



## DEMO

Free easy to lean demo is available with the pack.


**Demo Controls**:

|    W   |     A     |     S     |     D      |     E     |     Q     | Shift |
|--------|-----------|-----------|------------|-----------|-----------|-------|
| Foward | Turn Left | Backwards | Turn Right | Walk Left | Walk Left |  Run  |

|            1             |             2            |
|--------------------------|--------------------------|
| change shader on layer 1 | change shader on layer 2 |



## Features

 - **12** easy to use godot shaders
 
 - **Frequentily updated**

 - 2 well done **demo projects**



## Limitations

Unfortnetly, some shaders arent 100% perfect.

 - The Color Precission shader's dithering dont work because of Godot's limitation.


 *All the limitations should be fixed with time and from help from contributors.*



## TODO

 - Add more shaders.

 - Finish and solve bugs on the PSX shaders.



## Credits 

Shaders ported by : **Ahopness ([@ahopness](http://twitter.com/ahopness "My Twitter Account"))**
</n>
</n>
B&W shader made by : **demofox (ShaderToy)**

Color precission shader made by : **abelcamarena (ShaderToy)**

Simple Grain shader made by : **juniorxsound (ShaderToy)**

BetterCC shader made by **Wunkolo(ShaderToy)**

Lens Distortion shader made by **hiulit(GitHub)**

Sharpness shader made by **Nihilistic_Furry(ShaderToy)**

Grain shader made by **spl!te(GitHub) & martinsh(Personal Blog)**

TV shader made by : **ehj1 (ShaderToy)**

VHS shader made by : **FMS_Cat (ShaderToy)**

VHS glitch shader made by : **keijiro (GitHub)**

VHS pause shader made by : **caaaaaaarter (ShaderToy)**

VHS simple glitch pause shader made by : **Gaktan (ShaderToy)**