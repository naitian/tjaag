#######
# TJAAG Research & Analysis Committee
# program: admission_data_master.R
# purpose: combine 2009-2011 admission data
# programmer: Lesley Park
# date last modified: 7/20/2020
#######

#install.packages("tidyverse")
library(tidyverse)

#install.packages("arsenal")
library(arsenal)

# setwd("/Volumes/GoogleDrive/My Drive/Personal/TJHSST/TJAAG/datasets")
#getwd()
library(readxl)

tjadm2009<-read_excel("raw_data/Admissions_Data_2009.xls")
tjadm2010<-read_excel("raw_data/Admissions_Data_2010.xls")
tjadm2011<-read_excel("raw_data/Admissions_Data_2011.xls")

colnames(tjadm2009)
#2009 has separate columns for course name/type
colnames(tjadm2010)
setdiff(colnames(tjadm2011),colnames(tjadm2010))
#2011 has one additional variable OVRSTDEC


# 2009 has a GT status variable, but not completely consistent with courses listed
# 2009: no PLACERES, APPFLAG=, COM1_FIN1,  COM1_FIN2,  COM2_FIN1,  COM2_FIN2, GROUPDEC ,  TOTTEST,FINALSCORE

#recode race, 8th grade math
str(tjadm2009)
table(tjadm2009$Ethnic)
tjadm2009x<-tjadm2009

#no american indian/native alaskan; native hawaiian
tjadm2009x$ETHNIC[tjadm2009x$Ethnic=='White'|tjadm2009x$Ethnic=='WHITE']<-1
tjadm2009x$ETHNIC[tjadm2009x$Ethnic=='Black'|tjadm2009x$Ethnic=='BLACK']<-2
tjadm2009x$ETHNIC[tjadm2009x$Ethnic=='Hisp']<-3
tjadm2009x$ETHNIC[tjadm2009x$Ethnic=='Asian']<-5
tjadm2009x$ETHNIC[tjadm2009x$Ethnic=='Undesig'|tjadm2009x$Ethnic=='undesig']<-6
tjadm2009x$ETHNIC[tjadm2009x$Ethnic=='Multi']<-7
summary(freqlist(~ETHNIC+Ethnic, data=tjadm2009x,addNA=TRUE))

#Math in 8 - no data dictionary, doesn't line up with 2010-2011, doesn't line up with course name
table(tjadm2009$'Math-in-8')
table(tjadm2009$'Math-in-8',tjadm2009$Course...22)
table(tjadm2009$Course...22)

# add Semifinal column in 2009

# rename 2009 vars to match 2010 and 2011
tjadm2009x<-tjadm2009x%>% select(GENDER=sex, ETHNIC,
           MATHCL8_2009='Math-in-8', FINALDC='Final decision',
           ENG07=Mark...7, LANG07=Mark...9,
           MATH07=Mark...11, SCI07=Mark...13,SOCST07=Mark...15,
          ENG08_1='Q1 Mark...17',LANG08_1='Q1 Mark...20',
          MATH08_1='Q1 Mark...23', SCI08_1='Q1 Mark...26', SOCST08_1='Q1 Mark...29',
          ENG08_2='Q2 Mark...18',LANG08_2='Q2 mark',
          MATH08_2='Q2 Mark...24', SCI08_2='Q2 Mark...27', SOCST08_2='Q2 Mark...30',
          VERBRS='VR raw',VERBPCT='VR pct', MATHRS='MA raw', MATHPCT='MA  pct',
          COMPPCT='Comp pct', STUGPA=GPA,
          SEMIFINAL=, ESSAY1='Essay 1', ESSAY2='Essay 2',
          SCHYR=...1, GT_2009='GT Status')

tjadm2009x$SEMIFINAL[ is.na(tjadm2009x$FINALDC) ] <- "N"
tjadm2009x$SEMIFINAL[ !is.na(tjadm2009x$FINALDC) ] <- "Y"
# View(tjadm2009x)

#2010, 2011: change >99 to 99.9, <1 to 0.1
str(tjadm2010)
# View(tjadm2010)
tjadm2010x<-tjadm2010

tjadm2010x$VERBPCT[tjadm2010x$VERBPR=='>99']<-99.9
tjadm2010x$VERBPCT[tjadm2010x$VERBPR=='< 1']<-0.1
tjadm2010x$VERBPCT<- ifelse(is.na(tjadm2010x$VERBPCT),as.numeric(tjadm2010x$VERBPR),tjadm2010x$VERBPCT)
summary(freqlist(~VERBPR+VERBPCT, data=tjadm2010x,addNA=TRUE))

tjadm2010x$MATHPCT[tjadm2010x$MATHPR=='>99']<-99.9
tjadm2010x$MATHPCT[tjadm2010x$MATHPR=='< 1']<-0.1
tjadm2010x$MATHPCT<- ifelse(is.na(tjadm2010x$MATHPCT),as.numeric(tjadm2010x$MATHPR),tjadm2010x$MATHPCT)
summary(freqlist(~MATHPR+MATHPCT, data=tjadm2010x,addNA=TRUE))

tjadm2010x$COMPPCT[tjadm2010x$COMPPR=='>99']<-99.9
tjadm2010x$COMPPCT[tjadm2010x$COMPPR=='< 1']<-0.1
tjadm2010x$COMPPCT<- ifelse(is.na(tjadm2010x$COMPPCT),as.numeric(tjadm2010x$COMPPR),tjadm2010x$COMPPCT)
summary(freqlist(~COMPPR+COMPPCT, data=tjadm2010x,addNA=TRUE))

#drop old PR vars
tjadm2010x<-select(tjadm2010x,-c(VERBPR, MATHPR, COMPPR))

#repeat for 2011
tjadm2011x<-tjadm2011
tjadm2011x$VERBPCT[tjadm2011x$VERBPR=='>99']<-99.9
tjadm2011x$VERBPCT[tjadm2011x$VERBPR=='< 1']<-0.1
tjadm2011x$VERBPCT<- ifelse(is.na(tjadm2011x$VERBPCT),as.numeric(tjadm2011x$VERBPR),tjadm2011x$VERBPCT)
summary(freqlist(~VERBPR+VERBPCT, data=tjadm2011x,addNA=TRUE))

tjadm2011x$MATHPCT[tjadm2011x$MATHPR=='>99']<-99.9
tjadm2011x$MATHPCT[tjadm2011x$MATHPR=='< 1']<-0.1
tjadm2011x$MATHPCT<- ifelse(is.na(tjadm2011x$MATHPCT),as.numeric(tjadm2011x$MATHPR),tjadm2011x$MATHPCT)
summary(freqlist(~MATHPR+MATHPCT, data=tjadm2011x,addNA=TRUE))

tjadm2011x$COMPPCT[tjadm2011x$COMPPR=='>99']<-99.9
tjadm2011x$COMPPCT[tjadm2011x$COMPPR=='< 1']<-0.1
tjadm2011x$COMPPCT<- ifelse(is.na(tjadm2011x$COMPPCT),as.numeric(tjadm2011x$COMPPR),tjadm2011x$COMPPCT)
summary(freqlist(~COMPPR+COMPPCT, data=tjadm2011x,addNA=TRUE))

tjadm2011x<-select(tjadm2011x,-c(VERBPR, MATHPR, COMPPR))

#combine 3 years of admission data together
tjadm_all<-bind_rows(tjadm2009x,tjadm2010x,tjadm2011x)
# View(tjadm_all)

#create variable for graduation year (lines up with how data are organized on fcag website)
table(tjadm_all$SCHYR)
tjadm_all$class[tjadm_all$SCHYR=='2004-05']<-2009
tjadm_all$class[tjadm_all$SCHYR=='2005-2006']<-2010
tjadm_all$class[tjadm_all$SCHYR=='2006-2007']<-2011
summary(freqlist(~SCHYR+class, data=tjadm_all,addNA=TRUE))


summary(freqlist(~SEMIFINAL+GROUPDEC+OVRSTDEC+FINALDC, data=tjadm_all,addNA=TRUE))
tjadm_all$admit_summary<-paste(tjadm_all$SEMIFINAL,tjadm_all$GROUPDEC, tjadm_all$OVRSTDEC, tjadm_all$FINALDC, sep='/')
# View(tjadm_all)
colnames(tjadm_all)
tjadm_all<-select(tjadm_all,class, SCHYR, PLACERES, GENDER, ETHNIC, FINALDC, admit_summary, APPFLAG,
                  MATHCL8_2009, MATHCL8,
                  ENG07, LANG07, MATH07, SCI07, SOCST07,
                  ENG08_1, LANG08_1, MATH08_1, SCI08_1, SOCST08_1,
                  ENG08_2, LANG08_2, MATH08_2, SCI08_2, SOCST08_2,
                  VERBRS, VERBPCT, MATHRS, MATHPCT, COMPPCT,
                  STUGPA, GT_2009, TOTTEST,
                  ESSAY1, ESSAY2,
                  COM1_FIN1, COM1_FIN2, COM2_FIN1, COM2_FIN2,
                  SEMIFINAL, OVRSTDEC, GROUPDEC, FINALSCORE)

write_csv(tjadm_all,path='data/tjadm_all_2009_2011.csv')

