library(ggplot2)
library
n <- 1000
x <- data.frame(matrix(seq(0.01, 25, length.out = n), nrow = n, ncol = 1))
colnames(x) <- "v1"

# Create first color ramp. We will extract a color from near the green side of
# this first color ramp. Then we make a second color ramp where we spline
# through the green-ish color we just extract. This will have the effect of
# pulling the green color up off the bottom after dong the log-transform.
col_pal_1 <- colorRampPalette(colors = c("#2CDE0D", "red"))
col_ramp_1 <- col_pal_1(n)

# Make the second color ramp where we spline through the extract color from the
# first color ramp.
col_pal <- colorRampPalette(colors = c("#2CDE0D",col_ramp_1[65], "red"))
col_ramp <- col_pal(n)
ggplot(x, aes(x = 1, y = v1)) + geom_tile(aes(fill = v1)) +
  scale_fill_gradientn(colors = col_ramp,
                       trans = 'log') +
  theme_minimal() +
  theme(axis.text = element_blank(),
        axis.title = element_blank(),
        panel.grid = element_blank(),
        legend.position = "nonoe") +
  geom_hline(yintercept = 4)+
  geom_hline(yintercept = 5)+
  geom_hline(yintercept = 3)+
  geom_hline(yintercept = 2)+
  geom_hline(yintercept = 6)

