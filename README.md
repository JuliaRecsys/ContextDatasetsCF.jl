[![](https://img.shields.io/badge/docs-dev-blue.svg)](https://juliarecsys.github.io/ContextDatasetsCF.jl/latest/)
[![Build Status](https://travis-ci.org/JuliaRecsys/ContextDatasetsCF.jl.svg?branch=master)](https://travis-ci.org/JuliaRecsys/ContextDatasetsCF.jl)
<!---[![codecov](https://codecov.io/gh/JuliaRecsys/ContextDatasetsCF.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/JuliaRecsys/ContextDatasetsCF.jl) -->

# ContextDatasetsCF.jl - Collection of Collaborative Datasets with Contextual Data

**Installation**: at the Julia REPL, `Pkg.add("ContextDatasetsCF")` or in Pkg3 `add ContextDatasetsCF`

## Example

```
julia> using ContextDatasetsCF

julia> dataset = ContextDatasetsCF.MovieLens()
Context Aware Collaborative Filtering Dataset
- users: 943
- items: 1682
- ratings: 100000
- contexts: 1
- contextColumns: ["timestamp"]

Ratings Preference: [1, 2, 3, 4, 5]
```

## Datasets

List of package datasets:

- MovieLens 100k/1m;
- InCarMusic;
- TripAdvisor.
