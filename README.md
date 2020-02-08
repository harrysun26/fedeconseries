
<!-- README.md is generated from README.Rmd. Please edit that file -->

# fedeconseries

<!-- badges: start -->

[![Travis build
status](https://travis-ci.org/harrysun26/fedeconseries.svg?branch=master)](https://travis-ci.org/harrysun26/fedeconseries)
[![AppVeyor build
status](https://ci.appveyor.com/api/projects/status/github/harrysun26/fedeconseries?branch=master&svg=true)](https://ci.appveyor.com/project/harrysun26/fedeconseries)
[![Codecov test
coverage](https://codecov.io/gh/harrysun26/fedeconseries/branch/master/graph/badge.svg)](https://codecov.io/gh/harrysun26/fedeconseries?branch=master)
[![License:
MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
<!-- badges: end -->

The goal of fedeconseries is to obtain US federal reserve economic data.
Reserach use only.

## Installation

You can install the released version of fedeconseries from github with:

``` r
#Ordinary: install.packages("fedeconseries") OR(if CRAN not working:)
library(devtools)
install_github("harrysun26/fedeconseries")
```

## Usage

A more detailed example can be found in my vignette:
<https://harrysun26.github.io/fedeconseries/index.html>

## Functions in package:

  - `search_fedeconseries("unemployment", search_type =
    'full_text',realtime_start = NULL, realtime_end = NULL)`
    
    This function returns the unique identifier(economic variable in
    database) used in following functions `get_econ_series` and
    `get_fedeconseries`. Here, we pass keyword “unemployment” into
    function.

  - `get_econ_series("INDPRO", "indpro", observation_start =
    "2009-03-01", observation_end = "2009-03-01")`
    
    This function returns real value(raw data) of economic series. No
    adjustments. Here we pass “INDPRO” as keyword and “indpro” as a
    rename, with observation start and end date.

  - `get_fedeconseries("UNRATE", "unemployment",observation_start =
    "2013-03-01", observation_end = "2013-03-30",realtime_start =
    "2015-02-02", realtime_end = "2015-02-02")`
    
    This function looks up unemployment data of US, with varying
    available date adjustment. Here we pass the keyword “UNRATE”, rename
    as “unemployment”, with observation start and end date, and research
    (real) start and end date.

### Terms of use

When using the FRED© API, you are agreeing to be bound by the FRED© API
Terms of Use, see
<https://research.stlouisfed.org/docs/api/terms_of_use.html>.

## History

  - 02.02.2020: Version 1.0 release

## Example

Please check the “Usage” link above(package vignette).
