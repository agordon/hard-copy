# Hard-Copy

This script generates PDF to print and use as hard-copy backup
of important files (e.g. secret keys).

The generated PDF contains QR-Codes for easy restoration, with additional
safety and error-checking/correction measures.

## Using

Simple download the shell script, then run:

    $ hard-copy.sh [FILE]

Will generate `FILE.pdf` which all the needed information.
Print this file and keep it safe.

## Example

See the [Example PDF](./example/encoding/example.pdf?raw=true).

See the [Examples](./examples/) directory for detailed example.

## Required software

* [qrencode](http://fukuchi.org/works/qrencode/index.html.en)
* [zbar-tools](http://zbar.sourceforge.net/)
* [pdflatex](https://www.tug.org/texlive/)

Optional:

* [gpg](https://www.gnupg.org/)
* [gimp](http://www.gimp.org/)
* [ImageMagick](http://www.imagemagick.org/)

Installation on Debian/Ubuntu:

    $ sudo apt-get install qrencode zbar-tools texlive-latex-base gimp imagemagick


## License

Copyright (C) 2014 by Assaf Gordon (assafgordon@gmail.com)

The shell script is released under MIT license.

## Contact

Assaf Gordon (assafgordon@gmail.com)

https://github.com/agordon/hard-copy
