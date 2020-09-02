const {
  vv,
  slugize,
  assets_dir,
  list_files,
  titleize,
  aliasize,
} = require("../../tools");
const fs = require("fs");
const items = require("pokemon-showdown/.data-dist/items").Items;
//
// print_joined_props(items)
// process.exit(0)

const base_obj = {
  num: 0,
  name: null,
  alias: null,
  sprite: null,
  gen: 0,
  desc: null,
  shortDesc: null,
  canBeHeld: false,
  boosts: {
    atk: 0,
    spa: 0,
  },
  fling: {
    basePower: 0,
  },
  naturalGift: {
    basePower: 0,
    type: null,
  },
  condition: {
    duration: 0,
    onSourceModifyAccuracyPriority: 0,
  },
  itemUser: [],
  megaStone: null,
  megaEvolves: null,
  isNonstandard: null,
  onBasePowerPriority: 0,
  isBerry: false,
  zMove: false,
  zMoveFrom: null,
  onModifySpDPriority: 0,
  isPokeball: false,
  onTryHealPriority: 0,
  onResidualOrder: 0,
  onResidualSubOrder: 0,
  onModifyAccuracyPriority: 0,
  isGem: false,
  onMemory: null,
  forcedForme: null,
  onPlate: null,
  zMoveType: null,
  onDrive: null,
  onModifyAtkPriority: 0,
  isChoice: false,
  onModifySpAPriority: 0,
  onFractionalPriorityPriority: 0,
  onAttractPriority: 0,
  onAfterMoveSecondaryPriority: 0,
  onModifyDefPriority: 0,
  onModifyMovePriority: 0,
  ignoreKlutz: false,
  onBoostPriority: 0,
  onDamagePriority: 0,
  onNegateImmunity: false,
  onDamagingHitOrder: 0,
  onTrapPokemonPriority: 0,
  onAfterMoveSecondarySelfPriority: 0,
  onHitPriority: 0,
  onSourceModifyAccuracyPriority: 0,
};

const create_base_obj = () => JSON.parse(JSON.stringify(base_obj));

const get_sprite_name = (item_name, fail_if_not_found = true) => {
  let sprite_name = slugize(item_name);
  if (sprite_name === "stick") {
    sprite_name = "leek";
  } else if (sprite_name.match(/(tr)[0-9]{1,3}/) !== null) {
    sprite_name = "normal-tr";
  } else if (sprite_name.match(/.*um-z$/) !== null) {
    sprite_name = sprite_name + "--held";
  } else if (
    [
      "berserk-gene",
      "berry",
      "bitter-berry",
      "burnt-berry",
      "gold-berry",
      "ice-berry",
      "mint-berry",
      "miracle-berry",
      "mystery-berry",
      "pink-bow",
      "polkadot-bow",
      "prz-cure-berry",
      "psn-cure-berry",
    ].includes(sprite_name)
  ) {
    sprite_name = "unknown-item";
  }

  if (!fail_if_not_found) {
    return sprite_name;
  }

  let sprite_path = assets_dir + "/img/items/" + sprite_name + ".png";
  if (!fs.existsSync(sprite_path)) {
    throw new Error(`sprite not found for ${item_name} in path ${sprite_path}`);
  }

  return sprite_name;
};

let normalized_data = {};
let smogon_found = [];

(() => {
  for (let [key, item] of Object.entries(items)) {
    let isNonstandard = vv(item, "isNonstandard");
    if (isNonstandard === "CAP") {
      continue;
    }
    let sprite = get_sprite_name(item.name);
    normalized_data[key] = Object.assign({}, create_base_obj(), item, {
      alias: key,
      sprite: sprite,
      canBeHeld: true,
    });

    smogon_found.push(key);
  }
})();

const pngs_found = list_files(assets_dir + "/img/items", /\.png$/i);

const check_pngs = (filename) => {
  let sprite = filename.replace(/\.png$/i, "");
  let k = aliasize(sprite);

  if (smogon_found.includes(k)) {
    return;
  }

  if (normalized_data[k] !== undefined) {
    throw new Error(`Object property .${k} already exists`);
  }

  normalized_data[k] = Object.assign({}, create_base_obj(), {
    num: -1,
    name: titleize(sprite),
    alias: k,
    sprite: sprite,
    gen: -1,
    canBeHeld: true,
  });
};

pngs_found.forEach(check_pngs);

module.exports = normalized_data;
