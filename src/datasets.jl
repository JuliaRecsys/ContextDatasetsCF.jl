const defdir = joinpath(dirname(@__FILE__), "..", "datasets")

# Music InCarMusic DONE -> Bugado
# TripAdvisor v1 -> Não tem package pro julia 1.0 (o único era o taro, que está na 0.6)
# TripAdvisor v2 DONE -> Bugado
# Movielens 100k DONE
# Movielens 1m DONE

"""
    InCarMusic()::ContextCF.DatasetContext

Return InCarMusic Dataset with Contextual Data.
"""

function InCarMusic()
	filename = getInCarMusic()

	(data,columnName) = XLSX.readtable(filename,"ContextualRating")
	columnName[3] = :rating

	dataset = DataFrame(data,columnName)

	rename!(dataset, :UserID => :user, :ItemID => :item)

	for col in names(dataset)
		dataset[col] = isNA.(dataset[col])
	end

	dataset[:user] = convert(Array{Int}, dataset[:user])
	dataset[:item] = convert(Array{Int}, dataset[:item])
	dataset[:rating] = convert(Array{Int}, dataset[:rating])

	return ContextCF.DatasetContext(unique(dataset,[:item,:user]))
end


"""
    TripAdvisorV2()::ContextCF.DatasetContext

Return TripAdvisorV2 Dataset with Contextual Data.
"""

function TripAdvisorV2()
	filename = getTripAdvisorV2()

	file = CSV.read(filename, delim = ',', types=[ String, Int, Int,String,String,String,String,String,String],allowmissing=:none)

	CSV.rename!(file,:UserID => :user, :Rating => :rating, :ItemID => :item)

	file[:item] = labelencode(labelmap(file[:item]), file[:item])
	file[:user] = labelencode(labelmap(file[:user]), file[:user])

	return ContextCF.DatasetContext(unique(file,[:item,:user]))
end

"""
    MovieLens()::ContextCF.DatasetContext

Return MovieLens 100k Dataset with Contextual Data.

# Example:

julia> dataset = ContextDatasetsCF.MovieLens()
Context Aware Collaborative Filtering Dataset
- users: 943
- items: 1682
- ratings: 100000
- contexts: 1
- contextColumns: ["timestamp"]

Ratings Preference: [1, 2, 3, 4, 5]
"""

function MovieLens()
	filename = getMovielens100k()

	file = CSV.read(filename, delim = '	',
	                      header = [:user, :item, :rating, :timestamp],
	                      allowmissing = :none)

	return ContextCF.DatasetContext(file)
end

"""
    MovieLens1m()::ContextCF.DatasetContext

Return MovieLens 1m Dataset with Contextual Data.

# Example:

julia> dataset = ContextDatasetsCF.MovieLens1m()
Context Aware Collaborative Filtering Dataset
- users: 6040
- items: 3706
- ratings: 1000209
- contexts: 1
- contextColumns: ["timestamp"]

Ratings Preference: [1, 2, 3, 4, 5]
"""

function MovieLens1m()
	filename = getMovielens1m()

	file = CSV.read(filename, delim = "::",
							header = [:user, :item, :rating, :timestamp],
							types = [Int, Int, Int, Int],
							allowmissing = :all)

	file[:item] = labelencode(labelmap(file[:item]), file[:item])

	return file
	# return ContextCF.DatasetContext(file)
end


"""
    dummyDataset()::ContextCF.DatasetContext

Returns a dummy Dataset with Contextual Data for quick testing.

# Example:
julia> dataset = ContextDatasetsCF.dummyDataset()
Context Aware Collaborative Filtering Dataset
- users: 7
- items: 6
- ratings: 35
- contexts: 2
- contextColumns: ["isWeekend", "notWeekend"]


"""
##Gera um dataset dummy com informações de contexto
function dummyDataset()
    df = DataFrame()
    df[:user] = [1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 3, 3, 3, 3, 4, 4, 4, 4, 4, 5, 5, 5, 5, 5, 5, 6, 6, 6, 6, 6, 7, 7, 7]
    df[:item] = [1, 2, 3, 4, 5, 6, 1, 2, 3, 4, 5, 6, 1, 2, 3, 4, 2, 3, 4, 5, 6, 1, 2, 3, 4, 5, 6, 1, 2, 4, 5, 6, 2, 4, 5]
    df[:rating] = [2, 7, 3, 3, 8, 3, 3, 4, 1, 9, 3, 3, 2, 3, 10, 4, 3, 3, 4, 2, 4, 3, 4, 2, 3, 2, 3, 3, 4, 5, 9, 10, 7, 6, 8]
	df[:isWeekend] = [true,false,true,missing,false,missing,false,missing,false,false,true,false,true,missing,false,true,missing,true,false,false,missing,false,true,true,false,true,false,true,false,false,true,false,false,false,missing]
	df[:notWeekend] = map(x -> !x,df[:isWeekend])
	df
    # return ContextCF.DatasetContext(df)
end
