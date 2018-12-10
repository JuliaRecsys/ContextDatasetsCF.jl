using Documenter
using ContextDatasetsCF

makedocs(
    sitename = "ContextDatasetsCF",
    format = :html,
    modules = [ContextDatasetsCF]
)

makedocs(
    modules = [ContextDatasetsCF],
    format = :html,
    sitename = "ContextDatasetsCF.jl",
    authors = "Paulo Xavier, Filipe Braida and contributors.",
    # analytics = "UA-128580038-1",
    pages    = Any[
        "Introduction"   => "index.md"
    ]
)

deploydocs(
    repo = "github.com/JuliaRecsys/ContextDatasetsCF.jl.git",
    target = "build",
    deps = nothing,
    make = nothing,
    julia  = "1.0",
)
