<!--
  Copyright (c) 2023 Michael Federczuk
  SPDX-License-Identifier: CC-BY-SA-4.0
-->

# Personal LaTeX Templates #

## About ##

This is a small collection of personal $\LaTeX$ templates that I mostly just use for school work.

The template files are located in the directory [`templates/`](templates).

## Usage ##

The [`copy-template`](copy-template) script takes in two arguments: the first one is the template source and
the second is the target file.  
If the source argument contains any forward slashes (`/`) it is interpreted as a path to the template file.  
If the source argument does **not** contain any slashes, then the template is taken from
the path `$XDG_DATA_HOME/latex-templates/templates/[SOURCE].tex`.

Any comments that start with **two** percent signs instead of just one (`%%`) are "template-only" comments and will be
removed when the template is copied to its target.  
If a line contains nothing but a template-only comment, then that entire line will be removed.

The existing templates files from the directory [`templates/`](templates) have to be manually installed into
the directory `$XDG_DATA_HOME/latex-templates/templates/` to use them.

## License ##

Generally, the templates are published into the public domain under [**CC0**](LICENSES/CC0-1.0.txt), though different
licenses apply for individual files.  
For more information about copying and licensing, see the [`COPYING.txt`](COPYING.txt) file.
