const items = require("./../../../node_modules/pokemon-showdown/.data-dist/pokedex").Pokedex;

let non_standard_list = [];
for (let [key, item] of Object.entries(items)) {
  if (item.num < 0) {
    non_standard_list.push(key);
  }
}

module.exports = non_standard_list;
