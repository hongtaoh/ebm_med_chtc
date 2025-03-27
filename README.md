# ML4HC 2025 Submission (Temporary)

Results are now temprarily stored in [`conjugate_priors`](conjugate_priors). 

The `heatmaps` show the heatmaps. The filenames of the plots are self-explainatory. **Note that in each heatmap, the number following the biomarker, e.g., (1), indicates the order according to best order (i.e., order associated with the highest log likelihood, see traceplots)**. 

The heatmaps show the uncertainties revealed by the most likely order. The most likely order is obtained considering the result of all iterations holistically, whereas the best order is the one associated with the highest log likelihoods that are shown in associated traceplots. Most of the time, the two are the same or very close. We normally pick the best order but will consider the uncertainties shown in the heatmap. 

The `traceplots` folder shows all the traceplots. 

The `records` folder shows the logging information when the algorithm is running. 

The `results` shows the summary in `json`. 