const util = require('util');
const exec = util.promisify(require('child_process').exec);

/**
 * @param {string} file
 * @constructor
 */
function ImageMagick(file) {
  this.file = file;
  this._info = null;
}

/**
 * Executes a shell command and return it as a Promise.
 * @param cmd {string}
 * @return {Promise<string>}
 */
ImageMagick.prototype.exec = async function (cmd) {
  return exec('magick ' + cmd);
};

/**
 * @param {string} args
 * @returns {Promise<string>}
 */
ImageMagick.prototype.identify = function (args) {
  return this.exec(`identify ${args} ${this.file}`);
};

/**
 * @param {string} format
 * @returns {Promise<string>}
 */
ImageMagick.prototype.identifyFormat = function (format) {
  return this.identify(`-format "${format}"`);
};

/**
 * @returns {{ext: string, file: string, avg: number, bytes: number, name: string, width: number, dir: string, height: number}}
 */
ImageMagick.prototype._fetchInfo = async function () {
  if (this._info !== null) {
    return this._info;
  }
  // https://imagemagick.org/script/escape.php
  this._info = await this.identifyFormat('%w:%h:%B:%t:%e:%d')
    .then((out) => {
      const [w, h, size] = out.stdout.split(':').map((n) => parseInt(n))
      const [_w, _h, _size, basename, extension, dir] = out.stdout.split(':')

      return {
        file: this.file,
        dir: dir,
        name: basename,
        ext: extension,
        bytes: size,
        width: w,
        height: h,
        avg: Math.max(Math.round((w + h) / 2), Math.abs(w - h))
      }
    });
  return this._info;
};

/**
 * @param {string} args
 * @returns {Promise<ImageMagick>}
 */
ImageMagick.prototype.mogrify = function (args) {
  return this.exec(`mogrify ${args} ${this.file}`)
    .then(() => new ImageMagick(this.file))
};

ImageMagick.prototype.capSize = function (maxWidth, maxHeight) {
  return this.mogrify(`-resize "${maxWidth}x${maxHeight}"`)
};

ImageMagick.prototype.trim = function () {
  return this.mogrify('-trim')
};

/**
 * @param {string} dest
 * @param {string} args
 * @returns {Promise<ImageMagick>}
 */
ImageMagick.prototype.montage = function (dest, args) {
  return this.exec(`montage ${args} ${this.file} ${dest}`).then((out) => {
    return new ImageMagick(dest);
  });
};

ImageMagick.prototype.tiledMontage = function (
  dest, tilesPerRow = 10, padding = 1, gravity = 'Center', background = 'none'
) {
  return this.montage(
    dest,
    `-background ${background} -tile ${tilesPerRow}x -geometry +${padding}+${padding}`
  );
};

module.exports = ImageMagick;
