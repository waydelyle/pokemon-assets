const fs = require("fs");
const { output_dir } = require("./tools");
const abilities = require("./data/abilities");
const items = require("./data/items");
const learnsets = require("./data/learnsets");
const moves = require("./data/moves");
const pokemon = require("./data/pokemon");

fs.writeFileSync(
  output_dir + "/abilities.json",
  JSON.stringify(abilities, null, 2)
);
console.log(abilities.length + " abilities written.");

fs.writeFileSync(output_dir + "/items.json", JSON.stringify(items, null, 2));
console.log(items.length + " items written.");

fs.writeFileSync(output_dir + "/moves.json", JSON.stringify(moves, null, 2));
console.log(moves.length + " moves written.");

fs.writeFileSync(
  output_dir + "/pokemon.json",
  JSON.stringify(pokemon, null, 2)
);
console.log(pokemon.length + " pokemon written.");

fs.writeFileSync(
  output_dir + "/learnsets.json",
  JSON.stringify(learnsets, null, 2)
);
console.log(Object.keys(learnsets).length + " learnsets written.");
