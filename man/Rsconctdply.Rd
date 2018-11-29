\name{rsconctdply}
\alias{rsconctdply}
\title{Deploys multiple Shiny apps}
\usage{
rsconctdply(filedir)
}
\description{
Deploys multiple apps (App1, App2,...AppN) to multiple user accounts and server locations on Json file.
}
\examples{

#rsconctdply("~/rconnect_dir.json")

#Json file Format:

#sample file name: "rconnect_dir.json"

#{
#  "App1": {
#    "Server_url": "https://example1.com:443",
#    "Server_NAME": "example1",
#    "account": "user1",
#    "appDir": "~/location1/"
#  },
#  "App2": {
#    "Server_url": "https://example2.com:123",
#    "Server_NAME": "example2",
#    "account": "user2",
#    "appDir": "~/location2/"
#  }
#}

}

\arguments{
\item{rsconctdply}{Name of the function}
\item{filedir}{directory path for json file}

}
