-- Data Cleaning

select*
from layoffs;

-- 1. Remove Duplicates
-- 2. Standardize the Data
-- 3. Null or Blank Values
-- 4. Remove Any unneccesary Columns


create table layoffs_staging
like layoffs;

select *
from layoffs_staging;


insert layoffs_staging
select*
from layoffs;


select *,
row_number() over(
partition by company, industry, total_laid_off, 
percentage_laid_off, `date`) as row_num
from layoffs_staging;  


with duplicate_cte as
(
select *,
row_number() over(
partition by company, location, 
total_laid_off, percentage_laid_off, `date`,
stage, country, funds_raised_millions) as row_num
from layoffs_staging
)
select *
from duplicate_cte
where row_num > 1;

select *
from layoffs_staging
where company = 'casper';


with duplicate_cte as
(
select *,
row_number() over(
partition by company, location, 
total_laid_off, percentage_laid_off, `date`,
stage, country, funds_raised_millions) as row_num
from layoffs_staging
)
SELECT*
from duplicate_cte
where row_num > 1;


with duplicate_cte as
(
select *,
row_number() over(
partition by company, location, 
total_laid_off, percentage_laid_off, `date`,
stage, country, funds_raised_millions) as row_num
from layoffs_staging
)
SELECT*
from duplicate_cte
where row_num > 1;

select *
from layoffs_staging
where company = 'casper';

CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` int 
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



select*
from layoffs_staging2
where row_num > 1;


insert into layoffs_staging2
select *,
row_number() over(
partition by company, location, 
total_laid_off, percentage_laid_off, `date`,
stage, country, funds_raised_millions) as row_num
from layoffs_staging;


delete
from layoffs_staging2
where row_num > 1;

select*
from layoffs_staging2;


-- Standardizing data


SELECT company, TRIM((company))
FROM layoffs_staging2;

update layoffs_staging2
set	company = TRIM((company));

SELECT *
FROM layoffs_staging2
WHERE industry LIKE 'Crypto%'
;

UPDATE layoffs_staging2
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%';

SELECT DISTINCT country,
trim(trailing '.' from country)
FROM layoffs_staging2
ORDER BY 1;


UPDATE layoffs_staging2
set country = trim(trailing '.' from country)
where country LIKE 'United States%';


SELECT `date`
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET `date` = str_to_date(`date`, '%m/%d/%Y');

ALTER TABLE layoffs_staging2
MODIFY COLUMN `date` date;

SELECT*
FROM layoffs_staging2;

-- NULL AND BLANK VALUES

SELECT*
FROM layoffs_staging2
where total_laid_off IS NULL
AND percentage_laid_off IS NULL
;

UPDATE layoffs_staging2
SET industry = NULL
WHERE industry = ''
;


SELECT *
FROM layoffs_staging2
WHERE industry IS NULL
OR industry = ''
;

SELECT *
FROM layoffs_staging2
WHERE company like 'Bally%';

SELECT t1.industry, t2.industry
FROM layoffs_staging2 t1
JOIN layoffs_staging2 t2
	ON t1.company = t2.company
WHERE (t1.industry IS NULL OR t1.industry = '')
AND t2.industry IS NOT NULL;

UPDATE layoffs_staging2 t1
JOIN layoffs_staging2 t2
	ON t1.company = t2.company
SET t1.industry = t2.industry
WHERE t1.industry IS NULL
AND t2.industry IS NOT NULL;


SELECT *
FROM layoffs_staging2;


SELECT*
FROM layoffs_staging2
where total_laid_off IS NULL
AND percentage_laid_off IS NULL
;

DELETE
FROM layoffs_staging2
where total_laid_off IS NULL
AND percentage_laid_off IS NULL
;

SELECT*
FROM layoffs_staging2;

ALTER TABLE layoffs_staging2
DROP COLUMN row_num;




