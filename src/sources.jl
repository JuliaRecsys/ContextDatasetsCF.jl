function getDataset(url)
	mkpath(defdir)
	path = download(url)
	run(unpack_cmd(path,defdir,".zip", ""))
end

function getFrappe()
	dataFile = "$(defdir)/Mobile_Frappe/frappe/frappe.csv"
	metaFile = "$(defdir)/Mobile_Frappe/frappe/meta.csv"

	isfile(dataFile) && isfile(metaFile) || getDataset("https://github.com/irecsys/CARSKit/blob/master/context-aware_data_sets/Mobile_Frappe.zip?raw=true")

	(dataFile,metaFile)
end

function getMovielens100k()
	file = "$(defdir)/ml-100k/u.data"

	isfile(file) || getDataset("http://files.grouplens.org/datasets/movielens/ml-100k.zip")

	(file)
end

function getMovielens1m()
    file = "$(defdir)/ml-1m/ratings.dat"

	isfile(file) || getDataset("http://files.grouplens.org/datasets/movielens/ml-1m.zip")

	(file)
end
