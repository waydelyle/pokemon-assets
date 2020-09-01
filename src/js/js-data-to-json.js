const fs = require('fs')
const {output_dir} = require('./tools')
const items = require('./data/items')

fs.writeFileSync(output_dir + '/items.json', JSON.stringify(items, null, 2));
console.log(items.length + " items written.");
