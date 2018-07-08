The following Markdown shows my work for the Assigment of Reproducible
Research Week 2. I show each of the steps and make the required comments
if necessary either to answer the questions or clarify any particular
procedure or step.

Loading and preprocessing the data
----------------------------------

1.  Load the data

We load the data with the read,csv() function

    data <- read.csv("activity.csv", sep=",",header=TRUE)

1.  Process/transform the data (if necessary) into a format suitable for
    your analysis

As the variable "date" class is interpreted as factor, we transform it
in a Date Class for further usage.

    data$date <- as.Date(data$date,format="%Y-%m-%d")

What is mean total number of steps taken per day?
-------------------------------------------------

1.  Calculate the total number of steps taken per day

First we ignore the Missing Values as indicated by the instructions.
With the aggregate command, we collapse data into a new set containing
the sum of the steps for each particular date. The data computes the
following:

    pasosdia <- aggregate(steps ~ date, data, sum)

1.  Make a histogram of the total number of steps taken each day

The histogram builds classes or groups of data depending in the number
of steps given per date. This approximates a probalistic distribution,
different from a box plot that only plot specific values

    hist(pasosdia$steps, main = paste("Steps Given per Day"), col="blue", xlab=" # of Steps")

![](PA1_template_files/figure-markdown_strict/unnamed-chunk-4-1.png)

    dev.copy(png, file="Gráfica1.png", width= 480, height=480)

    ## png 
    ##   3

    dev.off()

    ## png 
    ##   2

1.  Calculate and report the mean and median of the total number of
    steps taken per day

We calculate the average number of steps given in any particular day
with the aggregate() command. Then we estimate the average of the
distribution of the histogram with the data called pasosdia. As shown in
the histogram before, the mean of the histogram is acchived in the value
10766.19

    mediapas <-aggregate(steps ~ date, data, mean)
    mediatotal <- mean(pasosdia$steps)
    mediatotal ## Mean of total steps per day 

    ## [1] 10766.19

We repeat the procedure for the median value. The median is 10765

    medianapordia <-aggregate(steps ~ date, data, FUN= median)
    medianatotal <- median(pasosdia$steps)
    medianatotal

    ## [1] 10765

What is the average daily activity pattern?
-------------------------------------------

1.  Make a time series plot of the 5-minute interval (x-axis) and the
    average number of steps taken, averaged across all days (y-axis)

As before we use the aggregate function this time by interval variable.
Then we plot the values.

    pasosporintervalo <- aggregate(steps ~ interval, data, mean)
    plot(pasosporintervalo$interval,pasosporintervalo$steps, type="l", xlab="Interval", ylab=" #of Steps",main="Average Steps per Day per Interval")

![](PA1_template_files/figure-markdown_strict/unnamed-chunk-7-1.png)

    dev.copy(png, file="Gráfica2.png", width= 480, height=480)

    ## png 
    ##   3

    dev.off()

    ## png 
    ##   2

1.  Which 5-minute interval, on average across all the days in the
    dataset, contains the maximum number of steps?

<!-- -->

    maximopintervalo <- pasosporintervalo[which.max(pasosporintervalo$steps),1]
    maximopintervalo

    ## [1] 835

From the code we can see that the maximum number of steps is achieved at
interval 835

Imputing missing values
-----------------------

1.  Calculate and report the total number of missing values in the
    dataset

We use the is.na() function and report the number of Missing Values (
2304 values)

    numNas <- sum(is.na(data$steps))
    numNas

    ## [1] 2304

1.  Devise a strategy for filling in all of the missing values in the
    dataset.

Our strategy in this exercise consisted in using the mean values for
each 5 minute interval in order to replace the missing values. This
spreads the data more accurately along the distribution. We retrieve the
mean of the intervals previously used, and using the dates we match the
means with the original data points. This is shown in the next code
ahead.

3.Create a new dataset that is equal to the original dataset but with
the missing data filled in.

Using the previous noted strategy, we fill the Missing values creating a
new data base. "datanueva"" is the new base with missing values
replaced.

    datanueva <- transform(data, steps = ifelse(is.na(data$steps), pasosporintervalo$steps[match(data$interval, pasosporintervalo$interval)], data$steps))

1.  Make a histogram of the total number of steps taken each day and
    Calculate and report the mean and median total number of steps taken
    per day. Do these values differ from the estimates from the first
    part of the assignment? What is the impact of imputing missing data
    on the estimates of the total daily number of steps?

Following similar steps as before, we calculate the number of steps per
day the means and the median

    pasosnueva <- aggregate(steps ~ date, datanueva, sum)
    medianueva <- aggregate(steps ~ date,datanueva, mean)
    mediatotalnueva <- mean(pasosnueva$steps)
    mediananueva <-aggregate(steps ~ date, datanueva, median)
    medianatotalnueva <- median(pasosnueva$steps)

    mediatotalnueva

    ## [1] 10766.19

    medianatotalnueva

    ## [1] 10766.19

The new mean is 10766.19 and the median 10766.19. The new missing values
don´t alter significantly the mean and the median of the results. In
order to show it, we plot both histograms in the following code with the
par() function

    par(mfrow=c(1,2))
    hist(pasosdia$steps, main = paste("Total Steps per Day - No Nas"), col="blue", xlab="# of Steps")
    hist(pasosnueva$steps, main = paste("Total Steps per Day- Nas"), col="red", xlab="# of Steps")

![](PA1_template_files/figure-markdown_strict/unnamed-chunk-12-1.png)

    dev.copy(png, file="Gráfica3.png", width= 480, height=480)

    ## png 
    ##   3

    dev.off()

    ## png 
    ##   2

Are there differences in activity patterns between weekdays and weekends?
-------------------------------------------------------------------------

1.  Create a new factor variable in the dataset with two levels -
    "weekday" and "weekend" indicating whether a given date is a weekday
    or weekend day.

We use the data with the missing values corrected for this exercise. We
first transform the factor type of "date" variable into class Date.
After this we create a new factor variible called "diasemana" with the
levels corresponding to the different days of the week (My R Studio is
in Spanish so I use the spanish names of the days)

    datanueva$date <- as.Date(datanueva$date,format="%Y-%m-%d")
    datanueva$diasemana <- factor(format(datanueva$date,"%A"))
    levels(datanueva$diasemana) <- list(weekdays = c("lunes", "martes", "miércoles", "jueves","viernes"),weekends = c("sábado", "domingo") )

1.  Make a panel plot containing a time series plot of the 5-minute
    interval (x-axis) and the average number of steps taken, averaged
    across all weekday days or weekend days (y-axis).

Using with () command we aggregate the data by the week variable just
created and we plot both functions means

    par(mfrow=c(2,1))
    with(datanueva[datanueva$diasemana=="weekdays",],plot(aggregate(steps ~ interval, FUN = mean),type="l",main ="Weekdays"))
    with(datanueva[datanueva$diasemana=="weekends",],plot(aggregate(steps ~ interval, FUN = mean),type="l",main ="Weekends"))

![](PA1_template_files/figure-markdown_strict/unnamed-chunk-14-1.png)

    dev.copy(png, file="Gráfica4.png", width= 480, height=480)

    ## png 
    ##   3

    dev.off()

    ## png 
    ##   2

As we observe, activity is much harder during the weekends than in the
middle of the week. We finally call the knit2html() function

knit2html("test.Rmd")
