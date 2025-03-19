using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.Web.UI;

public partial class UserDashboard : Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("Login.aspx"); // Redirect to login if session is null
            }
            else
            {
                LoadUserInfo();
                LoadUpcomingClasses();
                LoadAttendanceSummary();
                LoadRegisteredEvents();
                LoadAnnouncements();
            }
        }
    }

    private void LoadUserInfo()
    {
        lblUserName.Text = (Session["FullName"] != null) ? Session["FullName"].ToString() : "User";
    }

    private void LoadUpcomingClasses()
    {
        int userId = Convert.ToInt32(Session["UserID"]); // Ensure valid integer ID

        string query = @"
            SELECT C.ClassName, C.DanceStyle, C.Schedule, U.FullName AS Instructor
            FROM Enrollments E
            JOIN Classes C ON E.ClassID = C.ClassID
            JOIN Users U ON C.InstructorID = U.UserID
            WHERE E.UserID = @UserID";

        gvUpcomingClasses.DataSource = GetData(query, userId);
        gvUpcomingClasses.DataBind();
    }

    private void LoadAttendanceSummary()
    {
        int userId = Convert.ToInt32(Session["UserID"]);

        string queryPresent = "SELECT COUNT(*) FROM Attendance WHERE UserID=@UserID AND Status='Present'";
        string queryAbsent = "SELECT COUNT(*) FROM Attendance WHERE UserID=@UserID AND Status='Absent'";

        lblDaysPresent.Text = GetScalarValue(queryPresent, userId);
        lblDaysAbsent.Text = GetScalarValue(queryAbsent, userId);
    }

    private void LoadRegisteredEvents()
    {
        int userId = Convert.ToInt32(Session["UserID"]);

        string query = @"
            SELECT EventName, EventDate, Location 
            FROM EventParticipants EP 
            JOIN Events E ON EP.EventID = E.EventID 
            WHERE EP.UserID = @UserID";

        gvRegisteredEvents.DataSource = GetData(query, userId);
        gvRegisteredEvents.DataBind();
    }

    private void LoadAnnouncements()
    {
        string query = "SELECT Title, Message, DatePosted FROM Announcements ORDER BY DatePosted DESC";

        gvAnnouncements.DataSource = GetData(query, null); // No UserID needed for announcements
        gvAnnouncements.DataBind();
    }

    private DataTable GetData(string query, int? userId)
    {
        string connString = WebConfigurationManager.ConnectionStrings["DanceDB"].ConnectionString;
        DataTable dt = new DataTable();

        using (SqlConnection conn = new SqlConnection(connString))
        using (SqlCommand cmd = new SqlCommand(query, conn))
        {
            if (userId.HasValue)
                cmd.Parameters.AddWithValue("@UserID", userId);

            using (SqlDataAdapter da = new SqlDataAdapter(cmd))
            {
                da.Fill(dt);
            }
        }
        return dt;
    }

    private string GetScalarValue(string query, int userId)
    {
        string connString = WebConfigurationManager.ConnectionStrings["DanceDB"].ConnectionString;
        using (SqlConnection conn = new SqlConnection(connString))
        using (SqlCommand cmd = new SqlCommand(query, conn))
        {
            cmd.Parameters.AddWithValue("@UserID", userId);
            conn.Open();
            object result = cmd.ExecuteScalar();
            return (result != null) ? result.ToString() : "0";
        }
    }
}
