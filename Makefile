raw_data:
	mkdir raw_data/
	wget http://www.fcag.org/documents/tj/Admissions_Data_2009.xls -O data/Admissions_Data_2009.xls
	wget http://www.fcag.org/documents/tj/Admissions_Data_2010.xls -O data/Admissions_Data_2010.xls
	wget http://www.fcag.org/documents/tj/Admissions_Data_2011.xls -O data/Admissions_Data_2011.xls


data:
	mkdir data/


data/tjadm_all_2009_2011.csv: raw_data/Admissions_Data_2009.xls raw_data/Admissions_Data_2010.xls raw_data/Admissions_Data_2011.xls
	Rscript readin_admissions_data.R


preprocess: data data/tjadm_all_2009_2011.csv


clean:
	rm -rf data/
