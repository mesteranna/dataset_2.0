
<!-- README.md is generated from README.Rmd. Please edit that file -->

# The dataset R Package <a href='https://dataset.dataobservatory.eu/'><img src='man/figures/logo.png' align="right" /></a>

<!-- badges: start -->

[![rhub](https://github.com/dataobservatory-eu/dataset/actions/workflows/rhub.yaml/badge.svg)](https://github.com/dataobservatory-eu/dataset/actions/workflows/rhub.yaml)
[![lifecycle](https://lifecycle.r-lib.org/articles/figures/lifecycle-experimental.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![Project Status:
WIP](https://www.repostatus.org/badges/latest/wip.svg)](https://www.repostatus.org/#wip)
[![CRAN_Status_Badge](https://www.r-pkg.org/badges/version/dataset)](https://cran.r-project.org/package=dataset)
[![CRAN_time_from_release](https://www.r-pkg.org/badges/ago/dataset)](https://cran.r-project.org/package=dataset)
[![Status at rOpenSci Software Peer
Review](https://badges.ropensci.org/553_status.svg)](https://github.com/ropensci/software-review/issues/553)
[![DOI](https://zenodo.org/badge/DOI/10.32614/CRAN.package.dataset.svg)](https://zenodo.org/record/6950435#.YukDAXZBzIU)
[![devel-version](https://img.shields.io/badge/devel%20version-0.3.4017-blue.svg)](https://github.com/dataobservatory-eu/dataset)
[![dataobservatory](https://img.shields.io/badge/ecosystem-dataobservatory.eu-3EA135.svg)](https://dataobservatory.eu/)
[![Codecov test
coverage](https://codecov.io/gh/dataobservatory-eu/dataset/graph/badge.svg)](https://app.codecov.io/gh/dataobservatory-eu/dataset)
<!-- badges: end -->

The aim of the *dataset* package is to make tidy datasets easier to
release, exchange and reuse. It organizes and formats data frame R
objects into well-referenced, well-described, interoperable datasets
into release and reuse ready form.

<!---
&#10;The primary aim of dataset is create well-referenced, well-described, interoperable datasets from data.frames, tibbles or data.tables that translate well into the W3C DataSet definition within the [Data Cube Vocabulary](https://www.w3.org/TR/vocab-data-cube/) in a reproducible manner. The data cube model in itself is is originated in the _Statistical Data and Metadata eXchange_, and it is almost fully harmonized with the Resource Description Framework (RDF), the standard model for data interchange on the web^[RDF Data Cube Vocabulary, W3C Recommendation 16 January 2014  <https://www.w3.org/TR/vocab-data-cube/>, Introduction to SDMX data modeling <https://www.unescap.org/sites/default/files/Session_4_SDMX_Data_Modeling_%20Intro_UNSD_WS_National_SDG_10-13Sep2019.pdf>].
&#10;--->

You can install the latest CRAN release with
`install.packages("dataset")`, and the latest development version of
dataset with `remotes::install_github()`:

``` r
install.packages("dataset")
remotes::install_github("dataobservatory-eu/dataset", build = FALSE)
```

The current version of the `dataset` package is in an early,
experimental stage. You can follow the discussion of this package on
[rOpenSci \#553](https://github.com/ropensci/software-review/issues/553)
about the original scope, that included the datacube data model, and the
[rOpenSci \#681](https://github.com/ropensci/software-review/issues/681)
on the new version that moves the data cube data model of SDMX into a
future downstream package. (See, again, the
[Motivation](https://dataset.dataobservatory.eu/articles/Motivation.html)
article.)

Interoperability and future (re)usability depends on the amount and
quality of the metadata that was generated, recorded, and released
together with the data. The `dataset` package aims to collect such
metadata and record them in the least possible intrusive way.

## Semantically richer data frames

Let’s take a simple data.frame from the datasets package. The “Growth of
Orange Trees” dataset contains 35 rows and 3 columns that record the
growth of orange trees.

``` r
library(datasets)
head(datasets::Orange)
#>   Tree  age circumference
#> 1    1  118            30
#> 2    1  484            58
#> 3    1  664            87
#> 4    1 1004           115
#> 5    1 1231           120
#> 6    1 1372           142
```

Following the tidy data principle, we create an unambiguous row
identifier. Then we go three steps further:

1.  We add more semantic information about the meaning of the variables,
    for example, to avoid joining numeric variables of the same type
    (numeric or integer) but different unit of measure (mm vs cm.)

``` r
library(dataset)
data("orange_df")
orange_df
#> Draper N, Smith H (1998). "Growth of Orange Trees."
#>    rowid      tree       age        circumference
#>    <hvn_lbl_> <hvn_lbl_> <hvn_lbl_> <hvn_lbl_>   
#>  1 orange:1   2 [1]       118        30          
#>  2 orange:2   2 [1]       484        58          
#>  3 orange:3   2 [1]       664        87          
#>  4 orange:4   2 [1]      1004       115          
#>  5 orange:5   2 [1]      1231       120          
#>  6 orange:6   2 [1]      1372       142          
#>  7 orange:7   2 [1]      1582       145          
#>  8 orange:8   4 [2]       118        33          
#>  9 orange:9   4 [2]       484        69          
#> 10 orange:10  4 [2]       664       111          
#> # ℹ 25 more rows
```

``` r
var_unit(orange_df$circumference)
#> [1] "milimeter"
```

The `dataset_df` behaves as expected from a data.frame-like object.

``` r
summary(orange_df)
#> Draper N, Smith H (1998). "Growth of Orange Trees."
#> The age of the tree (days since 1968/12/31)
#> circumference at breast height (milimeter)
#>     rowid                tree        age         circumference  
#>  Length:35          Min.   :1   Min.   : 118.0   Min.   : 30.0  
#>  Class :character   1st Qu.:2   1st Qu.: 484.0   1st Qu.: 65.5  
#>  Mode  :character   Median :3   Median :1004.0   Median :115.0  
#>                     Mean   :3   Mean   : 922.1   Mean   :115.9  
#>                     3rd Qu.:4   3rd Qu.:1372.0   3rd Qu.:161.5  
#>                     Max.   :5   Max.   :1582.0   Max.   :214.0
```

2.  We add more descriptive metadata to make the dataset easier to find
    and reuse:

``` r
print(get_bibentry(orange_df), "BibTex")
#> @Misc{,
#>   title = {Growth of Orange Trees},
#>   author = {N.R. Draper and H Smith},
#>   year = {1998},
#>   identifier = {https://doi.org/10.5281/zenodo.14917851},
#>   publisher = {Wiley},
#>   contributor = {Antal Daniel [dtm]},
#>   date = {1998},
#>   language = {en},
#>   relation = {:unas},
#>   format = {:unas},
#>   rights = {:tba},
#>   description = {The Orange data frame has 35 rows and 3 columns of records of the growth of orange trees.},
#>   type = {DCMITYPE:Dataset},
#>   datasource = {https://isbnsearch.org/isbn/9780471170822},
#>   coverage = {:unas},
#> }
```

3.  We add provenance metadata to increase the trust and usability of
    the dataset. This feature is highly experimental at this point and
    will be further developed considering usability and new use cases.

``` r
provenance(orange_df)
#> [1] "<http://example.com/dataset_prov.nt> <http://www.w3.org/1999/02/22-rdf-syntax-ns#type> <http://www.w3.org/ns/prov#Bundle> ."                  
#> [2] "<http://example.com/dataset#> <http://www.w3.org/1999/02/22-rdf-syntax-ns#type> <http://www.w3.org/ns/prov#Entity> ."                         
#> [3] "<http://example.com/dataset#> <http://www.w3.org/1999/02/22-rdf-syntax-ns#type> <http://purl.org/linked-data/cube#DataSet> ."                 
#> [4] "<http://viaf.org/viaf/84585260> <http://www.w3.org/1999/02/22-rdf-syntax-ns#type> <http://www.w3.org/ns/prov#Agent> ."                        
#> [5] "\"_:smithh\" <http://www.w3.org/1999/02/22-rdf-syntax-ns#type> <http://www.w3.org/ns/prov#Agent> ."                                           
#> [6] "<https://doi.org/10.32614/CRAN.package.dataset> <http://www.w3.org/1999/02/22-rdf-syntax-ns#type> <http://www.w3.org/ns/prov#SoftwareAgent> ."
#> [7] "<http://example.com/creation> <http://www.w3.org/1999/02/22-rdf-syntax-ns#type> <http://www.w3.org/ns/prov#Activity> ."                       
#> [8] "<http://example.com/creation> <http://www.w3.org/ns/prov#generatedAtTime> \"2025-02-24T16:23:08Z\"^^<xs:dateTime> ."
```

1.  **Increase FAIR use of your datasets**: Offer a way to better
    utilise the `utils:bibentry` bibliographic entry objects to offer
    more comprehensive and standardised descriptive metadata utilising
    the
    [DCTERMS](https://www.dublincore.org/specifications/dublin-core/dcmi-terms/)
    and
    [DataCite](https://datacite-metadata-schema.readthedocs.io/en/4.6/)
    standards. This will lead to a higher level of findability and
    accessibility, and a better use of the rOpenSci package
    [RefManageR](https://docs.ropensci.org/RefManageR/). See for more
    information the [Bibentry for FAIR
    datasets](https://dataset.dataobservatory.eu/articles/bibentry.html)
    vignette.
2.  **Interoperability outside R**: Extending the `haven_labelled` class
    of the `tidyverse` for consistently labelled categorical variables
    with linked (standard) definitions and units of measures in our
    [defined](https://dataset.dataobservatory.eu/articles/defined.html)
    class; this enables to share metadata not only about the dataset as
    a whole, but about its key components (rows and columns), including
    precise definitions, units of measures. This results in a higher
    level of interoperability and reusability, within and outside of the
    R ecossytem.
3.  **Tidy data tidier, richer**: Offering a new data frame format,
    `dataset_df` that extends tibbles with semantically rich metadata,
    ready to be shared on open data exchange platforms and in data
    repositories. This s3 class is aimed at developers and we are
    working on several packages that provide interoperability with SDMX
    statistical data exchange platforms, Wikidata, or the EU Open Data
    portal. Read more in the [Create Datasets that are Easy to Share
    Exchange and
    Extend](https://dataset.dataobservatory.eu/articles/dataset_df.html)
    vignette.
4.  Adding provenance metadata to make your dataset easier to reuse by
    making its history known to future users. We have no vignette on
    this topic, but you find at the bottom of this `README` an example.
5.  **Releasing and exchanging datasets**: The [From R to
    RDF](https://dataset.dataobservatory.eu/articles/rdf.html) vignette
    shows how to leverage the capabilities of the *dataset* package with
    [rdflib](https://docs.ropensci.org/rdflib/index.html), an
    R-user-friendly wrapper on rOpenSci to work with the *redland*
    Python library for performing common tasks on RDF data, such as
    parsing and converting between formats including rdfxml, turtle,
    nquads, ntriples, creating RDF graphs, and performing SPARQL
    queries.

Putting it all together: the
[Motivation](https://dataset.dataobservatory.eu/articles/Motivation.html)
explains in a long case study why `tidyverse` and the *tidy data
principle* is no longer sufficient for a high level of interoperability
and reusability.

## Semantically richer data frame columns

It is important to see that we do not only increase the semantics of the
dataset as a whole, but also the semantics of each variable. R users
often have a problem with the reusability of their data frames because,
by default, a variable is only described by a programmatically usable
name label.

When working with datasets that receive their components from different
linked open data sources, it is particularly important to have a more
precise semantic definition and description of each variable.

``` r
gdp_1 <- defined(
  c(3897, 7365),
  label = "Gross Domestic Product",
  unit = "million dollars",
  definition = "http://data.europa.eu/83i/aa/GDP"
)

# Summarise this semantically better defined vector:
summary(gdp_1)
#> Gross Domestic Product (million dollars)
#>    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
#>    3897    4764    5631    5631    6498    7365

# See its attributes under the hood:
attributes(gdp_1)
#> $label
#> [1] "Gross Domestic Product"
#> 
#> $class
#> [1] "haven_labelled_defined" "haven_labelled"         "vctrs_vctr"            
#> [4] "double"                
#> 
#> $unit
#> [1] "million dollars"
#> 
#> $definition
#> [1] "http://data.europa.eu/83i/aa/GDP"
```

## Dataset Provenance

The constructor of the `dataset_df` objects also records the most
important processes that created or modified the dataset. This
experimental feature has not been fully developed in the current
*dataset* version. The aim is to provide a standard way of describing
the processes that help to understand what happened with your data using
the W3C [PROV-O](https://www.w3.org/TR/prov-o/) provenance ontology and
the [RDF 1.1 N-Triples](https://www.w3.org/TR/n-triples/) W3C standard
for describing these processes in a flat file.

``` r
provenance(orange_df)
#> [1] "<http://example.com/dataset_prov.nt> <http://www.w3.org/1999/02/22-rdf-syntax-ns#type> <http://www.w3.org/ns/prov#Bundle> ."                  
#> [2] "<http://example.com/dataset#> <http://www.w3.org/1999/02/22-rdf-syntax-ns#type> <http://www.w3.org/ns/prov#Entity> ."                         
#> [3] "<http://example.com/dataset#> <http://www.w3.org/1999/02/22-rdf-syntax-ns#type> <http://purl.org/linked-data/cube#DataSet> ."                 
#> [4] "<http://viaf.org/viaf/84585260> <http://www.w3.org/1999/02/22-rdf-syntax-ns#type> <http://www.w3.org/ns/prov#Agent> ."                        
#> [5] "\"_:smithh\" <http://www.w3.org/1999/02/22-rdf-syntax-ns#type> <http://www.w3.org/ns/prov#Agent> ."                                           
#> [6] "<https://doi.org/10.32614/CRAN.package.dataset> <http://www.w3.org/1999/02/22-rdf-syntax-ns#type> <http://www.w3.org/ns/prov#SoftwareAgent> ."
#> [7] "<http://example.com/creation> <http://www.w3.org/1999/02/22-rdf-syntax-ns#type> <http://www.w3.org/ns/prov#Activity> ."                       
#> [8] "<http://example.com/creation> <http://www.w3.org/ns/prov#generatedAtTime> \"2025-02-24T16:23:08Z\"^^<xs:dateTime> ."
```

## Code of Conduct

Please note that the `dataset` package is released with a [Contributor
Code of
Conduct](https://contributor-covenant.org/version/2/1/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.

Furthermore, [rOpenSci Community Contributing
Guide](https://contributing.ropensci.org/) - *A guide to help people
find ways to contribute to rOpenSci* is also applicable, because
`dataset` is under software review for potential inclusion in
[rOpenSci](https://github.com/ropensci/software-review/issues/553).
