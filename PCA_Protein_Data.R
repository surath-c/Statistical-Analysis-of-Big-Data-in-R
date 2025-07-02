# Principal Component Analysis (PCA) on Protein Consumption

# Install and load packages
library(corrr)
library(ggcorrplot)
library(FactoMineR)
library(factoextra)

# Load data
protein_data <- read.csv(file.choose())
numerical_data <- protein_data[, 2:10]

# Normalize
data_normalized <- scale(numerical_data)

# Correlation matrix
corr_matrix <- cor(data_normalized)
ggcorrplot(corr_matrix)

# Apply PCA
data_pca <- PCA(data_normalized, graph = FALSE)

# Scree plot
fviz_eig(data_pca, addlabels = TRUE)

# Loadings
print(data_pca$var$cor)

# Variable visualization
fviz_pca_var(data_pca, col.var = "cos2",
             gradient.cols = c("black", "orange", "green"), repel = TRUE)
