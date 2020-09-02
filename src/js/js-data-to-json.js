const fs = require('fs')
const {output_dir} = require('./tools')
const items = require('./data/items')
const pokemon = require('./data/pokemon')

fs.writeFileSync(output_dir + '/items.json', JSON.stringify(items, null, 2));
console.log(items.length + " items written.");

fs.writeFileSync(output_dir + '/pokemon.json', JSON.stringify(pokemon, null, 2));
console.log(pokemon.length + " pokemon written.");
