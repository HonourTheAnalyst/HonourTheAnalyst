-- Exploratory Data Analysis

SELECT *
FROM layoffs_staging2;


SELECT MAX(total_laid_off), MAX(percentage_laid_off)
FROM layoffs_staging2;

SELECT *
FROM layoffs_staging2
where percentage_laid_off = 1
ORDER BY funds_raised_millions DESC
;


SELECT company, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company
ORDER BY 2 DESC
;

SELECT MIN(`date`), MAX(`date`)
FROM layoffs_staging2;


SELECT industry, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY industry
ORDER BY 2 DESC
;

SELECT *
FROM layoffs_staging2;

SELECT country, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY country
ORDER BY 2 DESC
;

SELECT year(`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY  year(`date`)
ORDER BY 1 DESC
;

SELECT stage, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY  stage
ORDER BY 2 DESC
;

SELECT company, SUM(percentage_laid_off)
FROM layoffs_staging2
GROUP BY company
ORDER BY 2 DESC
;

SELECT substring(`date`,1,7) as `month`, SUM(total_laid_off)
from layoffs_staging2
where substring(`date`,1,7) IS NOT NULL
GROUP BY `month`
ORDER BY 1 ASC
;

WITH Rolling_total as
(
SELECT substring(`date`,1,7) as `month`, SUM(total_laid_off) as total_off
from layoffs_staging2
where substring(`date`,1,7) IS NOT NULL
GROUP BY `month`
ORDER BY 1 ASC
)
SELECT `month`, total_off,
SUM(total_off) OVER(ORDER BY `month`) as Rolling_total
FROM Rolling_total;

SELECT company, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company
ORDER BY 2 DESC
;

SELECT company, year(`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company, year(`date`)
ORDER BY 3 DESC
;

WITH Company_year (company, years, total_laid_off) AS
(
SELECT company, year(`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company, year(`date`)
), Company_Year_Rank AS
(SELECT *, DENSE_RANK() 
OVER (PARTITION BY years ORDER BY total_laid_off DESC) as Ranking
FROM  Company_year
WHERE years is not null
)
SELECT *
FROM Company_Year_Rank
WHERE Ranking <= 5
;


WITH Industry_year (industry, years, total_laid_off) AS
(
SELECT industry, year(`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY industry, year(`date`)
), Industry_Year_Rank AS
(SELECT *, DENSE_RANK() 
OVER (PARTITION BY years ORDER BY total_laid_off DESC) as Ranking
FROM  Industry_year
WHERE years is not null
)
SELECT *
FROM Industry_Year_Rank
WHERE Ranking <= 5
;
















































































