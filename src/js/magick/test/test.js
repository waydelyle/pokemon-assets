const ImageMagick = require('./../ImageMagick')
const {list_files, regex_png} = require('./../../tools');
const img_dir = __dirname + '/imgs';

Promise
  .all(
    list_files(img_dir, regex_png)
      .map((f) => new ImageMagick(img_dir + '/' + f))
  )
  //.then((fileInfos) => console.log(fileInfos))
  .then((imgs) => {
    const srcFiles = imgs.map((f) => f.file).join(' ')
    return (new ImageMagick(srcFiles)).tiledMontage(__dirname + '/montage.png')
  })
  .then((im) => im.trim())
;
