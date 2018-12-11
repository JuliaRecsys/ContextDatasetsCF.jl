[![](https://img.shields.io/badge/docs-dev-blue.svg)](https://juliarecsys.github.io/ContextDatasetsCF.jl/latest/)
[![Build Status](https://travis-ci.org/JuliaRecsys/ContextDatasetsCF.jl.svg?branch=master)](https://travis-ci.org/JuliaRecsys/ContextDatasetsCF.jl)
[![codecov](https://codecov.io/gh/JuliaRecsys/ContextDatasetsCF.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/JuliaRecsys/ContextDatasetsCF.jl)

# DatasetsCF.jl - Collection of Collaborative Datasets

**Installation**: at the Julia REPL, `Pkg.add("ContextDatasetsCF")` or in Pkg3 `add ContextDatasetsCF`

## Example

```
julia> using ContextDatasetsCF

julia> dataset = ContextDatasetsCF.Frappe();

julia> using Persa

julia> using Statistic

julia> μ = mean(dataset)
3.52986
```

## Datasets

List of package datasets:

soon
