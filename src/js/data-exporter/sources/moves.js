const { vv, slugize } = require("../../tools");
const fs = require("fs");
const items = require("pokemon-showdown/.data-dist/moves").Moves;

//
// print_joined_props(items)
// process.exit(0)

const base_obj = {
  num: 0,
  name: null,
  alias: null,
  slug: null,
  desc: null,
  shortDesc: null,
  type: null,
  basePower: 0,
  accuracy: 0,
  pp: 0,
  category: null,
  priority: 0,
  flags: {
    contact: 0,
    protect: 0,
  },
  isZ: null,
  critRatio: 0,
  secondary: {
    chance: 0,
    self: {
      boosts: {},
    },
  },
  target: null,
  isNonstandard: null,
  contestType: null,
  drain: [],
  boosts: {},
  zMove: {
    boost: {},
  },
  volatileStatus: null,
  condition: {
    noCopy: true,
    duration: 0,
    onResidualOrder: 0,
  },
  multihit: [],
  sideCondition: null,
  self: {
    boosts: {},
  },
  stallingMove: true,
  selfSwitch: true,
  ignoreImmunity: false,
  useSourceDefensiveAsOffensive: true,
  maxMove: {
    basePower: 0,
  },
  recoil: [],
  noSketch: true,
  ignoreDefensive: true,
  ignoreEvasion: true,
  forceSwitch: true,
  selfBoost: {
    boosts: {},
  },
  nonGhostTarget: null,
  status: null,
  isFutureMove: true,
  smartTarget: true,
  damage: 0,
  terrain: null,
  selfdestruct: null,
  pseudoWeather: null,
  noFaint: true,
  breaksProtect: true,
  secondaries: [],
  ohko: null,
  useTargetOffensive: true,
  willCrit: true,
  isMax: true,
  ignoreAbility: true,
  weather: null,
  slotCondition: null,
  heal: [],
  realMove: null,
  hasCrashDamage: true,
  pressureTarget: null,
  noMetronome: [],
  mindBlownRecoil: true,
  defensiveCategory: null,
  thawsTarget: true,
  noPPBoosts: true,
  sleepUsable: true,
  tracksTarget: true,
  stealsBoosts: true,
  struggleRecoil: true,
  multiaccuracy: true,
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
