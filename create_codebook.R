
## Creating the Codebook for clean dataset

library(tibble)

description_1 = "keeps each person unique"
description_2 = "distinguishes between male/female"
description_3 = "birth year"
description_4 = "undergrad gpa"
description_5 = "LSAT score as collected in 1991 (10-48 point scale)"
description_6 = "if the student graduated law school (yes/no)"
description_7 = "whether the student is fulltime or not."
description_8 = "family income separated by groups (1-5) 1 is the 
lowest range"
description_9 = "the tier of law school the student attended"
description_10 = "the race of the student"
description_11 = "if the student passed the bar exam"
description_12 = "when the student passed the bar, if they did"


clean_codebook <- tibble(
  Variables = c("ID", "gender", "birth_year", "ugpa", "lsat", "grad",
                "fulltime", "fam_inc", "law_school_tier", "race", 
                "pass_bar", "bar_passed_attempt"),
  Descriptions = c(description_1, description_2, 
                   description_3, description_4, 
                   description_5, description_6,
                   description_7, description_8,
                   description_9, description_10,
                   description_11, description_12)
)

write.csv(clean_codebook, "data/clean_codebook.csv", row.names = FALSE)
