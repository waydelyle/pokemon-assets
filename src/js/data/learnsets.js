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
const items = require("./../../../node_modules/pokemon-showdown/.data-dist/learnsets").Learnsets;

//
// print_joined_props(items)
// process.exit(0)

const base_obj = {
  pokemon: null,
  learnset: {},
  eventData: [],
  encounters: [],
  eventOnly: false
};

const create_base_obj = () => JSON.parse(JSON.stringify(base_obj));

let normalized_data = [];

(() => {
  for (let [key, item] of Object.entries(items)) {
    let obj = Object.assign({}, create_base_obj(), item, {
      pokemon: key
    });

    normalized_data.push(obj);
  }
})();

module.exports = normalized_data;
