using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ManageAttendance : Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadClasses();
        }
    }

    private void LoadClasses()
    {
        string connString = WebConfigurationManager.ConnectionStrings["DanceDB"].ConnectionString;

        using (SqlConnection conn = new SqlConnection(connString))
        {
            conn.Open();
            SqlCommand cmd = new SqlCommand("SELECT ClassID, ClassName FROM Classes", conn);
            SqlDataReader reader = cmd.ExecuteReader();

            ddlClass.DataSource = reader;
            ddlClass.DataTextField = "ClassName";
            ddlClass.DataValueField = "ClassID";
            ddlClass.DataBind();
            ddlClass.Items.Insert(0, new ListItem("Select Class", ""));
        }
    }

    protected void ddlClass_SelectedIndexChanged(object sender, EventArgs e)
    {
        LoadDancers();
    }

    protected void btnLoadDancers_Click(object sender, EventArgs e)
    {
        LoadDancers();
    }

    private void LoadDancers()
    {
        if (string.IsNullOrEmpty(ddlClass.SelectedValue))
        {
            lblMessage.Text = "Please select a class first!";
            lblMessage.ForeColor = System.Drawing.Color.Red;
            return;
        }

        string connString = WebConfigurationManager.ConnectionStrings["DanceDB"].ConnectionString;

        using (SqlConnection conn = new SqlConnection(connString))
        {
            conn.Open();
            SqlCommand cmd = new SqlCommand("SELECT U.UserID, U.FullName FROM Enrollments E JOIN Users U ON E.UserID = U.UserID WHERE E.ClassID = @ClassID", conn);
            cmd.Parameters.AddWithValue("@ClassID", ddlClass.SelectedValue);

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            gvAttendance.DataSource = dt;
            gvAttendance.DataBind();
        }
    }

    protected void btnPresent_Click(object sender, EventArgs e)
    {
        Button btn = (Button)sender;
        int userID = Convert.ToInt32(btn.CommandArgument);
        MarkAttendance(userID, "Present");
    }

    protected void btnAbsent_Click(object sender, EventArgs e)
    {
        Button btn = (Button)sender;
        int userID = Convert.ToInt32(btn.CommandArgument);
        MarkAttendance(userID, "Absent");
    }

    private void MarkAttendance(int userID, string status)
    {
        string connString = WebConfigurationManager.ConnectionStrings["DanceDB"].ConnectionString;

        using (SqlConnection conn = new SqlConnection(connString))
        {
            conn.Open();
            SqlCommand cmd = new SqlCommand(@"INSERT INTO Attendance (UserID, ClassID, Date, Status) 
                                              VALUES (@UserID, @ClassID, @Date, @Status)", conn);

            cmd.Parameters.AddWithValue("@UserID", userID);
            cmd.Parameters.AddWithValue("@ClassID", ddlClass.SelectedValue);
            cmd.Parameters.AddWithValue("@Date", DateTime.Now);
            cmd.Parameters.AddWithValue("@Status", status);

            cmd.ExecuteNonQuery();
        }

        lblMessage.Text = "Attendance updated successfully!";
        lblMessage.ForeColor = System.Drawing.Color.Green;

        LoadDancers(); // Refresh the grid to show the updated status
    }
}
