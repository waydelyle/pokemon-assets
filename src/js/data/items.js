const {
  vv,
  lcvv,
  slugize,
  assets_dir,
  list_files,
  slug_to_title,
  print_joined_props,
  aliasize,
} = require("../tools");
const fs = require("fs");
const items = require("./../../../node_modules/pokemon-showdown/.data-dist/items")
  .Items;
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

let normalized_data = [];
let smogon_found = [];

(() => {
  for (let [key, item] of Object.entries(items)) {
    let isNonstandard = vv(item, "isNonstandard");
    if (isNonstandard === "CAP") {
      continue;
    }
    let sprite = get_sprite_name(item.name);
    let obj = Object.assign({}, create_base_obj(), item, {
      alias: key,
      sprite: sprite,
      canBeHeld: true,
    });

    normalized_data.push(obj);
    smogon_found.push(sprite);
  }
})();

const pngs_found = list_files(assets_dir + "/img/items", /\.png$/i);

const check_pngs = (filename) => {
  let sprite = filename.replace(/\.png$/i, "");

  if (smogon_found.includes(sprite)) {
    return;
  }

  let obj = Object.assign({}, create_base_obj(), {
    num: -1,
    name: slug_to_title(sprite),
    alias: aliasize(sprite),
    sprite: sprite,
    gen: -1,
    canBeHeld: true,
  });

  normalized_data.push(obj);
};

pngs_found.forEach(check_pngs);

normalized_data.sort((a, b) => {
  if (a.name < b.name) {
    return -1;
  }
  if (a.name > b.name) {
    return 1;
  }
  return 0;
});

module.exports = normalized_data;
