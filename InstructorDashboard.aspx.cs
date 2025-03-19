using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.Web.UI;

public partial class InstructorDashboard : Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["UserID"] == null || Session["Role"].ToString() != "Instructor")
            {
                Response.Redirect("Login.aspx"); // Redirect unauthorized users
            }
            else
            {
                LoadInstructorInfo();
                LoadUpcomingClasses();
                LoadAnnouncements();
            }
        }
    }

    private void LoadInstructorInfo()
    {
        lblUserName.Text = (Session["FullName"] != null) ? Session["FullName"].ToString() : "Instructor";
    }

    private void LoadUpcomingClasses()
    {
        string query = @"
            SELECT ClassName, DanceStyle, Schedule 
            FROM Classes WHERE InstructorID = @UserID";

        gvUpcomingClasses.DataSource = GetData(query);
        gvUpcomingClasses.DataBind();
    }

    private void LoadAnnouncements()
    {
        string query = "SELECT Title, Message, DatePosted FROM Announcements ORDER BY DatePosted DESC";
        gvAnnouncements.DataSource = GetData(query);
        gvAnnouncements.DataBind();
    }

    private DataTable GetData(string query)
    {
        string connString = WebConfigurationManager.ConnectionStrings["DanceDB"].ConnectionString;
        using (SqlConnection conn = new SqlConnection(connString))
        using (SqlCommand cmd = new SqlCommand(query, conn))
        {
            cmd.Parameters.AddWithValue("@UserID", Session["UserID"]);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            return dt;
        }
    }
}
