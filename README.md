# 🇮🇳 India Development Analysis - SQL + Power BI Project

> 📊 **Why is India still a developing country?**
This project explores key social, economic, health, and infrastructure indicators to analyze India’s development status compared to other countries.

---

## 🚀 Project Summary

- **Goal:** To investigate the factors behind India’s status as a developing country.
- **Tools Used:**  
  - 🧠 SQL (MySQL) for data analysis  
  - 📊 Power BI for interactive visualization  
  - 📁 CSV Files as data source  
- **Skills Practiced:**  
  Joins, Subqueries, Window Functions, Grouping, Aggregates, Visualization, Dashboarding

---

## 📁 Dataset Overview

The data is divided into 5 CSV files:

| Table                  | Description                                                  |
|------------------------|--------------------------------------------------------------|
| `Countries.csv`        | Country name, region, development status, population, area   |
| `EconomicIndicators.csv` | GDP per capita, GNI, Poverty rate, Gini coefficient         |
| `HDI.csv`              | HDI values, Life Expectancy, Education stats, Literacy, Mortality |
| `InfraDev.csv`         | Roads, electricity, sanitation, internet, hospital beds      |
| `RuralUrbanDisparities.csv` | Gaps between rural and urban access to services         |

---

## 🛠️ SQL Analysis

Performed in **MySQL** using:

- **Joins** (Inner, Left, Right)
- **Subqueries** (Scalar, Correlated, Nested)
- **Window Functions** (`RANK()`, `DENSE_RANK()`, `NTILE()`)
- **Group By**, **Having**, **Aggregate Functions**
- **CTEs** and `CASE WHEN` for custom logic

📌 SQL analysis was used to:
- Join all tables on `CountryID`
- Extract development stats for India vs other countries
- Filter and transform data before visualization

---

## 📊 Power BI Dashboard (12 Pages)

Designed an interactive **12-page report** with page-wise insights:

| Page No | Theme                            | Key Visuals                     |
|---------|----------------------------------|----------------------------------|
| 1       | India vs World Overview          | Map, GDP, HDI, Population       |
| 2       | Economic Strength                | GDP/GNI over time               |
| 3       | HDI Trend                        | HDI, Life Expectancy, Education |
| 4       | Poverty & Inequality             | Poverty rate, Gini              |
| 5       | Health Infrastructure            | Hospital beds, Physicians       |
| 6       | Education Access                 | Literacy, Mean Schooling        |
| 7       | Basic Infrastructure             | Electricity, Sanitation, Roads  |
| 8       | Rural vs Urban Gaps              | Clustered Indicators            |
| 9       | Global Ranks                     | India’s rank in GDP/HDI         |
| 10      | Regional Comparison              | India vs China, Vietnam, etc.   |
| 11      | Trends Over Time                 | Line/Area charts                |
| 12      | Final Summary & Suggestions      | Recommendations                 |

---

## 📌 Key Insights

- India has a growing economy, but **low per capita income** and **HDI**
- **Health and education infrastructure** still lag behind developed countries
- There are **large rural-urban disparities**
- **Slow progress** compared to similarly resourced nations (e.g., Vietnam, China)
- Development is ongoing, but **pace is not enough** to qualify as developed yet

---

## 🔗 Live Demo / PDF Report

- 📂 `India_Development.pbix` contains the full Power BI dashboard  
- 📄 Exported PDF or screenshots available in `/screenshots` folder (if added)

---

## 🙋‍♂️ About Me

Hi! I’m **Shivaram Rathod**, an aspiring Data Analyst from NIT Warangal.  
I love solving real-world problems using data, SQL, and visual storytelling.

- 🔗 [LinkedIn Profile](https://www.linkedin.com/in/shivaram-rathod-387a982a3?utm_source=share&utm_campaign=share_via&utm_content=profile&utm_medium=android_app)
- 🛠 [My Portfolio](https://bento.me/shivaram-rathod)

---

## 📌 License

This project is open for learning, review, and portfolio reference.  
**Give credits** if you're using parts of it. Respect the data!


