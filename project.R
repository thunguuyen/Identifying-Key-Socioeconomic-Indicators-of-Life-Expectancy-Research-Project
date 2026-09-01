library(GGally)
library(car)
library(lmtest)
library(dplyr)
library(ggplot2)
data <- read.csv("C:/Users/thuhn/Downloads/Life-Expectancy-Data-Updated.csv")
data$Economy_status_Developed <- factor(data$Economy_status_Developed, levels = c(0, 1), labels = c("Developing", "Developed"))

colnames(data) <- gsub("Thinness_ten_nineteen_years", "Thinness_10_19", colnames(data))
colnames(data) <- gsub("Thinness_five_nine_years", "Thinness_5_9", colnames(data))

#EDA
head(data)
str(data)
summary(data)
#checking for missing values
any(is.na(data))

numeric_columns = sapply(data, is.numeric)
column_names = names(data)[numeric_columns] #17 numeric columns

#exclude Year
column_names <- column_names[column_names != "Year"]

par(mfrow = c(4, 4), mar = c(4, 4, 2, 1))

for (i in 1:16) {
  boxplot(data[[column_names[i]]],
          main = column_names[i],
          col = "lightblue",
          border = "black",
          horizontal = TRUE)
}

par(mfrow = c(4, 4), mar = c(4, 4, 2, 1))

#density plots
for (i in 1:16) {
  
  plot(density(data[[column_names[i]]]),
       main = column_names[i],
       col = "blue",
       lwd = 2,
       xlab = column_names[i],
       ylab = "Density",
       xaxt = "n",
       yaxt = "n")
  
  axis(1, at = seq(min(data[[column_names[i]]]), max(data[[column_names[i]]]),
                   length.out = 5))
  axis(2, las = 2)
}

###### bar plots 



numeric_data <- data[sapply(data, is.numeric)]
cor_matrix = cor(numeric_data)
cor_matrix

ggcorr(numeric_data)

strong_correlations <- cor_matrix[abs(cor_matrix) > 0.7 & abs(cor_matrix) < 1]

#pairs
cor_pairs <- which(abs(cor_matrix) > 0.7 & abs(cor_matrix) < 1, arr.ind = TRUE)

#variable pairs and their correlation values
for (i in 1:nrow(cor_pairs)) {
  row <- cor_pairs[i, 1]
  col <- cor_pairs[i, 2]
  cat(sprintf("Correlation between %s and %s: %.2f\n",
              colnames(cor_matrix)[row],
              colnames(cor_matrix)[col],
              cor_matrix[row, col]))
}


# economy status developing is not necessary since we already have a column to say if it is developing or developed. 
data$Economy_status_Developing <- NULL

# infant death and under 5 deaths are highly correlated with 0.99, we can remove the infant deaths since that is accounted in the under 5 deaths. 
data$Infant_deaths <- NULL

# thinness for children from 5-9 and thinness for adolescents between 10-19 are very correlated with 0.94,
#we can remove them since BMI shows that
data$Thinness_10_19 <- NULL
data$Thinness_5_9 <- NULL
head(data)

numeric_data <- data[sapply(data, is.numeric)]
ggcorr(numeric_data)

cor_matrix = cor(numeric_data)
strong_correlations <- cor_matrix[abs(cor_matrix) > 0.7 & abs(cor_matrix) < 1]
#pairs
cor_pairs <- which(abs(cor_matrix) > 0.7 & abs(cor_matrix) < 1, arr.ind = TRUE)

#variable pairs and their correlation values
for (i in 1:nrow(cor_pairs)) {
  row <- cor_pairs[i, 1]
  col <- cor_pairs[i, 2]
  cat(sprintf("Correlation between %s and %s: %.2f\n",
              colnames(cor_matrix)[row],
              colnames(cor_matrix)[col],
              cor_matrix[row, col]))
}

# Calculate the median of Polio and Diphtheria by Region and Year
data <- data %>%
  group_by(Region, Year) %>%
  mutate(vaccination = median(c(Polio, Diphtheria), na.rm = TRUE)) %>%
  ungroup()

summary(data)

ggplot(data, aes(factor(Region), fill=Economy_status_Developed)) +
  geom_bar()+
  scale_color_brewer(palette = "Accent") +
  labs(title = "Regions Based Off Economic Status",
       x = "Region",
       y = "Count")
ggplot(data, aes(factor(Region), fill=)) +
  geom_bar()+
  scale_color_brewer(palette = "Accent") +
  labs(title = "Regions Based Off Economic Status",
       x = "Region",
       y = "Count")

ggplot(selected_data, aes(x = Hepatitis_B, y = Life_expectancy)) +
  geom_point() +
  geom_smooth(method = "lm", col = "blue") +
  labs(title = "Hepatitis B Immunization vs Life Expectancy",
       x = "Hepatitis B Immunization Rate (%)",
       y = "Life Expectancy (years)")


# Statistical Analysis
# 1. Correlation analysis
cor_matrix <- cor(selected_data %>% 
                    select(Life_expectancy, Hepatitis_B, vaccination, Measles, Incidents_HIV), 
                  use = "complete.obs")
print(cor_matrix)
ggcorr(cor_matrix)
selected_data <- data %>%
  select(Economy_status_Developed, Region, Year, Life_expectancy, Hepatitis_B, vaccination, Measles, Incidents_HIV)
model1 <- lm(Life_expectancy ~ ., data = data)
summary(model1)
anova(model1)
model2 <- lm(Life_expectancy ~ Region + Under_five_deaths + Adult_mortality +
               Alcohol_consumption + BMI + Incidents_HIV + GDP_per_capita + 
               Population_mln + Schooling + Economy_status_Developed, data = data)
anova(model2)
summary(model2)
anova(model1, model2)
selected_data <- data %>%
  select(Economy_status_Developed, Region, Year, Life_expectancy, Hepatitis_B, vaccination, Measles, Incidents_HIV)
model = lm(Life_expectancy ~ Hepatitis_B + vaccination + Measles, data=selected_data)
predicted <- predict(model, selected_data)
summary(model)
par(mfrow=c(1,2))
ggplot(selected_data, aes(x = Life_expectancy, y = predicted, colour=Region)) +
  geom_point(shape=1) +
  geom_abline(slope = 1, intercept = 0, color = "yellow", lwd = 1) +
  labs(title = "Actual vs Predicted Life Expectancy",
       x = "Actual Life Expectancy",
       y = "Predicted Life Expectancy")
ggplot(selected_data, aes(x = Life_expectancy, y = predicted, colour=Economy_status_Developed)) +
  geom_point(shape=1) +
  geom_abline(slope = 1, intercept = 0, color = "yellow", lwd = 1) +
  labs(title = "Actual vs Predicted Life Expectancy",
       x = "Actual Life Expectancy",
       y = "Predicted Life Expectancy")


fitted_models = selected_data %>% group_by(Region) %>% do(model = lm(Life_expectancy ~ Hepatitis_B + vaccination + Measles + Incidents_HIV, data = selected_data))
fitted_models$model
summary(fitted_models)
