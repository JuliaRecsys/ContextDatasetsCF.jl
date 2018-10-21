function Frappe()::Persa.Dataset
	dataFile = "$(defdir)/frappe/frappe.csv"
	metaFile = "$(defdir)/frappe/meta.csv"

	if !isfile(dataFile) && !isfile(metaFile)
		throw(ArgumentError("Dataset not found, get it on https://github.com/irecsys/CARSKit/blob/master/context-aware_data_sets/Mobile_Frappe.zip"))
	end

	data = CSV.read(dataFile, delim = '\t',
	                      header = [:user, :item, :cnt, :daytime, :weekday, :isweekend, :homework, :cost, :weather, :country, :city],
	                      allowmissing = :none)
	meta= CSV.read(metaFile, delim = '\t',
					header= [:item,:package, :category,:downloads,:developer,:icon,:language,:description, :name, :price, :rating, :short_desc])

	final = join(data,meta, on = :item)

	deleterows!(final,1)

	final[:user] = parse.(Int,final[:user])
	final[:item] = parse.(Int,final[:item])
	#final[:rating] = parse.(Int,final[:rating])

	##print(findfirst( x -> x[11] == "unknown", final))

	return DatasetContext(final)
end


##Gera um dataset dummy com informações de contexto

function createDummyContextDataset()
    df = DataFrame()
    df[:user] = [1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 3, 3, 3, 3, 4, 4, 4, 4, 4, 5, 5, 5, 5, 5, 5, 6, 6, 6, 6, 6, 7, 7, 7]
    df[:item] = [1, 2, 3, 4, 5, 6, 1, 2, 3, 4, 5, 6, 1, 2, 3, 4, 2, 3, 4, 5, 6, 1, 2, 3, 4, 5, 6, 1, 2, 4, 5, 6, 2, 4, 5]
    df[:rating] = [2, 7, 3, 3, 8, 3, 3, 3, 1, 9, 3, 3, 2, 3, 10, 4, 3, 3, 4, 2, 4, 3, 4, 2, 3, 2, 3, 3, 4, 5, 9, 10, 7, 6, 8]
	df[:isWeekend] = [true,false,true,true,false,true,false,true,false,false,true,false,true,true,false,true,false,true,false,false,true,false,true,true,false,true,false,true,false,false,true,false,false,false,true]
	df[:notWeekend] = map(x -> !x,df[:isWeekend])

    return df
end
