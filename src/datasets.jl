const defdir = joinpath(dirname(@__FILE__), "..", "datasets")

# Music InCarMusic DONE -> Bugado
# TripAdvisor v1 -> Não tem package pro julia 1.0 (o único era o taro, que está na 0.6)
# TripAdvisor v2 DONE -> Bugado
# Movielens 100k DONE
# Movielens 1m DONE

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

	return dataset
	##ContextCF.DatasetContext(dataset)
end

function TripAdvisorV2()
	filename = getTripAdvisorV2()

	file = CSV.read(filename, delim = ',', types=[ String, Int, Int,String,String,String,String,String,String],allowmissing=:none)

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

function MovieLens1m()::ContextCF.DatasetContext
	filename = getMovielens1m()

	file = CSV.read(filename, delim = "::",
							header = [:user, :item, :rating, :timestamp],
							types = [Int, Int, Int, Int],
							allowmissing = :all)

	file[:item] = labelencode(labelmap(file[:item]), file[:item])

	return ContextCF.DatasetContext(file)
end



##Gera um dataset dummy com informações de contexto
function createDummyContextDataset()
    df = DataFrame()
    df[:user] = [1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 3, 3, 3, 3, 4, 4, 4, 4, 4, 5, 5, 5, 5, 5, 5, 6, 6, 6, 6, 6, 7, 7, 7]
    df[:item] = [1, 2, 3, 4, 5, 6, 1, 2, 3, 4, 5, 6, 1, 2, 3, 4, 2, 3, 4, 5, 6, 1, 2, 3, 4, 5, 6, 1, 2, 4, 5, 6, 2, 4, 5]
    df[:rating] = [2, 7, 3, 3, 8, 3, 3, 4, 1, 9, 3, 3, 2, 3, 10, 4, 3, 3, 4, 2, 4, 3, 4, 2, 3, 2, 3, 3, 4, 5, 9, 10, 7, 6, 8]
	df[:isWeekend] = [true,false,true,missing,false,missing,false,missing,false,false,true,false,true,missing,false,true,missing,true,false,false,missing,false,true,true,false,true,false,true,false,false,true,false,false,false,missing]
	df[:notWeekend] = map(x -> !x,df[:isWeekend])

    return df
end
