data.police = read.csv('police_killings_cleaned.csv')
data.acs = read.csv('acs2015_census_tract_data.csv')

library(dplyr)
data.full <- inner_join(data.police, data.acs, by = c("geo_id" ="CensusTract"))

write.csv(data.full, "acs_police_merged.csv")

sum(rowSums(is.na(data.full))>0)

count.nas <- colSums(is.na(data.full))
count.nas <- data.frame(count.nas)
PublicWorkNa <- which(is.na(data.full$PublicWork))
df <- data.full[-PublicWorkNa,]

count.nas <- data.frame(colSums(is.na(df)))

data.full <- df
data.full <- subset(data.full,select =-c(streetaddress))

count.nas <- data.frame(colSums(is.na(data.full)))

library(Hmisc)

data.full$ChildPoverty[data.full$ChildPoverty == 0] <- NA
ChildPoverty.null <- which(is.na(data.full$ChildPoverty))
fit <- lm(ChildPoverty ~ Poverty + h_income, data = data.full)
data.full$ChildPoverty[ChildPoverty.null] = predict(fit, newdata = data.full[ChildPoverty.null,])
#Poverty
library(varhandle)
data.full$share_white <- unfactor(data.full$share_white)
data.full$share_black <- unfactor(data.full$share_black)
data.full$share_hispanic <- unfactor(data.full$share_hispanic)
data.full$p_income <- unfactor(data.full$p_income)
data.full$pov <- unfactor(data.full$pov)
data.full$nat_bucket <- as.factor(data.full$nat_bucket)
data.full$county_bucket <- as.factor(data.full$county_bucket)

data.full$isBlack <- as.factor(sapply(data.full$raceethnicity, function(x){
  if (x == "Black"){
    "Yes"
  }
  else{
    "No"
  }
}))

data.full$hasGun <- as.factor(sapply(data.full$armed, function(x){
  if (x == "Firearm"){
    "Yes"
  }
  else{
    "No"
  }
}))

write.csv(data.full, "acs_police_clean.csv")
