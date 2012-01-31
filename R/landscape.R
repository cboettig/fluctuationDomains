#' landscape 
#' 
#' plot the adaptive landscapes produced by fluctuationDomains
#' @param func the adaptive landscape to plot
#' @param llim lower limit
#' @param rlim upper limit
#' @return the landscape plot
#' @export
#' @examples
#' logistic_curve = function(x){-x*exp(-x*x/2)}
#' X11(w=5, h=6.5)
#' landscape(logistic_curve, -3, 3)
landscape = function(func, llim=0, rlim=1){

	par(cex.lab=1.7, lwd=2, mgp=c(2,.4,0) )

	mat <-	rbind(c(1),c(2) )
	layout(mat, height = c(.75, 1))

	## mar is margins, in order bottom, left, top, right.  default is 5,4,4,2
	## mgp is margin of title, axis label, axis line.  3,1,0 is default
	par( mar=c(0,6,4,2) )

	x2 = seq(llim,rlim,length=100)
	integral2 = cumsum( func(x2) )

	## see ?plotmath for symbols
	plot(x2, integral2, 
		type="l", 
		ylab=expression(paste( integral( italic(a[1])(y)*dy, 0, italic(x) ) )),
		xaxt="n",
		yaxt="n",
		bty = "l"
	)
	## reset margins for the lower plot
	par( mar=c(5,6,0,2) )

	## plot lower curve
	curve(func, llim, rlim, 
		xlab=expression(paste("Trait, ", italic(x))), 
		ylab=expression( paste("", italic(a[1])(italic(x))  ) ), 
		yaxt="n" 
	)
	abline(h=0, lty="dashed")
	maxpt = x2[which.max( func(x2) )]
	minpt =  x2[which.min( func(x2) )]
	shade = c(maxpt,minpt)
	
	bdry = par("usr")
	## Shading
	extend = 1.1
	if(func(llim) < func(llim+.01) ){
		rect(bdry[1], bdry[3], min(shade), bdry[4], col = rgb(.8, .8, .8, 1.0), border=NA )
		rect(max(shade), bdry[3], bdry[2], bdry[4], col = rgb(.8, .8, .8, 1.0), border=NA )
	}
	else{
		rect(min(shade), bdry[3], max(shade), bdry[4], col = rgb(.8, .8, .8, 1), border=NA )
	}

	## plot lower curve
	curve(func, llim, rlim, 
		xlab=expression(paste("Trait, ", italic(x))), 
		ylab=expression( paste("", italic(a[1])(italic(x))  ) ), 
		yaxt="n", add=T 
	)
	abline(h=0, lty="dashed")


}

