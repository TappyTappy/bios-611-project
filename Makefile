.PHONY: clean

clean:
	rm -rf figures
	rm -rf derived_data
	rm -rf .created-dirt
	rm -f report.pdf

.created-dirs:
	mkdir -p figures
	mkdir -p derived_data
	touch .created-dirs


derived_data/astros.csv derived_data/schedule_all.csv derived_data/schedule.csv derived_data/bangs.csv derived_data/none.csv derived_data/standings.csv: .created-dirs source_data/Astros_Schedule.csv source_data/MLB_Standings.csv source_data/astros_bangs_20200127.csv data_exploration.R
	Rscript data_exploration.R


figures/NBbP1.rds figures/NBbP2.rds figures/NBbP3.rds figures/NPwB.rds figures/POB.rds figures/POB_bat.rds figures/player.rds figures/opponent.rds figures/individual.rds: .created-dirs derived_data/astros.csv derived_data/schedule_all.csv derived_data/schedule.csv derived_data/bangs.csv derived_data/none.csv derived_data/standings.csv Initial_plots.R
	Rscript Initial_plots.R


# Build the final report for the project.
 

report.pdf: figures/NBbP1.rds figures/NBbP2.rds figures/NBbP3.rds figures/NPwB.rds figures/POB.rds figures/POB_bat.rds figures/player.rds figures/opponent.rds figures/individual.rds
	R -e "rmarkdown::render(\"report.Rmd\", output_format=\"pdf_document\")"
