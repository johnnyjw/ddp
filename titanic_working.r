titanic_summary <- titanic %>% 
  group_by(Sex, Pclass, Survived) %>% 
  summarise(count = n()) %>% 
  ungroup() %>% 
  spread(Survived, count) %>% 
  rename('Survived'='1') %>% 
  rename('Died'='0') %>% 
  mutate(Total = Died + Survived) %>% 
  mutate(Percent_Survived = (Survived / Total) * 100)

?group_by
