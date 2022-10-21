.PHONY: clean

clean:
	rm -rf figures
	rm -rf derived_data
	rm -rf .created-dirs
	rm -f report.pdf

.created-dirs:
	mkdir -p figures
	mkdir -p derived_data
	touch .created-dirs

derived_data/sc_stats.csv: .created-dirs data_preparation.R source_data/Stephen Curry Stats.csv
	Rscript data_preparation.R


figures/pre_avg_min_plot.rds: .created-dirs\ source_data/Stephen Curry.csv 
data_preparation.R derived_data/sc_stats.csv Initial_plots.R
	Rscript Initial_plots.R

figures/pre_avg_FGP_plot.rds: .created-dirs\ source_data/Stephen Curry.csv 
data_preparation.R derived_data/sc_stats.csv Initial_plots.R
	Rscript Initial_plots.R


# Build the final report for the project.

report.pdf: figures/pre_avg_FGP_plot.rds figures/pre_avg_min_plot.rds 
	R -e "rmarkdown::render(\"report.Rmd\", output_format=\"pdf_document\")"
