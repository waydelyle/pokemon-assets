const {
  vv,
  lcvv,
  slugize,
  assets_dir,
  list_files,
  titleize,
  print_joined_props,
  aliasize,
} = require("../tools");
const fs = require("fs");
const items = require("./../../../node_modules/pokemon-showdown/.data-dist/abilities")
  .Abilities;

//
// print_joined_props(items)
// process.exit(0)

const base_obj = {
  name: null,
  num: 0,
  desc: null,
  shortDesc: null,
  isNonstandard: null,
  rating: 0,
  onModifyTypePriority: 0,
  onBasePowerPriority: 0,
  onDamagingHitOrder: 0,
  suppressWeather: false,
  onResidualOrder: 0,
  onResidualSubOrder: 0,
  onAllyBasePowerPriority: 0,
  onCriticalHit: false,
  onModifyMovePriority: 0,
  onModifyAtkPriority: 0,
  onModifySpAPriority: 0,
  isUnbreakable: false,
  onSourceModifyAccuracyPriority: 0,
  onAnyBasePowerPriority: 0,
  onDamagePriority: 0,
  onFoeBasePowerPriority: 0,
  condition: {
    duration: 0,
  },
  onAllyModifyAtkPriority: 0,
  onAllyModifySpDPriority: 0,
  onModifyDefPriority: 0,
  onSourceBasePowerPriority: 0,
  onModifyWeightPriority: 0,
  onTryHitPriority: 0,
  onAnyInvulnerabilityPriority: 0,
  onFractionalPriorityPriority: 0,
  onFractionalPriority: 0,
  onTryEatItemPriority: 0,
  onModifyAccuracyPriority: 0,
  onAnyFaintPriority: 0,
  onBeforeMovePriority: 0,
  onDragOutPriority: 0,
  onSourceModifyAtkPriority: 0,
  onSourceModifySpAPriority: 0,
  onFoeTryEatItem: false,
};
const create_base_obj = () => JSON.parse(JSON.stringify(base_obj));

let normalized_data = {};

(() => {
  for (let [key, item] of Object.entries(items)) {
    let isNonstandard = vv(item, "isNonstandard");
    if (isNonstandard === "CAP") {
      continue;
    }
    normalized_data[key] = Object.assign({}, create_base_obj(), item, {
      alias: key,
      slug: slugize(item.name),
    });
  }
})();

module.exports = normalized_data;
