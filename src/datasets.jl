const defdir = joinpath(dirname(@__FILE__), "..", "datasets")

# Music InCarMusic
# TripAdvisor v1, v2
# Movielens

function InCarMusic()
	filename = getInCarMusic()

	file = CSV.read(filename, delim= ",", missingstring="NA")

	ContextCF.DatasetContext(file)
end

function TripAdvisorV2()
	filename = getTripAdvisorV2()

	file = CSV.read(filename, delim= ',', types=[ String, Int, Int,String,String,String,String,String,String],allowmissing=:none)

	CSV.rename!(file,:UserID => :user, :Rating => :rating, :ItemID => :item)

	file[:item] = labelencode(labelmap(file[:item]), file[:item])
	file[:user] = labelencode(labelmap(file[:user]), file[:user])

	return file
	# ContextCF.DatasetContext(file)
end



function MovieLens()::ContextCF.DatasetContext
	filename = getMovielens100k()

	file = CSV.read(filename, delim = '	',
	                      header = [:user, :item, :rating, :timestamp],
	                      allowmissing = :none)

	return ContextCF.DatasetContext(file)
end

function MovieLens1m()::ContextDatasetsCF.DatasetContext
	filename = getMovielens1m()

	file = CSV.read(filename, delim = '	',
	                      header = [:user, :item, :rating, :timestamp],
						  types = [Int,Int,Int,timestamp],
	                      allowmissing = :none)

	return ContextCF.DatasetContext(file)
end



##Gera um dataset dummy com informações de contexto
function createDummyContextDataset()
    df = DataFrame()
    df[:user] = [1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 3, 3, 3, 3, 4, 4, 4, 4, 4, 5, 5, 5, 5, 5, 5, 6, 6, 6, 6, 6, 7, 7, 7]
    df[:item] = [1, 2, 3, 4, 5, 6, 1, 2, 3, 4, 5, 6, 1, 2, 3, 4, 2, 3, 4, 5, 6, 1, 2, 3, 4, 5, 6, 1, 2, 4, 5, 6, 2, 4, 5]
    df[:rating] = [2, 7, 3, 3, 8, 3, 3, 3, 1, 9, 3, 3, 2, 3, 10, 4, 3, 3, 4, 2, 4, 3, 4, 2, 3, 2, 3, 3, 4, 5, 9, 10, 7, 6, 8]
	df[:isWeekend] = [true,false,true,missing,false,missing,false,missing,false,false,true,false,true,missing,false,true,missing,true,false,false,true,false,true,true,false,true,false,true,false,false,true,false,false,false,missing]
	df[:notWeekend] = map(x -> !x,df[:isWeekend])

    return df
end
