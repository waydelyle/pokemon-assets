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
const items = require("./../../../node_modules/pokemon-showdown/.data-dist/learnsets")
  .Learnsets;

//
// print_joined_props(items)
// process.exit(0)

const base_obj = {
  learnset: {},
  eventData: [],
  encounters: [],
  eventOnly: false,
};

const create_base_obj = () => JSON.parse(JSON.stringify(base_obj));

let normalized_data = {};

(() => {
  for (let [key, item] of Object.entries(items)) {
    normalized_data[key] = Object.assign({}, create_base_obj(), item);
  }
})();

module.exports = normalized_data;
