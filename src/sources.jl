function getDataset(url)
	mkpath(defdir)
	path = download(url)
	run(unpack_cmd(path,defdir,".zip", ""))
end

function getInCarMusic()
	file = "$(defdir)/Music_InCarMusic/Data_InCarMusic.xlsx"

	isfile(file) || getDataset("https://github.com/irecsys/CARSKit/blob/master/context-aware_data_sets/Music_InCarMusic.zip?raw=true")

	(file)
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

function getTripAdvisorV2()
    file = "$(defdir)/Travel_TripAdvisor_v2/Data_TripAdvisor_v2.csv"

	isfile(file) || getDataset("https://github.com/irecsys/CARSKit/blob/master/context-aware_data_sets/Travel_TripAdvisor_v2.zip?raw=true")

	(file)
end
