using System;
using System.Data.SqlClient;
using System.Web.Configuration;

public partial class AdminDashboard : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadDashboardStats();
            LoadAnnouncements();
        }
    }

    private void LoadDashboardStats()
    {
        string connString = WebConfigurationManager.ConnectionStrings["DanceDB"].ConnectionString;
        using (SqlConnection conn = new SqlConnection(connString))
        {
            conn.Open();
            lblTotalUsers.Text = new SqlCommand("SELECT COUNT(*) FROM Users", conn).ExecuteScalar().ToString();
            lblActiveClasses.Text = new SqlCommand("SELECT COUNT(*) FROM Classes", conn).ExecuteScalar().ToString();
            lblTotalEnrollments.Text = new SqlCommand("SELECT COUNT(*) FROM Enrollments", conn).ExecuteScalar().ToString();
            lblUpcomingEvents.Text = new SqlCommand("SELECT COUNT(*) FROM Events WHERE EventDate >= GETDATE()", conn).ExecuteScalar().ToString();
        }
    }

    private void LoadAnnouncements()
    {
        string connString = WebConfigurationManager.ConnectionStrings["DanceDB"].ConnectionString;
        using (SqlConnection conn = new SqlConnection(connString))
        {
            conn.Open();
            SqlDataAdapter da = new SqlDataAdapter("SELECT TOP 5 DatePosted, Title, Message FROM Announcements ORDER BY DatePosted DESC", conn);
            System.Data.DataTable dt = new System.Data.DataTable();
            da.Fill(dt);
            gvAnnouncements.DataSource = dt;
            gvAnnouncements.DataBind();
        }
    }
}
