BIOS 611 Project: Stephen Curry stats 2009-2021 in NBA
======================================================
##### Yuchen/Tappy Li 
###### Data Source: Kaggle by MUJIN JO
Dataset introduction: Stephen Curry stats 2009-2021 in NBA

The dataset I choose from Kaggle is Stephen Curry stats from 2009 to 2022 seasons by MUJIN JO’s newest version. Its contents can be divided into two sections:  Golden State Warriors team stats, (such as win/loss, team score, the opponent team name, game date, etc.) and Stephen Curry player stats (such as minutes played in the game, field goals made, three pointers made, rebounds, assists, blocks, etc.). Among all other basketball datasets, I pick this one because of its useability and its focus on my favorite player, Stephen Curry. One thing that makes this dataset useable is its broad variable coverage. This dataset has complete stats dating back to 2009, and the newest data lastly updated in January 23, 2022. Since it contains both overall stats and Stephen Curry specific stats, I can arrive at my conclusions based on analysis from both angles. I would be able to explain problems more comprehensively. This dataset is also meaningful when Golden State Warriors want to change Curry’s contract or decide on if they will trade him to other teams (only hypothetically). 

After initial cleaning and tidying the dataset, I plan to do explanatory data analysis for an overview of Curry’s and GSW team’s performance throughout this 14 years period. I plan to focus my project on two problems: (1) Is Curry’s performance improving throughout his career? (2) Is Curry a key player in his team?

To approach problem (1), I plan to separate the data into “Curry” section and “GSW Team” section, and use “Curry” section mainly for my analysis. For “Curry” section of the dataset, I plan to visualize his history stats from 2009 to 2021 season. Maybe I can start with marking out the peak (maximum), the bottom (minimum), and significant upward/downward trends (slopes). Then, I plan to try fitting a comprehensive model using these values to explain the fluctuation of Curry’s performance from his personal perspective. The final goal of problem (1) will be to train my model using 2009-2021 season data and see if his performance of 2022 season can be predicted using historic data. Since this dataset has been recently updated with 2022 season data, I can use this part as my test data to validate my model.

For problem (2), I will first do lots of data visualization, giving graphs and tables for Golden States Warriors overall performance with 2009-2021 part of data. I expect there will be many games that Curry doesn’t play much due to injuries, so I will need to clean and filter the dataset before I can begin my analysis. Based on Curry’s presence, I can start digging if team’s performance, such as Win/Loss and total score, are caused by Curry or by other factors. To arrive at a conclusion, I may need to look up GSW news on the Internet to find out possible causes of GSW’s performance. (Ex. When Klay Thompson was injured, we cannot blame Curry for his team’s poor play.) 
