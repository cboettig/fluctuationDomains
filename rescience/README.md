### [ReScience C](https://rescience.github.io/) Submission for [Re] Fluctuation Domains 

This directory contains the RMarkdown Dynamic Document sources, [article.Rmd], for
generating this reproducible reproduction.  A number of LaTeX template files and font
files taken from the ReScience C template have been included, and the Rmarkdown
file will use these to generate the pdf automatically when rendered (e.g. with the `knit`)
button in RStudio, or merely run `make`. The template Makefile has been adapted as well.
This requires `R` be installed, along with the `rmarkdown` package and the original R 
package (fluctuationDomains) contained in this repository root. 

When the RMarkdown is built (rendered), it will re-runs all computation 
required for both simulations and generation of figures. To facilitate faster rendering,
computational results will be cached in `article_cache` following the standard RMarkdown approach.
Simply delete this directory to re-generate results from scratch, or run `make clean`.  



#### Usage

For a submission, fill in information in
[metadata.yaml](./metadata.yaml), modify [content.tex](content.tex)
and type:

```bash
$ make 
```

This will produce an `article.pdf` using xelatex and provided font. Note that you must have Python 3 and [PyYAML](https://pyyaml.org/) installed on your computer, in addition to `make`.


After acceptance, you'll need to complete [metadata.yaml](./metadata.yaml) with information provided by the editor and type again:

```bash
$ make
```

