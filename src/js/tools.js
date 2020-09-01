/**
 * @param data
 * @param path
 * @param defaultValue
 * @returns {string|null}
 */
const vv = (data, path, defaultValue = null) => {
  let val = path.split('.').reduce((o, i) => o === undefined ? o : o[i], data);
  return val === undefined ? defaultValue : val;
}

/**
 * @param data
 * @param path
 * @param defaultValue
 * @returns {string|null}
 */
const lcvv = (data, path, defaultValue = null) => {
  let val = path.split('.').reduce((o, i) => o === undefined ? o : o[i], data);
  return val === undefined ? defaultValue : val.toLowerCase();
}

const print_joined_props = (items) => {
  let allProps = {};
  for (let [key, value] of Object.entries(items)) {
    allProps = Object.assign({}, allProps, value);
  }
  console.log(JSON.stringify(allProps));
}

const slugize = (str) => str
  .replace(/\s/g, '-')
  .replace(/'/g, '')
  .toLowerCase();

module.exports = {
  'vv': vv,
  'lcvv': lcvv,
  'slugize': slugize,
  'print_joined_props': print_joined_props,
  'assets_dir': __dirname + "/../../assets",
  "output_dir": __dirname + "/../../assets/data"
}
