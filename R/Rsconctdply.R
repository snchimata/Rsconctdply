# This is code to automate the deployment process of shiny apps to
# different locations like Rstudio connect or shiny apps server
# http://docs.rstudio.com/connect/admin/appendix-rsconnect.html

#' @title Deploys Multiple Shiny Apps using Json Config File
#'
#' @description This package helps in mass deployemnt of shiny apps to Rstudio connect or Shiny Server.
#'
#' @param filedir
#'
#' @return NULL
#'
#' @examples  rsconctdply("~/rconnect_dir.json")
#'
#' @export rsconctdply
#'

rsconctdply <- function(filedir) {

  #To ignore the warnings during usage
  options(warn=-1)
  options("getSymbols.warning4.0"=FALSE)

  lbs <- c("rjson", "rsconnect", "dplyr")
  sapply(lbs, function(x)
    require(x, character.only = TRUE) || {install.packages(x); library(x, character.only = TRUE)})


  # rcon <- rjson::fromJSON(file = "~/rconnect_dir.json")
  rcon <- rjson::fromJSON(file = filedir)

  for (i in 1:length(rcon)) {
    tryCatch({
      print(
        paste0(
          " App : ",
          i,
          ";",
          " Server : ",
          rcon[[i]]$Server_url,
          ";",
          " ServerName : ",
          rcon[[i]]$Server_NAME,
          ";",
          " AppDir : ",
          rcon[[i]]$appDir,
          ";",
          " Account : ",
          rcon[[i]]$account
        )
      )


      # Adding Server
      rsconnect::addConnectServer(url = rcon[[i]]$Server_url,
                                  name = rcon[[i]]$Server_NAME)

      # For account connection
      rsconnect::connectUser(
        account = rcon[[i]]$account,
        server = rcon[[i]]$Server_NAME,
        quiet = TRUE
      )
      # For new account setup (shiny apps)

      # rsconnect::setAccountInfo(name='name',
      #                          token='token',
      #                          secret='secret')

      # connected accounts
      rsconnect::accounts()

      rsconnect::deployApp(
        appDir = rcon[[i]]$appDir,
        # appName = "Shiny-rsconnect-demo",
        # appTitle = "Shiny-rsconnect-demo",
        account = rcon[[i]]$account,
        server = rcon[[i]]$Server_NAME,
        launch.browser = FALSE
      )
    }, error = function(e) {
    })
  }
}
