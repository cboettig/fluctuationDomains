### try fig parameter to specify location of each plot indepdently.  need new=TRUE to add to an existing plot

#' @title results plot
#' @return a summary plot
#' @export
resultsplot = function(){

full1 = read.csv('full.txt')
c1 = read.table('data.txt')
t1 = read.table('theory.txt')

#points in histogram
	N=30
	BY=2
	ptcolor = "black" 
	linecolor = ptcolor
	starcolor = "black"
	starshape = 19   ## 4 is x, 3 is +, 19 filled circle
	starsize = 1 
	freq_ptcolor = ptcolor #starcolor
	freq_ptshape = 1 #starshape
	vline = "black"
	vtype = "dashed"

	mat2 <-	rbind(c(1,2,3))
#	layout(mat2)

	par(mfrow=c(1,3),
		cex.lab=1.2, cex.axis=1.2
		, lwd=1, pch=1
## margins
		, mar = c(5, 4, 3, 0) + .1
## axis labels
		, mgp = c(2,1,0)
## omd can only shrink plot
	, omd = c(0.01,1,0,1)
## coords of plot as fraction of total
		, plt = c(0.15, 0.9, 0.15, 0.8)
## subfig width, height in inches
		, pin = c(1.5,1.5)

	)

## Calculations to pick what time to draw histogram and to compute histogram
	max1 = which.max(t1$V3)
	time1 = t1[max1,1]
	sep = abs(full1[,1] - time1)
	nearest = which(sep == min(sep))
	sample1 = full1[nearest, 2]
	mean1 = mean(sample1)
	sd1 = sd(sample1)
	range1 = range(sample1)
	axis1 = seq(range1[1], range1[2], length.out=100)
	predict1 = dnorm(axis1, mean = mean1, sd = sd1)
	d1 = density(sample1, n = N)

	sep = abs(c1[,1] - time1)
	star1 = which.min(sep)
	s1 = seq(1,length(c1[,1]), by=BY)


	plot(t1[,1], t1[,2], col=linecolor, type='l', xlab=expression(paste("Time, ", italic(t))), ylab =expression(paste("Mean Trait, ", italic(hat(x)))), main = "Mean Trait Path" )
	points(c1[s1,1], c1[s1,2],  , col=ptcolor)
	abline(v=c1[star1,1], col=vline, lty=vtype)
	points(c1[star1,1], c1[star1,2], col=starcolor, pch=starshape, lwd=starsize)

	plot(t1[,1], t1[,3], col=linecolor, type="l", xlab=expression(paste("Time, ", italic(t))), ylab =expression(paste("Trait Var, ", " ", sigma^2)),  main="Variance Between Paths")
	points(c1[s1,1], c1[s1,3],  , col=ptcolor)
	abline(v=c1[star1,1], col=vline, lty=vtype)
	points(c1[star1,1], c1[star1,3], col=starcolor, pch=starshape, lwd=starsize)

	plot(axis1, predict1, type='l', col=linecolor, xlab=expression(paste("Trait, ", italic(x))), ylab = expression(paste("Density")), main="Snapshot of Path Distribution")
	points(d1$x, d1$y, col=freq_ptcolor, pch=freq_ptshape)


}
