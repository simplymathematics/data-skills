SELECT characteristics.SOC, characteristics.TypicalEntryLvlEduc, characteristics.PreEmplExperience, salary.`Mean.Hourly.Wage`
FROM characteristics
INNER JOIN salary ON characteristics.SOC=salary.SOC; 