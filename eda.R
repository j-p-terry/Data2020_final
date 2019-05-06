police <- read.csv("acs_police_clean.csv")
mean(police$share_black)
library(dplyr)
library(ggplot2)
death.counts <- count(police, raceethnicity)
death.pcts <- death.counts
death.pcts$n <- death.counts$n/sum(death.counts$n)
barplot(death.counts$n, names.arg = death.counts$raceethnicity)

means <- police %>%
  select('share_black','share_hispanic','share_white') %>%
  summarise_all(funs(mean))

means = means/100
subset.death.pcts <- filter(death.pcts,raceethnicity %in% c('White','Black','Hispanic/Latino'))
subset.death.pcts$n1 <- c(means[1,'share_black'],means[1,'share_hispanic'],means[1,'share_white'])



ggplot(data = subset.death.pcts)+
  geom_bar(stat="identity", aes(x = raceethnicity, y=n1, fill = "Share of Population"))+
  geom_bar(stat="identity", aes(x = raceethnicity, y=n, fill="Share of Deaths"), width = .5) +
  xlab("Race/Ethnicity") +
  ylab("Proportions")
ggplot() +
  geom_bar(data = police,aes(x = raceethnicity)) +
  xlab("Race/Ethnicity")

pop_means <- mean(police[,c('share_black','share_hispanic','share_white')])

ggplot() +
  geom_bar(data = police, aes(x = month)) +
  xlab("Month")

race.counts.nat_bucket <- police %>%
  group_by(nat_bucket) %>%
  count(raceethnicity)

counts.nat_bucket <- count(police, nat_bucket)

merged.nat_bucket <- inner_join(race.counts.nat_bucket, counts.nat_bucket, by = "nat_bucket")

race.pcts.nat_bucket <- race.counts.nat_bucket
race.pcts.nat_bucket$n <- as.numeric(merged.nat_bucket$n.x)/as.numeric(merged.nat_bucket$n.y)


ggplot()+
  geom_bar(data = police, aes(x = armed))

ggplot() + 
  geom_bar(data = police, aes(x = armed, fill = raceethnicity))

ggplot() +
  geom_bar(data = police, aes(x = gender))

ggplot(data = race.pcts.nat_bucket) +
  geom_bar(stat= "identity",aes(x=nat_bucket,y =n, fill= raceethnicity)) +
  xlab("National Income Bucket of Tract")

tbl <- table(police$armed, police$raceethnicity)
chisq.test(tbl)
ggplot(data = police) +
  geom_point(aes(x = Poverty, y = p_income, color = raceethnicity)) +
  ylab("Personal Income of Tract") +
  xlab("Poverty Rate of Tract")

ggplot(data = police) +
  geom_boxplot(aes(x = raceethnicity, y = p_income)) +
  ylab("Personal Income of Tract") + 
  xlab("Race/Ethnicity")

unarmed <- police %>%
  filter(armed == "No") 

unarmed <- unarmed %>%
  count(raceethnicity) %>%
  mutate(pcts = n / nrow(unarmed))


ggplot() +
  geom_bar(stat = "identity", data = unarmed, aes(x = raceethnicity, y = pcts, fill = "Unarmed")) +
  geom_bar(stat = "identity",data = death.pcts,aes(x = raceethnicity, y =n, fill = "All"), width = .5) +
  xlab("Race/Ethnicity") +
  ylab("Percent")

tbl <- table(police$isBlack, police$hasGun)
chisq.test(tbl)

summary(police$armed)





