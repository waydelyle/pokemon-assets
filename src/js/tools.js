const fs = require("fs");

/**
 * @param data
 * @param path
 * @param defaultValue
 * @returns {string|null}
 */
const vv = (data, path, defaultValue = null) => {
  let val = path
    .split(".")
    .reduce((o, i) => (o === undefined ? o : o[i]), data);
  return val === undefined ? defaultValue : val;
};

const list_files = (dir, fileRegex) => {
  return fs.readdirSync(dir).filter(function (file) {
    return file.match(fileRegex);
  });
};

/**
 * @param data
 * @param path
 * @param defaultValue
 * @returns {string|null}
 */
const lcvv = (data, path, defaultValue = null) => {
  let val = path
    .split(".")
    .reduce((o, i) => (o === undefined ? o : o[i]), data);
  return val === undefined ? defaultValue : val.toLowerCase();
};

const print_joined_props = (items) => {
  let allProps = {};
  for (let [key, value] of Object.entries(items)) {
    allProps = Object.assign({}, allProps, value);
  }
  console.log(JSON.stringify(allProps));
};

const slugize = (str) =>
  str
    .replace(/\s/g, "-")
    .replace(/['’.%:,;+/]/g, "")
    .normalize("NFD")
    .replace(/[\u0300-\u036f]/g, "")
    .toLowerCase();

const titleize = (str) =>
  str
    .replace(/([-_’]|--)/gi, " ")
    .replace(/[ ]+/gi, " ")
    .replace(/\b\w/g, (l) => l.toUpperCase());

const aliasize = (str) => str.replace(/[-_ ]{1,}/gi, "");

module.exports = {
  vv: vv,
  lcvv: lcvv,
  slugize: slugize,
  print_joined_props: print_joined_props,
  assets_dir: __dirname + "/../../../assets",
  output_dir: __dirname + "/../../../assets/data",
  list_files: list_files,
  titleize: titleize,
  aliasize: aliasize,
  regex_png: /.*\.png$/gi
};
