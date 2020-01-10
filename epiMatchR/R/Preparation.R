#' Set values that are less/greater than or equal to a threshold equal to a value
#'
#' This function sets all values in a vector/matrix that are less/greater than or equal
#' to a specified threshold equal to a specified value and returns the output as a
#' data frame.
#'
#' @param  X a matrix of vector of values
#' @param  threshold value above/below which to adjust values. Default is 1.
#' @param  value a numeric value to set all values below threshold to. Default is 0.
#' @param  below adjusts values below threshold as default. Adjusts values above threshold if FALSE.
#' @return the adjusted matrix or vector as a data frame
#' @export
setThres2Val <- function(X, threshold=1, value=0, below=TRUE) {
  if (isTRUE(below)) {
    tmp<-apply(X, 2, FUN = function(X){X[which(X<=threshold)] = value; return(as.numeric(as.character(X)))})
    }
  else if (isFALSE(below)) {
    tmp<-apply(X, 2, FUN = function(X){X[which(X>=threshold)] = value; return(as.numeric(as.character(X)))})
    }
  return(as.data.frame(tmp))
  }


#' Sets NA entries equal to a value
#'
#' Replaces all NA entries in a vector/matrix with a specified value
#'
#' @param  X a matrix of vector of values
#' @param  value a numeric value to replace NA's with. Default is 0.
#' @return the adjusted matrix or vector as a data frame
#' @export
setNA2Val <- function(X, value=0) {
  tmp<-apply(X, 2, FUN = function(X){X[which(is.na(X))] = value; return(as.numeric(as.character(X)))})
  return(as.data.frame(tmp))
  }

#' Removes epitopes not analyzed by all datasets being compared
#'
#' Discards data for epitopes not analyzed in all datasets entered as arguments
#'
#' @param  ... at least 2 matrices of z scores with an epitope id column titled id
#' @return the adjusted matrix or vector as a data frame
#' @export
commonEpiIDs <- function(...) {
  tmp<-list(...)
  argCount<-length(tmp)
  if (argCount < 2) {
    stop("Must enter at least 2 datasets")
  } else {
    a<-lapply(tmp,function(x) {x$id})
    sharedIDs<- Reduce(intersect, a)
    return(lapply(tmp,function(x){dplyr::filter(x,id %in% sharedIDs)}))
  }
}

#' splits observations in a data frame into a list of data frames, grouped by factors
#'
#' Splits data into a list of data frames grouped by factors. Observations with the same values
#' for the specified factor(s) will be grouped together
#'
#' @param x an object of type data frame
#' @param by a factor to split by
#' @return a list of grouped data frames
#' @export

splitToList <- function(x, by) {
  initClass <- class(x)[1]
  if (initClass == "list") {
    stop("Do not know how to split. splitToList requires a data frame type object.")
  }
  if (initClass != "data.frame")
    data.table::setDF(x)
  if (length(by) == 1) {
    toReturn <- split(x = x, f = as.factor(data.frame(x[,
                                                        by])[, 1]))
  }
  if (length(by) > 1) {
    colIndexToGroup <- which(names(x) %in% by)
    tempList <- list()
    for (i in 1:length(colIndexToGroup)) {
      tempList[[i]] <- as.factor(data.frame(x[, colIndexToGroup[i]])[,
                                                                     1])
    }
    toReturn <- split(x = x, tempList, drop = TRUE)
  }
  if (initClass != "data.frame") {
    if (class(toReturn) == "list") {
      for (i in 1:length(toReturn)) {
        if (initClass == "data.table") {
          try(data.table::setDT(toReturn[[i]]), silent = TRUE)
        }
        else {
          try(toReturn[[i]] <- dplyr::as_tibble(toReturn[[i]]),
              silent = TRUE)
        }
      }
    }
    else {
      if (initClass == "data.table") {
        try(data.table::setDT(toReturn), silent = TRUE)
      }
      else {
        try(toReturn <- dplyr::as_tibble(toReturn), silent = TRUE)
      }
    }
  }
  return(toReturn)
}


#' generates a matrix describing epitope prescense/absence from z matrix. Prevalence column optional
#'
#' Takes a matrix of z scores and outputs a binary matrix that describes whether each z score in the
#' input matrix is above or less than or equal to a user-defined threshold. Each column should represent
#' a sample and each row should represent an epitope. Option to create a column describing prevalence
#' within the data set of antibodies to each eptitope based onthe selected threshold.
#'
#' @param zDF a dataframe of Z scores wherer columns represent individuals and rows represent epitopes
#' @param t threshold value. Sample will be considered negative for antibodies to epitope for Z-scores less than or equal to t. Corresponding entries in output will be 0.
#' @param prev logical. Last column in output will contain prevalence of each eptipe if TRUE
#' @param keepID logical. first column will contain epitope ids if TRUE
#' @return a hit matrix with or without optional prevalence column
#' @export
z2Hit <- function(zDF, t=3, prev=FALSE,keepID=TRUE) {
  if ('id' %in% names(zDF)) {
    hitDF<-dplyr::select(zDF,-'id')
  }
  else {
    hitDF<-as.data.frame(zDF)
  }
  hitDF<-epiMatchR::setThres2Val(hitDF,threshold=t,value=0, below = TRUE)
  hitDF[hitDF>t] <-1
  hitDF<-as.data.frame(hitDF)
  if (prev==TRUE) {
    hitDF$prevalence <- rowSums(hitDF)/(dim(hitDF)[2])
  }
  if (keepID==TRUE) {
    hitDF<-dplyr::bind_cols(dplyr::select(zDF,id),hitDF)
  }
  return(hitDF)
}

#' Links a dataframe with epitope ids to epitope metadata
#'
#' Binds columns of data frame with epitope ids to appropriate epitope metadata located in an eptiope
#' key data frame
#'
#' @param dataDF a dataframe of where rows represent epitopes. The first column must be named 'id' and contain eptiope ids
#' @param key  dataframe containing epitope ids and relevant metadata. The first column must be named 'id' and contain eptiope ids
#' @param keepAllData,KeepAllMeta (optional) logical. If False, user may specify columns to exclude in output
#' @param keepData,KeepMeta (optional). Specifies which columns to keep if keepAllData or keepAllMeta is FALSE. id must be included. Usage keepData=c("id","var1",...)
#' @return a data frame with epitope meta data and selected individual or database data
#' @export
epIdentity <- function(dataDF, key, keepAllData=TRUE, keepAllMeta=TRUE, keepData=names(dataDF), keepMeta=names(key)) {
  if ((!('id' %in% names(dataDF)))||(!('id' %in% names(key)))) {
    stop("Both data frames must contain id columns")
  }
  else {
    if (keepAllData==TRUE) {
      data2bind<-dataDF
    }
    else if (keepAllData==FALSE){
      data2bind<-dplyr::select(dataDF,keepData)
    }
    if (keepAllMeta==TRUE) {
      meta2bind<-key
    }
    else if (keepAllMeta==FALSE){
      meta2bind<-dplyr::select(key,keepMeta)
    }
    data2bind$id<-as.numeric(data2bind$id)
    meta2bind$id<-as.numeric(meta2bind$id)
    tmp<-epiMatchR::commonEpiIDs(data2bind,meta2bind)
    tmp1<-data2bind[[1]]
    tmp2<-data2bind[[2]]
    output<-dplyr::left_join(meta2bind,data2bind,by="id")
    return(output)
  }
}


