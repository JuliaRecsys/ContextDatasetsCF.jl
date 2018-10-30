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
