const { vv, lcvv, slugize } = require("../../tools");
const fs = require("fs");
const items = require("pokemon-showdown/.data-dist/learnsets").Learnsets;
const nonstandard = require("./nonstandard-pokemon");

//
// print_joined_props(items)
// process.exit(0)

const base_obj = {
  pokemon: null,
  learnset: {},
  eventData: [],
  encounters: [],
  eventOnly: false,
};

const create_base_obj = () => JSON.parse(JSON.stringify(base_obj));

let normalized_data = [];

(() => {
  for (let [key, item] of Object.entries(items)) {
    if (
      nonstandard.includes(key) ||
      ["pokestargiant2", "pokestargiantpropo2"].includes(key)
    ) {
      continue;
    }
    let obj = Object.assign({}, create_base_obj(), item, {
      pokemon: key,
    });

    normalized_data.push(obj);
  }
})();

module.exports = normalized_data;
