library(shiny)
library(shinythemes)
library(shinyjs)
library(DBI)
library(RPostgres)
library(DT)

# Define UI for the application
# Define UI for the application
ui <- fluidPage(
  useShinyjs(),
  navbarPage(
    theme = shinytheme("flatly"),
    "Alumni Network",
    id = "navbar_tabs",
    tabPanel("Login",
             id="login",
             fluidRow(
               column(2,
                      textInput("username", "Username"),
                      passwordInput("password", "Password"),
                      actionButton("submit_login", "Submit", class = "btn btn-primary")
               )
             )
    ),
    tabPanel("Alumni Listing",
             dataTableOutput("alumni_table")
    ),
    tabPanel("Alumni Create",
             fluidRow(
               column(6,
                      textInput("alumini_username", "Username"),
                      passwordInput("alumini_password", "Password"),
                      textInput("name", "Name"),
                      numericInput("graduation_year", "Graduation Year", value = 2022),
                      textInput("degree", "Degree"),
                      textInput("current_position", "Current Position"),
                      textInput("organization", "Organization"),
                      textInput("industry", "Industry"),
                      textInput("location", "Location"),
                      actionButton("submit_alumni", "Submit", class = "btn btn-primary")
               )
             )
    ),
    tabPanel("Job Postings",
             dataTableOutput("job_postings_table")
    ),
    tabPanel("Create Job Posting",
             fluidRow(
               column(6,
                      uiOutput("alumni_names"),
                      textInput("title", "Title"),
                      textAreaInput("description", "Description"),
                      textAreaInput("company", "Company"),
                      textInput("job_location", "Location"),
                      dateInput("job_last_date_to_apply", "Last Date to Apply"),
                      actionButton("submit_job_posting", "Submit", class = "btn btn-primary")
               )
             )
    ),
    tabPanel("Events Listing",
             dataTableOutput("events_table")
    ),
    tabPanel("Create Event",
             fluidRow(
               column(6,
                      textInput("event_name", "Event Name"),
                      textAreaInput("event_description", "Description"),
                      textInput("event_location", "Location"),
                      dateInput("event_date", "Event Date"),
                      textInput("event_organized_by", "Organized By"),
                      dateInput("event_late_date", "Late Date to Register"),
                      actionButton("submit_event", "Submit", class = "btn btn-primary")
               )
             )
    ),
    tabPanel("Mentorship Listing",
             dataTableOutput("mentorship_table")
    ),
    tabPanel("Create Mentorship",
             fluidRow(
               column(6,
                      uiOutput("mentor_names"),
                      uiOutput("mentee_names"),
                      numericInput("start_year", "Start Year", value = 2022),
                      numericInput("end_year", "End Year", value = 2023),
                      textAreaInput("feedback", "Feedback"),
                      actionButton("submit_mentorship", "Submit", class = "btn btn-primary")
               )
             )
    )
    
  ),
  actionButton("submit_logout", "Logout", class = "btn btn-danger pull-right"),
  
)

# Define server logic
server <- function(input, output, session) {
  observe({
    # Hide all tabs except the login tab
    shinyjs::hide("navbar_tabs")
    runjs("$('#submit_logout').css('display','none');")
    shinyjs::show("login")
  })
  user_logged_in <- reactiveVal(FALSE)
  
  output$alumni_names <- renderUI({
    # Connect to the database
    con <- dbConnect(
      RPostgres::Postgres(),
      dbname = "alumini",
      host = "localhost",
      port = 5432,
      user = "postgres",
      password = "123"
    )
    
    # Query to retrieve alumni names
    alumni_names <- dbGetQuery(con, "SELECT name FROM alumni")
    
    # Disconnect from the database
    dbDisconnect(con)
    
    # Extract the names from the query result
    choices <- alumni_names$name
    print('123')
    print(choices)
    # Sample 5 random choices

    # Create a select input with the sampled choices
    selectInput("alumni_names", "Alumni Names", choices = choices)
  })
  
  output$mentor_names <- renderUI({
    # Connect to the database
    con <- dbConnect(
      RPostgres::Postgres(),
      dbname = "alumini",
      host = "localhost",
      port = 5432,
      user = "postgres",
      password = "123"
    )
    
    # Query to retrieve alumni names
    mentor_names <- dbGetQuery(con, "SELECT name FROM alumni")
    
    # Disconnect from the database
    dbDisconnect(con)
    
    # Extract the names from the query result
    choices <- mentor_names$name
    print('123')
    print(choices)
    # Sample 5 random choices
    
    # Create a select input with the sampled choices
    selectInput("mentor_names", "Mentor Names", choices = choices)
  })
  
  output$mentee_names <- renderUI({
    # Connect to the database
    con <- dbConnect(
      RPostgres::Postgres(),
      dbname = "alumini",
      host = "localhost",
      port = 5432,
      user = "postgres",
      password = "123"
    )
    
    # Query to retrieve alumni names
    mentee_names <- dbGetQuery(con, "SELECT name FROM alumni")
    
    # Disconnect from the database
    dbDisconnect(con)
    
    # Extract the names from the query result
    choices <- mentee_names$name
    print('123')
    print(choices)
    # Sample 5 random choices
    
    # Create a select input with the sampled choices
    selectInput("mentee_names", "Mentee Names", choices = choices)
  })
  
  
  # Alumni Listing
  output$alumni_table <- renderDataTable({
    alumni_data <- dbGetQuery(con, "SELECT Name, GraduationYear, Degree, CurrentPosition, Organization, Industry, Location FROM Alumni")
    print(alumni_data)  # Check the data returned by the query
    str(alumni_data)    # Inspect the structure of the data frame
    
    # Return the alumni data
    return(alumni_data)
  })
  
  
  observeEvent(input$submit_logout, {
    shinyjs::hide("navbar_tabs")
    runjs("$('#submit_logout').css('display','none');")
    runjs("$('a[data-value=\"Login\"]').css('display','block');")
    shinyjs::show("login")
    runjs("$('a[data-value=\"Login\"]').click();")
    
  })
  
  
  observeEvent(input$submit_login, {
    # Connect to the database
    
    con <- dbConnect(RPostgres::Postgres(), dbname = "alumini", host = "localhost", port = 5432, user = "postgres", password = "123")
    print(con)
    # Construct the SQL query to check user credentials and retrieve role
    qry <- paste0("SELECT role FROM Users WHERE username = '", input$username, "' AND password = '", input$password, "'")
    
    # Execute the query
    user_role <- dbGetQuery(con, qry)
    
    # Close the database connection
    dbDisconnect(con)
    
    # Check if a user with the provided credentials exists
    if (nrow(user_role) > 0) {
      print(user_role$role[1])
      user_logged_in(TRUE)
      runjs("$('a[data-value=\"Alumni Listing\"]').click();")
      runjs("$('a[data-value=\"Login\"]').css('display','none');")
      runjs("$('#submit_logout').css('display','block');")
      
      if (user_role$role[1] == "admin") {
        # Show all tabs
        shinyjs::hide("login")  # Hide the login tab panel
        shinyjs::show("navbar_tabs")  # Show all other tab panels
        
        
      } else {
        # Show only the Alumni tab
        shinyjs::hide("login")  # Hide the login and create event tab panels
        shinyjs::show("navbar_tabs")  # Show all other tab panels
        runjs("$('a[data-value=\"Create Event\"]').css('display','none');")
        runjs("$('a[data-value=\"Alumni Listing\"]').css('display','none');")
        runjs("$('a[data-value=\"Job Postings\"]').css('display','none');")
        runjs("$('a[data-value=\"Create Job Posting\"]').css('display','none');")
        runjs("$('a[data-value=\"Mentorship Listing\"]').css('display','none');")
        
        
        
      }
    } else {
      # Show error message for invalid credentials
      showModal(modalDialog(
        title = "Error",
        "Invalid username or password. Please try again.",
        footer = NULL,
        easyClose = TRUE  # Add this parameter to enable the close button
        
      ))
    }
  })


  
  # Alumni Create
  observeEvent(input$submit_alumni, {
    # Construct query to insert values into the Alumni table
    qry <- paste0("INSERT INTO Alumni (Name, GraduationYear, Degree, CurrentPosition, Organization, Industry, Location) ",
                  "VALUES ('", input$name, "', ", input$graduation_year, ", '", input$degree, "', '", input$current_position, "', '", 
                  input$organization, "', '", input$industry, "', '", input$location, "')")
    
    # Query to send to the database
    dbSendQuery(conn = con, statement = qry)
    
    qry <- paste0("INSERT INTO users (username, password, role) ",
                  "VALUES ('", input$alumini_username, "', '", input$alumini_password, "', 'user')")
    
    
    # Query to send to the database
    dbSendQuery(conn = con, statement = qry)
    
    # Show modal dialog to user when the update to the database table is successful
    showModal(
      modalDialog(
        title = "Alumni Data Inserted",
        br(),
        div(tags$b("You have inserted the data into the Alumni table"), style = "color: green;")
      )
    )
    output$alumni_table <- renderDataTable({
      alumni_data <- dbGetQuery(con, "SELECT Name, GraduationYear, Degree, CurrentPosition, Organization, Industry, Location FROM Alumni")
      print(alumni_data)  # Check the data returned by the query
      str(alumni_data)    # Inspect the structure of the data frame
      
      # Return the alumni data
      return(alumni_data)
    })
  })
  
  # Job Postings
  output$job_postings_table <- renderDataTable({
    dbGetQuery(con, "SELECT al.name AS alumni_name, jp.company, jp.title, jp.description, jp.location AS job_location, jp.lastdatetoapply AS last_date_to_apply, jp.apply AS apply FROM jobpostings AS jp INNER JOIN alumni AS al ON jp.constituentid = al.constituentid")
  })
  
  # Dynamic UI for Alumni Name dropdown
  output$alumni_name <- renderUI({
    selectInput("alumni_name", "Alumni Name", choices = sqlOutput())
  })
  
  selected_alumni <- reactive({
    input$alumni_names
  })
  
  selected_mentor <- reactive({
    input$mentor_names
  })
  
  selected_mentee <- reactive({
    input$mentee_names
  })
  
  # Create Job Posting
  observeEvent(input$submit_job_posting, {
    # Connect to the database
    con <- dbConnect(
      RPostgres::Postgres(),
      dbname = "alumini",
      host = "localhost",
      port = 5432,
      user = "postgres",
      password = "123"
    )
    
    selected_name <- selected_alumni()
    
    # Query to retrieve alumni ID
    qry_alumni_id <- paste0("SELECT constituentid FROM alumni WHERE name = '", selected_name, "' LIMIT 1")
    print(selected_name)
    print(qry_alumni_id)
    alumni_id <- dbGetQuery(con, qry_alumni_id)
    
    # Extract alumni ID
    alumni_id <- alumni_id$constituentid
    
    # Construct query to insert values into the JobPostings table
    qry_insert <- paste0("INSERT INTO JobPostings (constituentid, company, title, description, location, lastdatetoapply, posteddate) ",
                         "VALUES ('", alumni_id, "', '", input$company, "', '", input$title, "', '", input$description, "', '", input$job_location, "', '", input$job_last_date_to_apply, "', CURRENT_DATE)")
    
    # Execute the insert query
    dbSendQuery(conn = con, statement = qry_insert)
    
    # Query to retrieve updated job postings
    qry_jobs <- "SELECT al.name AS alumni_name, jp.company, jp.title, jp.description, jp.location AS job_location, jp.lastdatetoapply AS last_date_to_apply, jp.apply AS apply FROM jobpostings AS jp INNER JOIN alumni AS al ON jp.constituentid = al.constituentid"
    jobs <- dbGetQuery(con, qry_jobs)
    
    # Disconnect from the database
    dbDisconnect(con)
    
    # Update the job postings table
    output$job_postings_table <- renderDataTable({
      return(jobs)
    })
    
    # Show modal dialog to user when the update to the database table is successful
    showModal(
      modalDialog(
        title = "Job Posting Data Inserted",
        br(),
        div(tags$b("You have inserted the data into the JobPostings table"), style = "color: green;")
      )
    )
  })
  
  
  # Events Listing
  output$events_table <- renderDataTable({
    dbGetQuery(con, "SELECT eventName, description, location, dateTime, register, organizedby, latedate as LastDate FROM events")
  })
  
  # Create Event
  observeEvent(input$submit_event, {
    # Construct query to insert values into the Events table
    qry <- paste0("INSERT INTO Events (EventName, Description, Location, DateTime, organizedby, latedate) ",
                  "VALUES ('", input$event_name, "', '", input$event_description, "', '", input$event_location, "', '", input$event_date, "', '", input$event_organized_by, "', '", input$event_late_date, "')")
    
    # Query to send to the database
    dbSendQuery(conn = con, statement = qry)
    
    output$events_table <- renderDataTable({
      dbGetQuery(con, "SELECT EventName, Description, Location, DateTime, organizedby, latedate as LastDate, Register FROM Events")
    })
    # Show modal dialog to user when the update to the database table is successful
    showModal(
      modalDialog(
        title = "Event Data Inserted",
        br(),
        div(tags$b("You have inserted the data into the Events table"), style = "color: green;")
      )
    )
  })
  
  # Mentorship Listing
  output$mentorship_table <- renderDataTable({
    dbGetQuery(con, "SELECT m.startyear, m.endyear, m.feedback, a_mentor.name AS mentor_name, a_mentee.name AS mentee_name FROM mentorship AS m INNER JOIN alumni AS a_mentor ON m.mentorid = a_mentor.constituentid INNER JOIN alumni AS a_mentee ON m.menteeid = a_mentee.constituentid")
  })
  
  
  # Create Mentorship
  observeEvent(input$submit_mentorship, {
    # Construct query to insert values into the Mentorship table
    
    selected_mentor_name <- selected_mentor()
    
    # Query to retrieve alumni ID
    qry_alumni_id <- paste0("SELECT constituentid FROM alumni WHERE name = '", selected_mentor_name, "' LIMIT 1")
    mentor_id <- dbGetQuery(con, qry_alumni_id)
    
    # Extract alumni ID
    mentor_id <- mentor_id$constituentid
    
    
    selected_mentee_name <- selected_mentee()
    
    # Query to retrieve alumni ID
    qry_alumni_id <- paste0("SELECT constituentid FROM alumni WHERE name = '", selected_mentee_name, "' LIMIT 1")
    mentee_id <- dbGetQuery(con, qry_alumni_id)
    
    # Extract alumni ID
    mentee_id <- mentee_id$constituentid
    qry <- paste0("INSERT INTO Mentorship (MentorID, MenteeID, StartYear, EndYear, Feedback) ",
                  "VALUES ('", mentor_id, "', '", mentee_id, "', ", input$start_year, ", ", input$end_year, ", '", input$feedback, "')")
    
    # Query to send to the database
    dbSendQuery(conn = con, statement = qry)
    
    output$mentorship_table <- renderDataTable({
      dbGetQuery(con, "SELECT m.startyear, m.endyear, m.feedback, a_mentor.name AS mentor_name, a_mentee.name AS mentee_name FROM mentorship AS m INNER JOIN alumni AS a_mentor ON m.mentorid = a_mentor.constituentid INNER JOIN alumni AS a_mentee ON m.menteeid = a_mentee.constituentid")
    })
    
    # Show modal dialog to user when the update to the database table is successful
    showModal(
      modalDialog(
        title = "Mentorship Data Inserted",
        br(),
        div(tags$b("You have inserted the data into the Mentorship table"), style = "color: green;")
      )
    )
  })
  

  
  
  # Connect to PostgreSQL database
  con <- dbConnect(
    RPostgres::Postgres(),
    dbname = "alumini",
    host = "localhost",
    port = 5432,
    user = "postgres",
    password = "123"
  )
  
  # Disconnect from database on session end
  session$onSessionEnded(function() {
    dbDisconnect(con)
  })
}

shinyApp(ui, server)
