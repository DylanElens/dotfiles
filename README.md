# Hyprland Dotfiles

These are my current Hyprland dotfiles, which are the configuration files that I use to customize my Hyprland installation. These files include my shell configuration, my editor configuration, my window manager configuration, and my various other preferences.

## Screenshots

Here are some screenshots of my desktop, configured with these dotfiles:


![image](https://github.com/DylanElens/dotfiles/assets/16319495/336b0cab-9abf-4c1e-9c43-f76aa1b4d31c)
![image](https://github.com/DylanElens/dotfiles/assets/16319495/2951b9e6-e416-4ee9-bb66-910ebc22fcea)

## Dependencies

The following dependencies are required to use these dotfiles:

* Hyprland
* Zsh
* Oh-My-Zsh
* Nerd Font
* Waybar
* swaylock
* zathura
* Dunst
* Rofi
* Lazygit
* Lazydocker
* Kitty
* tmux
* stow

## Installation

To install these dotfiles, clone the repository to your home directory:

```
git clone https://github.com/DylanElens/dotfiles.git ~/.dotfiles
```

Then, run the following command to install the dotfiles using GNU Stow:

```
stow  ~/.dotfiles/*
```

## Usage

To use the dotfiles, simply start your session as usual. The dotfiles will be loaded automatically. after you
have stowed them

## Contributing

If you would like to contribute to these dotfiles, please feel free to open a pull request.

## License

These dotfiles are licensed under the MIT License.
