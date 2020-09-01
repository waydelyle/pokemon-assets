const {vv, lcvv, slugize, assets_dir} = require('../tools')
const fs = require('fs')
const items = require('./../../../node_modules/pokemon-showdown/.data-dist/items').Items;

const get_sprite_name = (item_name) => {
  let sprite_name = slugize(item_name);
  if (sprite_name === 'stick') {
    return 'leek';
  }
  if (sprite_name.match(/(tr)[0-9]{1,3}/) !== null) {
    return 'normal-tr';
  }
  if ([
    'berserk-gene',
    'berry', 'bitter-berry', 'burnt-berry', 'gold-berry', 'ice-berry', 'mint-berry', 'miracle-berry', 'mystery-berry',
    'pink-bow', 'polkadot-bow',
    'prz-cure-berry', 'psn-cure-berry'
  ].includes(sprite_name)) {
    return 'unknown-item';
  }
  return sprite_name;
};

let normalized_data = [];

for (let [key, item] of Object.entries(items)) {
  let isNonstandard = vv(item, 'isNonstandard');
  if (isNonstandard === 'CAP') {
    continue;
  }
  let sprite_name = get_sprite_name(item.name);
  let sprite_path = assets_dir + "/img/items/" + sprite_name + ".png";
  if (!fs.existsSync(sprite_path)) {
    throw new Error(`sprite not found: for item ${item.name} in path ${sprite_path}`)
    break;
  }

  let obj = {
    id: item.num,
    name: item.name,
    alias: key,
    sprite: sprite_name,
    description: vv(item, 'desc'),
    description_short: vv(item, 'shortDesc'),
    boots: vv(item, 'boosts'),
    flags: {
      held: true, // all items from smogon data can be held
      legacy: (isNonstandard === 'Past'),
      unreleased: (isNonstandard === 'Unobtainable'),
      mega_stone: vv(item, 'megaStone') !== null,
      berry: vv(item, 'isBerry') === true,
      z_crystal: vv(item, 'zMove') === true,
      gem: vv(item, 'isGem') === true,
      choice: vv(item, 'isChoice') === true,
      pokeball: vv(item, 'isPokeball') === true,
      ignore_klutz: vv(item, 'ignoreKlutz') === true,
      tr: key.match(/^tr[0-9]{1,3}$/i) !== null
    },
    moves: {
      z: {
        move: vv(item, 'zMoveFrom'),
        type: lcvv(item, 'zMoveType')
      },
      fling: {
        base_power: vv(item, 'fling.basePower')
      },
      natural_gift: {
        base_power: vv(item, 'naturalGift.basePower'),
        type: lcvv(item, 'naturalGift.type')
      }
    }
  };
  normalized_data.push(obj);
}

module.exports = normalized_data;
