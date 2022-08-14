# elm.plugin.zsh

zsh plugin for completion of options and list of packages for [elm](https://elm-lang.org).

## Installation

### [Oh My ZSH!](https://github.com/robbyrussell/oh-my-zsh) custom plugin

Clone `elm.plugin.zsh` into your custom plugins repo and load as a plugin in your `.zshrc`

```shell
git clone https://github.com/kraklin/elm.plugin.zsh.git ~/.oh-my-zsh/custom/plugins/elm
```

```shell
plugins+=(elm)
```

Keep in mind that plugins need to be added before `oh-my-zsh.sh` is sourced.


### [Antigen](https://github.com/zsh-users/antigen)

Bundle `elm.plugin.zsh` in your `.zshrc`

```shell
antigen bundle kraklin/elm.plugin.zsh
```

### [zplug](https://github.com/b4b4r07/zplug)

Load `elm.plugin.zsh` as a plugin in your `.zshrc`

```shell
zplug "kraklin/elm.plugin.zsh"
```

### [zgen](https://github.com/tarjoilija/zgen)

Include the load command in your `.zshrc`

```shell
zget load kraklin/elm.plugin.zsh
```

### Manually

Clone this repository somewhere (`~/.elm.plugin.zsh` for example) and source it in your `.zshrc`

```shell
git clone https://github.com/kraklin/elm.plugin.zsh ~/.elm.plugin.zsh
```

```shell
source ~/.elm.plugin.zsh/elm.plugin.zsh
```

## Usage

This plugin autocompletes the option of `elm` app. Just use tabs.

### Autocompletion of packages

This funcion ***needs [`jq`](https://stedolan.github.io/jq/) to be installed***

To autocompletion for packages to work, you have to get the list of package names. 
There is a function in this plugin for it: `elm-completion-update`. 

```shell
# Get fresh pacckages names from package.elm-lang.org
elm-completion-update
```

## License
[MIT](LICENCE)
