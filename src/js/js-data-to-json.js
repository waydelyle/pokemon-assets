const fs = require("fs");
const {output_dir} = require("./tools");
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

if (!fs.existsSync(output_dir + "/learnsets")) {
  fs.mkdirSync(output_dir + "/learnsets")
}
learnsets.forEach((learnset) => {
  fs.writeFileSync(
    output_dir + "/learnsets/" + learnset.pokemon + ".json",
    JSON.stringify(learnset, null, 2)
  );
});
console.log(Object.keys(learnsets).length + " learnsets written.");

// TODO: add hasLearnset: true/false to each pokemon.

fs.writeFileSync(
  output_dir + "/pokemon.json",
  JSON.stringify(pokemon, null, 2)
);
console.log(pokemon.length + " pokemon written.");
