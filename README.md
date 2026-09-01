# Identifying-Key-Socioeconomic-Indicators-of-Life-Expectancy-Research-Project
Investigates the determinants of life expectancy across different countries using a comprehensive dataset from the World Health Organization (WHO). 
Introduction
Life expectancy is a crucial indicator of a population's overall health and well-being, reflecting the effectiveness of healthcare systems, socioeconomic conditions, and environmental factors. In our project, we analyze a dataset from the World Health Organization (WHO) to explore the various factors that influence life expectancy across countries. The primary objective is to identify key socioeconomic, environmental, and health-related determinants and to assess their relative importance in contributing to variations in life expectancy.
Previous studies have shown that factors such as income, education, healthcare access, and environmental quality can significantly impact life expectancy. However, the interplay between these variables and their collective influence on life expectancy remains complex and multifaceted. This report provides a detailed overview of our methodology, statistical analysis, and the interpretation of our findings. Our study aims to contribute to a deeper understanding of the drivers of life expectancy and to support efforts in enhancing the health and longevity of populations worldwide.




Data Description
Data Source: The dataset is sourced from Kaggle, based on WHO’s updated life expectancy data.
Variables Measured: The dataset includes the following key variables:
Life Expectancy (dependent variable): Average life expectancy of both genders in different years from 2010 to 2015
Region: 179 countries are distributed in 9 regions.
Year: Years observed from 2000 to 2015.
Under_five_deaths: Represents deaths of children under five years old per 1000 population.
Adult_mortality: Represents deaths of adults per 1000 population.
Alcohol_consumption: Represents alcohol consumption that is recorded in liters of pure alcohol per capita with 15+ years olds.
Polio, Diphtheria, Hepatitis_B, Measles: Represents % of coverage of immunization among 1-year-olds.
BMI: Measure of nutritional status in adults.
Incidents_HIV: Incidents of HIV per 1000 population aged 15-49.
GDP_per_capita: GDP per capita in current USD.
Population_mln: Total population in millions
Schooling: Average years that people aged 25+ spent in formal education.
Status: Developed/Developing country
Data Quality: The dataset is complete, with no missing values, which allows for a robust and uninterrupted analysis process. Quality checks confirmed consistent and relevant data entries across all variables.


Exploratory Data Analysis (EDA)
Data Distribution
Density plots of the quantitative variables in the data set were used to show skewness and potential outliers. The only variable with a relatively symmetric distribution is schooling. Many of the variables are multimodal and others are significantly skewed to either the left or right. The underlying distribution and skewness in some of the variables may influence our analysis.




Addressing High Correlation and Multicollinearity
High correlation among predictors can lead to multicollinearity, which affects the model's reliability. When assessing correlations among the predictor variables, we found several pairs with high correlations:
Under-Five Deaths and Infant Deaths: These variables are highly correlated (0.99) because infant deaths (ages 0-1) are a subset of under-five deaths.
Polio and Diphtheria Vaccinations: Both variables represent vaccination rates among 1-year-olds and are commonly administered together, explaining their high correlation.
Thinness Variables: Thinness among children aged 5-9 years and adolescents aged 10-19 years are highly correlated.
Multicollinearity occurs when predictors in a regression model are highly correlated, leading to unstable coefficient estimates. To address this, we used the standardized Generalized Variance Inflation Factor (GVIF), which allows for meaningful comparison across predictors with varying degrees of freedom. Here are our findings and actions taken:
Infant Deaths and Under-Five Deaths
Correlation: 0.99
Action: Removed Infant Deaths to retain Under-Five Deaths, due to their redundancy and high GVIF values.
Thinness Variables
Correlation: High between Thinness (5-9 years) and Thinness (10-19 years).
Action: Removed both thinness variables to retain BMI, simplifying the model while maintaining relevant health indicators.
Vaccination Variables
Correlation: High among Polio and Diphtheria vaccinations.
Action: Created a new composite variable to account for both Polio and Diphtheria vaccinations among 1-year-olds.
By addressing multicollinearity through these actions, we enhanced the stability and interpretability of our regression model, ensuring that the predictors retained provide the most meaningful insights into life expectancy determinants.


Analysis
Health Indicators Impact on Life Expectancy
Analysis of BMI on Life Expectancy
High health indicators, such as BMI, significantly affect life expectancy across all regions. To test the impact of BMI on life expectancy, we performed an ANOVA analysis comparing the full model, which includes all predictors, with a reduced model excluding BMI.
We formulated the following hypotheses:
Null Hypothesis (H0): B_BMI = 0 (BMI does not affect life expectancy). 
Alternative Hypothesis (Ha): B_BMI != 0 (BMI does  affect life expectancy).
To test these hypotheses, we performed an ANOVA analysis comparing a full model that includes the BMI predictor with a reduced model that excludes it.
The results from the ANOVA test showed a highly significant p-value of 2.965e-12, indicating that BMI significantly affects life expectancy. This supports our hypothesis that high BMI negatively impacts life expectancy across all regions.
The p-value indicates that excluding BMI significantly worsens the model fit, confirming that BMI is an important predictor of life expectancy. High BMI negatively impacts life expectancy across all regions, highlighting the need for targeted health interventions to address obesity and related health issues.
Analysis of Alcohol Consumption and Measles Vaccination on Life Expectancy
Health indicators, such as alcohol consumption and measles vaccination, are often considered crucial factors influencing life expectancy. To test their impact, we compared a full model, including all predictors, with a reduced model excluding both alcohol consumption and measles vaccination.
Model Building and Evaluation
We formulated the following hypotheses:
Null Hypothesis (H0): B_AlcoholConsumption = B_Measles = 0 (Alcohol consumption and Measles immunization do not affect life expectancy). 
Alternative Hypothesis (Ha):B_AlcoholConsumption != 0 or B_Measles != 0 (Alcohol consumption and/or Measles immunization affect life expectancy).
To test these hypotheses, we performed an ANOVA analysis comparing a full model that includes both Alcohol consumption and Measles predictors with a reduced model that excludes them.
The ANOVA results showed a non-significant p-value of 0.4501, indicating that neither alcohol consumption nor measles vaccination significantly affects life expectancy in our model.
The p-value of 0.4501 indicates that excluding both alcohol consumption and measles vaccination does not significantly worsen the model fit. Therefore, these factors do not significantly affect life expectancy in our model. This suggests that, within this dataset, other variables may play a more critical role in determining life expectancy.
Vaccinations Impact on Life Expectancy
Vaccinations play a crucial role in public health, potentially impacting life expectancy. To evaluate this, we tested the combined effects of Hepatitis B, Measles, and a composite vaccination variable (Polio and Diphtheria) on life expectancy.
We formulated the following hypotheses:
Null Hypothesis (H0) : B_Hepatitis_B = B_Measles = B_vaccines = 0 (None of the vaccination predictors affect life expectancy).
Alternative Hypothesis (Ha): at least one B != 0 (At least one of the vaccination predictors affects life expectancy).
To test these hypotheses, we performed an ANOVA analysis comparing a full model that includes all vaccination predictors with a reduced model that excludes them.
The ANOVA results are as follows:
F-value: 87.954
p-value: <2.2e-16 (significant)
The highly significant p-value indicates that at least one of the three predictors (Hepatitis B, Measles, or the composite vaccination variable) is useful in predicting life expectancy. This supports the importance of vaccination programs in improving life expectancy across different regions.
Economic Status Impact on Life Expectancy
We will be using multiple linear regression as there are multiple economic status variables. We will analyze the effects of each of the variables on life expectancy. There are two numerical economic status variables which are Schooling and GDP_per_capita. There is one categorical variable called  Developed country(1 or 0). This is a variable that shows 1 if the country is Developed and 0 if the country is not Developed. 
We created a F-test to see if at least one of these Economic predictors has a relationship with life expectancy. We reject the null hypothesis as  the p-value is less than 0.05 . This suggests that there is a statistically significant relationship between life expectancy and at least one predictor. 
We created a Multiple linear regression model(life expectancy ~ GDP_per_capita + Schooling + Developed country). 
Null hypothesis:
Beta1 = 0(There is no relationship between GDP per capita  and life expectancy when the model includes schooling and developed status .)
Beta2 = 0(There is no relationship between  schooling and life expectancy when the model includes developed status and GDP per capita.)
Beta3 = 0(There is no relationship between  developed status and life expectancy when the model includes schooling and GDP per capita.)
Alternative hypothesis: 
Beta1 does not equal 0(There is a relationship between  GDP per capita and life expectancy when the model includes schooling and developed status .)
Beta2  does not equal 0(There is a relationship between   schooling  and life expectancy when the model includes developed status and GDP per capita.)
Beta3 does not equal 0(There is a relationship between  developed status and life expectancy when the model includes schooling and GDP per capita.)

We reject the null hypothesis(Beta1 =0) because the p-value is less than 0.01. This means there is enough evidence to suggest a relationship between life expectancy and  GDP per capita when the model includes the  country's developed status and schooling .
We reject the null hypothesis(Beta2 =0) because the p-value is less than 0.01. This means there is enough evidence to suggest a relationship between life expectancy and schooling when the model includes the  country's developed status and GDP per capita.
We fail to reject the null hypothesis(Beta3 =0) because the p-value is greater than 0.01. This means there is not enough evidence to suggest a relationship between life expectancy and whether a country is developed when the model includes schooling and GDP per capita.
Sequential (or extra) sums of squares & Partial R-squared:



Calculations:
SSR(X2|X1) = SSR(X1,X2) - SSR(X1) = 145404 - 86112 = 59292 
SSR(X1,X2) = 86112 + 59292 = 145404
SSR(X1,X2,X3) = 86112 + 59292 + 39 =145443
SSR(X3|X1,X2) = 39 
Partial R-squared (X3|X1,X2) = (39/107872)*100 = 0.03615396%
Partial R-squared (X2|X1) = (59292/158893)*100 = 35.47%
Findings:
X1 was GDP_per_capita as this is the most important Economic status factor compared to the rest. 
When Economy_status_Developed is added to the model containing GDP_per_capita and Schooling, SSE is reduced by 0.036%. 
When Schooling is added to the model containing GDP_per_capita , SSE is reduced by 35.47%.
Correlation and multicollinearity:

VIF values for all the predictors are less than 5, this means multicollinearity is not a significant issue in this model.
48.6% of the variability in Economy_status_Developed can be attributed to its correlation with the other predictors in the model (GDP_per_capita and Schooling)
Transformation:
We realized that the relationship between  GDP_per_capita vs life expectancy is not linear. We used a  logarithmic transformation on  GDP_per_capita. 

Using the all the information above we were able to create an improved regression model:

This is a multiple linear regression model( life expectancy~ log(GDP_per_capita) + Schooling + log(GDP_per_capita) * Schooling). The new model explains 20% more variation in life_expectancy than the first regression model. 
This also shows that the interaction term log transformation of  GDP_per_capita has a statistically significant relationship with life_expectancy. It also shows that the interaction term log transformation of  GDP_per_capita * Schooling has a statistically significant relationship with life_expectancy. 


Best Subset Regression
A linear regression model was fitted onto the entire data set, using Life_expectancy as the response variable. 

All of the predictors besides Population_mln, Measles, and Alcohol_consumption were statistically significant. The adjusted r-squared of the model is 0.984. The model is complex since the model was fitted onto 21 variables, which risks problems such as overfitting and unreliable coefficient estimates. Due to this, best subset regression was used for feature selection and to help deal with the complexity of fitting a model onto a large data set.
After running best subset regression, the following model had the highest adjusted R^2 (0.9823), lowest BIC (-11492.85) and Cp (316.3309) values was: 
Life_expectancy = B0 + RegionEuropean Union + RegionOceania + RegionSouth America + Under_five_deaths + Adult_mortality + GDP_per_capita + StatusDeveloping
where Central America and Caribbean is the reference category of the Region variable and developed is the reference category of the Status variable. This means the most significant features are region, under five deaths, adult mortality, GDP per capita, and status.



The adjusted R-squared is 0.9607, meaning the model explains 96.07% of the variability in life expectancy. The R-squared of the original model using the entire dataset is 0.9842. This model is much simpler as there are only 7 variables compared to 21.
Model Predictions 
Using the best subset regression model we found, We split the dataset into a training set (80%) and a test set (20%) using a random split. After the model was trained on the training set, we found a training MAE of 0.7951. This is the average amount by which the predicted life expectancy values deviate from the actual values, in absolute units of the 
target variable (Life_expectancy). 
The unit measurement for Life_expectancy is years, so, on average, the training model's predictions are off by 0.7951 years (or about 9.5 months) from the actual values of Life_expectancy in the training data.
Additionally, predictions were made using new, unseen data from a test set. The best subset model yielded an MAE of 0.8024. This suggests that on average, the model is off by about 9-10 months in its predictions when seeing new data. This means the model is performing reasonably well on both the training and test set.
Conclusion
This study aimed to identify and analyze key factors influencing life expectancy across different regions, utilizing a comprehensive dataset from the World Health Organization (WHO). Through exploratory data analysis and various statistical models, we found that socioeconomic, health, and environmental factors collectively contribute to variations in life expectancy.
Our analysis demonstrated the significant impact of key health indicators, such as Body Mass Index (BMI) and vaccination rates on life expectancy. Specifically, BMI was found to negatively affect life expectancy, highlighting the importance of addressing obesity and related health issues. Vaccination coverage, including Hepatitis B, Measles, and a composite measure for Polio and Diphtheria, also played a significant role, underscoring the value of immunization programs in improving public health and longevity.
Economic factors, particularly GDP per capita and schooling, were found to have substantial relationships with life expectancy. While the country’s developed status did not show a significant impact when controlling for GDP and education, the relationship between economic development and life expectancy remains a crucial area for policy focus.
Our regression modeling indicated that a significant portion of the variability in life expectancy could be explained by these predictors, with improvements seen through transformations such as the logarithmic transformation of GDP per capita. Additionally, the best subset regression analysis helped identify a simplified, robust model with high predictive power, demonstrating the importance of factors such as under-five deaths, adult mortality, and regional socioeconomic status in explaining life expectancy differences.
Despite applying transformations such as square root, log, and Box-Cox to address non-normality and heteroscedasticity in the data, the assumptions of linear regression were not fully satisfied. The square root and log transformations were insufficient for correcting the skewness in some variables, and the residuals still exhibited non-normality. Although the Box-Cox transformation is more flexible, it did not result in a suitable normalization of the data. Additionally, the transformations did not adequately address issues with outliers, which continued to affect the model's fit. As a result, these transformations were not enough to stabilize variance or improve the overall regression assumptions, indicating that alternative modeling approaches, such as non-linear regression or robust regression techniques, may be necessary.
In summary, the study highlights the complex, multifactorial nature of life expectancy and emphasizes the importance of integrated health, economic, and social policies aimed at improving longevity. The findings from this analysis provide valuable insights that can inform future interventions and policy decisions to promote health and extend life expectancy globally.
References
Lasha Gochiashvili. (2023). Life Expectancy (WHO) Fixed [Data set]. Kaggle. https://doi.org/10.34740/KAGGLE/DS/3065197
