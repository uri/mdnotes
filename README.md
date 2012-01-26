MDNotes
========

## Requirements

Requires `rdiscount` and `pdfkit` for pdf utility.

-----

## Install

To install `gem install mdnotes`.
To uninstall `gem uninstall mdnotes`.

----
## Basics

"Using a terminal, `cd` into the directory you want to takes notes.

Use command `mdnotes` to create a notes directory.

Create your markdown (.md) in the `md/` directory.

Use `mdnotes` to 'compile' your notes into html. These will be located in the html/ folder.

Use `mdnotes -p` or `mdnotes --publish` to create pdf's of your notes. These will be located in the pdf/ folder.

If you want to include images in your notes you can place them in the images folder located under `./html/images`. Use `![alt-text](./images/my_image.png)` to reference an image.


----
## Creating PDFs

You might need to install [WKHTMLTOPDF](https://github.com/jdpace/PDFKit/wiki/Installing-WKHTMLTOPDF) for the pdf publishing to work.

    curl -O http://wkhtmltopdf.googlecode.com/files/wkhtmltopdf-0.9.9-OS-X.i368
    mv wkhtmltopdf-0.9.9-OS-X.i368 /usr/local/bin/wkhtmltopdf
    chmod +x /usr/local/bin/wkhtmltopdf

____

You can find out more about [me](http://urigorelik.info/).
