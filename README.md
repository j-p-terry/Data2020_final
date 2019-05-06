# Data2020_final

Scripts used to produce project results (cleaning, merging, EDA, and modeling) for Jason Terry, Guanhua Zhu, and Spencer Boyum.

Most of the EDA and model building is done in project_notebook.ipynb and project_notebook2.ipynb. project_notebook.ipynb and project_notebook2.ipynb are roughly the same file - the primary difference is that project_notebook2.ipynb contains the experiment described in our report that involves flipping variables that indicated whether a victim is armed or has a gun. However, project_notebook2.ipynb was throwing an error during the fitting of the backwards selection model that we were unable to debug; the fitting of the backwards selection model did not have any errors in project_notebook.ipynb, and thus we have included both notebooks.

eda.R and data_cleaning_merging.R should be self explanatory.

We have also included the data used for our analysis. The file acs_police_clean.csv is the primary dataset used for our analysis - it is the resulting dataset after the police killings and ACS datasets are merged and cleaned. dem_data.csv contains demographic information for each state, and was merged with acs_police_clean.csv to perform our analysis.
