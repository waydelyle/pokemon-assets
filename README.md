# pokemon-assets

Essential Pokémon assets for any kind of project: menu sprites, fonts, JSON data, SASS/CSS spritesheet and more.

## Install

You can either clone this project or install it in your project with npm or yarn:

```
npm install pokemon-assets
```

or

```
yarn add pokemon-assets
```

## Contents

- All Pokémon menu icon sprites up to Gen 8, with their shiny version.
- Icon sprites for items, ribbons, marks and UI symbols.
- Sprite sheets for all sprite sets, with CSS and SASS files.
- PkIcon JS React component.
- Data of the essential metagame info (abilities, items, moves, natures, pokemon, learn sets).
- JS Data API wrapper class.
- SVG images for type symbols and other UI elements.
- Fonts from the GBC, GBA and DS games.
- Music of the most relevant game events.
- Audio effects for typical game actions.

## Asset Reference

You can check all available assets in the following [reference pages](https://itsjavi.com/pokemon-assets).

### JSON Data

- [Pokémon](https://itsjavi.com/pokemon-assets/assets/data/pokemon.json)
- [Abilities](https://itsjavi.com/pokemon-assets/assets/data/abilities.json)
- [Items](https://itsjavi.com/pokemon-assets/assets/data/items.json)
- [Moves](https://itsjavi.com/pokemon-assets/assets/data/moves.json)
- [Move Learn Sets](https://itsjavi.com/pokemon-assets/assets/data/learnsets/bulbasaur.json) (example)
- [Natures](https://itsjavi.com/pokemon-assets/assets/data/natures.json)
- [Types](https://itsjavi.com/pokemon-assets/assets/data/types.json)
- [Egg Groups](https://itsjavi.com/pokemon-assets/assets/data/egg-groups.json)

You can find all data under [assets/data](https://github.com/itsjavi/pokemon-assets/tree/master/assets/data).

### Imagery and CSS

- [Pokémon](https://itsjavi.com/pokemon-assets/ref/pokemon)
- [Shiny Pokémon](https://itsjavi.com/pokemon-assets/ref/pokemon/shiny)
- [Items](https://itsjavi.com/pokemon-assets/ref/items)
- [Pokémon Marks](https://itsjavi.com/pokemon-assets/ref/marks) (from Sword and Shield)
- [Ribbons](https://itsjavi.com/pokemon-assets/ref/ribbons)
- [Symbols](https://itsjavi.com/pokemon-assets/ref/symbols)

### Other Resources
- [Fonts](https://github.com/itsjavi/pokemon-assets/tree/master/assets/fonts)
- [Audios](https://github.com/itsjavi/pokemon-assets/tree/master/assets/audio)
- [SVG Images](https://github.com/itsjavi/pokemon-assets/tree/master/assets/svg)
- [JS React components](https://github.com/itsjavi/pokemon-assets/tree/master/assets/js/components)
- [JS Data API wrapper](https://github.com/itsjavi/pokemon-assets/tree/master/assets/js/data-api)
- [CSS spritesheet files](https://github.com/itsjavi/pokemon-assets/tree/master/assets/css)
- [SASS spritesheet files](https://github.com/itsjavi/pokemon-assets/tree/master/assets/sass)


## Maintenance

The only dependencies you need to maintain this project are git, zsh, Docker and
the ability to run `make` commands. The most important ones are:


- `make install`: initializes the project dependencies, needed to build the assets.
- `make build`: builds the assets.
- `make publish-pages`: publishes the current assets to the gh-pages branch
- `make publish-npm`: publishes the current assets to npm with the current package.json version


## Credits

Created by [@route1rodent](https://route1rodent.com) with the help of other projects:

- Menu Icon Sprites: [msikma/pokesprite](https://github.com/msikma/pokesprite)
- Some SVGs from: [zukan.pokemon.co.jp](https://zukan.pokemon.co.jp)
- Data sources: [smogon/pokemon-showdown](https://github.com/smogon/pokemon-showdown/tree/master/data),
[veekun/pokedex](https://github.com/veekun/pokedex)

## License

This software is copyrighted and licensed under the
[MIT license](https://github.com/itsjavi/pokemon-assets/LICENSE).

### Disclaimer

This software comes bundled with data and graphics extracted from the
Pokémon series of video games. Some terminology from the Pokémon franchise is
also necessarily used within the software itself. This is all the intellectual
property of Nintendo, Creatures, inc., and GAME FREAK, inc. and is protected by
various copyrights and trademarks.

The authors believe that the use of this intellectual property for a fan reference
is covered by fair use and that the software is significantly impaired without said
property included. Any use of this copyrighted property is at your own legal risk.

This software is not affiliated in any way with Nintendo,
Pokémon or any other game company.

A complete revision history of this software is available in Github
[https://github.com/itsjavi/pokemon-assets](https://github.com/itsjavi/pokemon-assets)
