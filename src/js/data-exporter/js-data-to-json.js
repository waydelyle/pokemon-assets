const fs = require("fs");
const {output_dir} = require("./tools");
const abilities = require("./sources/abilities");
const items = require("./sources/items");
const learnsets = require("./sources/learnsets");
const moves = require("./sources/moves");
const pokemon = require("./sources/pokemon");

fs.writeFileSync(
  output_dir + "/abilities.json",
  JSON.stringify(abilities, null, 2)
);
console.log(Object.keys(abilities).length + " abilities written.");

fs.writeFileSync(output_dir + "/items.json", JSON.stringify(items, null, 2));
console.log(Object.keys(items).length + " items written.");

fs.writeFileSync(output_dir + "/moves.json", JSON.stringify(moves, null, 2));
console.log(Object.keys(moves).length + " moves written.");

if (!fs.existsSync(output_dir + "/learnsets")) {
  fs.mkdirSync(output_dir + "/learnsets");
}

const pkm_with_learnsets = [];

learnsets.forEach((learnset) => {
  fs.writeFileSync(
    output_dir + "/learnsets/" + learnset.pokemon + ".json",
    JSON.stringify(learnset, null, 2)
  );
  if (pokemon[learnset.pokemon] === undefined) {
    throw new Error(
      "Found undefined pokemon alias in learnsets:" + learnset.pokemon
    );
  }
  pokemon[learnset.pokemon].hasLearnset = true;
  pkm_with_learnsets.push(learnset.pokemon);
});

fs.writeFileSync(
  output_dir + "/pokemon.json",
  JSON.stringify(pokemon, null, 2)
);
Object.keys(pokemon).forEach((alias) => {
  if (!pkm_with_learnsets.includes(alias)) {
    console.info(
      "Info: Pokemon with alias '" + alias + "' has no separated learnset."
    );
  }
});
console.log(Object.keys(pokemon).length + " pokemon written.");
