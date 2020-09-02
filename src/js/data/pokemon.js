const {vv, lcvv, slugize, assets_dir, list_files, slug_to_title, print_joined_props, aliasize} = require('../tools')
const fs = require('fs')
const items = require('./../../../node_modules/pokemon-showdown/.data-dist/pokedex').Pokedex;
const base_obj = {
  "num": 0,
  "name": null,
  "alias": null,
  "sprite": null,
  "types": [],
  "genderRatio": {
    "M": 0,
    "F": 0
  },
  "baseStats": {
    "hp": 0,
    "atk": 0,
    "def": 0,
    "spa": 0,
    "spd": 0,
    "spe": 0
  },
  "abilities": {},
  "heightm": 0,
  "weightkg": 0,
  "color": null,
  "evos": [],
  "eggGroups": [],
  "prevo": null,
  "evoLevel": null,
  "otherFormes": [],
  "otherFormesSprites": [],
  "formeOrder": [],
  "canGigantamax": null,
  "baseSpecies": null,
  "forme": null,
  "requiredItem": null,
  "changesFrom": null,
  "evoType": null,
  "gender": null,
  "gen": 0,
  "evoItem": null,
  "evoCondition": null,
  "canHatch": false,
  "evoMove": null,
  "baseForme": null,
  "baseFormeSprite": null,
  "cosmeticFormes": [],
  "cosmeticFormesSprites": [],
  "maxHP": 0,
  "requiredAbility": null,
  "battleOnly": null,
  "requiredMove": null,
  "requiredItems": [],
  "unreleasedHidden": true,
  "cannotDynamax": true
};

const get_sprite_name = (item_name, fail_if_not_found = true) => {
  let sprite_name = slugize(item_name);
  if (sprite_name.match(/-totem/gi) !== null) {
    sprite_name = sprite_name.replace(/-totem/gi, '')
  } else if (sprite_name.match(/^pikachu-(original|hoenn|sinnoh|unova|kalos|alola|partner|world)$/gi) !== null) {
    sprite_name = sprite_name + '-cap';
  } else if (sprite_name === 'xerneas-neutral') {
    sprite_name = 'xerneas'
  } else if (sprite_name === 'minior-meteor') {
    sprite_name = 'minior'
  } else if (['sinistea-antique', 'polteageist-antique'].includes(sprite_name)) {
    sprite_name = sprite_name.replace('-antique', '')
  } else if (['urshifu-rapid-strike'].includes(sprite_name)) {
    sprite_name = 'urshifu'
  } else if (['missingno'].includes(sprite_name)) {
    sprite_name = 'unknown-pokemon'
  } else if (sprite_name.match(/alcremie-(.*)-(cream|swirl)$/gi) !== null) {
    sprite_name = sprite_name + '-plain'
  }

  if (!fail_if_not_found) {
    return sprite_name;
  }

  let sprite_path = assets_dir + "/img/pokemon/" + sprite_name + ".png";
  if (!fs.existsSync(sprite_path)) {
    throw new Error(`sprite not found for ${item_name} in path ${sprite_path}`)
  }

  sprite_path = assets_dir + "/img/pokemon/shiny/" + sprite_name + ".png";
  if (!fs.existsSync(sprite_path)) {
    throw new Error(`sprite not found for ${item_name} in (shiny) path ${sprite_path}`)
  }

  return sprite_name;
};

const expand_species = (key, obj) => {
  if (key.match(/^(frillish|jellicent|hippopotas|hippowdon|pikachu|pyroar|unfezant)$/) !== null) {
    obj.cosmeticFormes = [obj.name + ' F']
    obj.formeOrder = [obj.name, obj.name + ' F']
    return obj
  }

  if (key.match(/alcremie/) !== null) {
    obj.cosmeticFormes.push('Alcremie Vanilla Cream')
    obj.formeOrder.push('Alcremie Vanilla Cream')

    obj.cosmeticFormes = obj.cosmeticFormes.flatMap(
      (forme) => [
        forme,
        forme + ' Berry',
        forme + ' Clover',
        forme + ' Flower',
        forme + ' Love',
        forme + ' Ribbon',
        forme + ' Star',
        forme + ' Strawberry',
      ]
    );
    obj.formeOrder = obj.cosmeticFormes.flatMap(
      (forme) => {
        if (forme === 'Alcremie') {
          return [forme];
        }
        return [
          forme,
          forme + ' Berry',
          forme + ' Clover',
          forme + ' Flower',
          forme + ' Love',
          forme + ' Ribbon',
          forme + ' Star',
          forme + ' Strawberry',
        ]
      }
    );
    return obj;
  }
  return obj
}

let normalized_data = [];
let smogon_found = [];

// print_joined_props(items);
// module.exports = '';
// process.exit(0)

for (let [key, item] of Object.entries(items)) {
  if (item.num <= 0) {
    continue;
  }
  let sprite = get_sprite_name(item.name);
  let obj = Object.assign({}, base_obj, item, {
    alias: key,
    sprite: sprite
  });

  obj = expand_species(key, obj)

  obj.otherFormesSprites = obj.otherFormes.map((forme) => {
    let spr = get_sprite_name(forme)
    smogon_found.push(spr);
    return spr;
  });

  obj.cosmeticFormesSprites = obj.cosmeticFormes.map((forme) => {
    let spr = get_sprite_name(forme)
    smogon_found.push(spr);
    return spr;
  });

  if (obj.baseForme) {
    obj.baseFormeSprite = get_sprite_name(obj.sprite + '-' + obj.baseForme, false)
    smogon_found.push(obj.baseFormeSprite);
  }

  normalized_data.push(obj);
  smogon_found.push(sprite);
}

const pngs_found = list_files(assets_dir + "/img/pokemon", /\.png$/i);
const pngs_found_shiny = list_files(assets_dir + "/img/pokemon/shiny", /\.png$/i);

const check_pngs = (filename) => {
  let sprite_name = filename.replace(/\.png$/i, '');

  if (
    [
      'egg', 'egg-manaphy',
      'unknown-pokemon', 'unknown-pokemon2',
      'genesect--no-drive', 'spinda-blank', 'spinda-filled'
    ].includes(sprite_name)
    || sprite_name.match(/pikachu-(.*-cap|starter)-female/gi) !== null
  ) {
    return;
  }

  if (!smogon_found.includes(sprite_name)) {
    throw new Error(`PNG found for non-registered pokemon ${sprite_name} as file ${filename}`)
  }
};

pngs_found.forEach(check_pngs);
pngs_found_shiny.forEach(check_pngs);

normalized_data.sort((a, b) => {
  if (a.num < b.num) {
    return -1;
  }
  if (a.num > b.num) {
    return 1;
  }
  return 0;
});

module.exports = normalized_data;
