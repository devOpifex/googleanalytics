#' Use Google Analytics
#' 
#' Add Google Analytics to your Shiny app
#' 
#' @param id The Google Analytics tracking ID.
#' 
#' @examples
#' if(FALSE){
#' library(shiny)
#' 
#' ui <- navbarPage(
#'   "Google Analytics",
#'   header = list(
#'     useGA("G-59ZYN9HXFQ")
#'   ),
#'   tabPanel(
#'     "Inputs",
#'     textInput("name", "Name"),
#'     selectInput("sex", "Sex", c("Male", "Female")),
#'     radioButtons("color", "Color", c("Red", "Green", "Blue"))
#'   ),
#'   tabPanel(
#'     "Outputs",
#'     selectizeInput("cities", "Cities", choices = c("New York", "Los Angeles", "Chicago")),
#'     checkboxGroupInput("fruits", "Fruits", choices = c("Apple", "Banana", "Orange")),
#'     actionButton("submit", "Submit"),
#'     plotOutput("plot")
#'   )
#' )
#' 
#' server <- function(input, output, session) {
#'   output$plot <- renderPlot({
#'     input$submit
#'     plot(runif(10))
#'   })
#' }
#' 
#' shinyApp(ui, server)
#' }
#' @export
useGA <- function(id){
  if(is.null(id))
    stop("You must provide a Google Analytics tracking ID")

  htmltools::tagList(
    htmltools::singleton(
      htmltools::tags$script(
        async = NA,
        src = sprintf("https://www.googletagmanager.com/gtag/js?=%s", id)
      )
    ),
    htmltools::singleton(
      htmltools::tags$script(
        htmltools::HTML(
          sprintf(
            "window.dataLayer = window.dataLayer || [];
            function gtag(){dataLayer.push(arguments);}
            gtag('js', new Date());
            gtag('config', '%s');",
            id
          )
        )
      )
    ),
    coreDep()
  )
}

coreDep <- function(){
  htmltools::htmlDependency(
    name = "googleanalytics",
    version = utils::packageVersion("googleanalytics"),
    src = "",
    script = "index.js",
    package = "googleanalytics"
  )
}
