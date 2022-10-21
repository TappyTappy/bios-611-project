.PHONY: clean
.PHONY: d3-vis
.PHONY: visualization

clean:
	rm -rf models
	rm -rf figures
	rm -rf derived_data
	rm -rf sentinels
	rm -rf .created-dirs
	rm -f report.pdf

.created-dirs:
	mkdir -p models
	mkdir -p figures
	mkdir -p derived_data
	mkdir -p sentinels
	touch .created-dirs

derived_data/sc_stats.csv: .created-dirs data_preparation.R source_data/Stephen Curry Stats.csv
	Rscript data_preparation.R


figures/bpi_intensity_by_group.png: source_data/clinical_outcomes.csv bpi_intensity_by_group.R derived_data/clinical_outcomes-d3.csv
	Rscript bpi_intensity_by_group.R

# Note this uses a sentinal value because we produce many plots.
sentinels/cluster-plots.txt: .created-dirs\
 derived_data/clinical-outcomes-with-clustering.csv\
 cluster-plots.R
	Rscript cluster-plots.R

# Produce a figure which shows the clinical outcomes for our
# demographic clusters. Use the labels we calculated above to make the
# results comprehensible.
figures/outcomes_by_demographic_clustering.png figures/outcomes_by_demographic_clustering.svg: .created-dirs\
 demo-outcomes.R\
 derived_data/clinical-outcomes-with-clustering.csv\
 derived_data/cluster_labels.csv\
 derived_data/demographic_ae.csv
	Rscript demo-outcomes.R


# Build the final report for the project.

report.pdf: figures/bpi_intensity_by_group.png figures/demo-projection.png figures/outcomes_by_demographic_clustering.png derived_data/patient-count.fragment.Rmd
	R -e "rmarkdown::render(\"report.Rmd\", output_format=\"pdf_document\")"
