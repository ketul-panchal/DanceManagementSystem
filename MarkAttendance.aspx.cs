using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class MarkAttendance : Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["UserID"] == null || Session["Role"] == null || Session["Role"].ToString() != "Instructor")
            {
                // Redirect if not logged in or not an instructor
                Response.Redirect("Login.aspx");
            }
            else
            {
                // Load classes taught by the current instructor
                LoadClasses();
            }
        }
    }

    /// <summary>
    /// Loads all classes for the instructor currently logged in.
    /// </summary>
    private void LoadClasses()
    {
        int instructorId = Convert.ToInt32(Session["UserID"]);
        string connString = WebConfigurationManager.ConnectionStrings["DanceDB"].ConnectionString;
        string query = "SELECT ClassID, ClassName FROM Classes WHERE InstructorID = @InstructorID";

        using (SqlConnection conn = new SqlConnection(connString))
        using (SqlCommand cmd = new SqlCommand(query, conn))
        {
            cmd.Parameters.AddWithValue("@InstructorID", instructorId);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            ddlClass.DataSource = dt;
            ddlClass.DataTextField = "ClassName";
            ddlClass.DataValueField = "ClassID";
            ddlClass.DataBind();
        }

        // Insert a default item at the top
        ddlClass.Items.Insert(0, new ListItem("Select Class", ""));
    }

    /// <summary>
    /// Loads all dancers enrolled in the selected class.
    /// </summary>
    private void LoadDancers(int classID)
    {
        string connString = WebConfigurationManager.ConnectionStrings["DanceDB"].ConnectionString;
        string query = @"
            SELECT U.UserID, U.FullName 
            FROM Enrollments E
            JOIN Users U ON E.UserID = U.UserID
            WHERE E.ClassID = @ClassID";

        using (SqlConnection conn = new SqlConnection(connString))
        using (SqlCommand cmd = new SqlCommand(query, conn))
        {
            cmd.Parameters.AddWithValue("@ClassID", classID);

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            gvAttendance.DataSource = dt;
            gvAttendance.DataBind();
        }
    }

    protected void btnLoadDancers_Click(object sender, EventArgs e)
    {
        // Validate that a class was actually selected
        if (!string.IsNullOrEmpty(ddlClass.SelectedValue))
        {
            int classId = int.Parse(ddlClass.SelectedValue);
            LoadDancers(classId);
            lblMessage.Text = ""; // clear any previous message
        }
        else
        {
            lblMessage.Text = "Please select a class first.";
            lblMessage.ForeColor = System.Drawing.Color.Red;
        }
    }

    protected void btnMarkAttendance_Click(object sender, EventArgs e)
    {
        // Ensure a class is selected
        if (string.IsNullOrEmpty(ddlClass.SelectedValue))
        {
            lblMessage.Text = "Please select a class first.";
            lblMessage.ForeColor = System.Drawing.Color.Red;
            return;
        }

        string connString = WebConfigurationManager.ConnectionStrings["DanceDB"].ConnectionString;
        using (SqlConnection conn = new SqlConnection(connString))
        {
            conn.Open();

            // For each row in the GridView, insert attendance status
            foreach (GridViewRow row in gvAttendance.Rows)
            {
                // Get the UserID from the DataKeys collection
                int userID = Convert.ToInt32(gvAttendance.DataKeys[row.RowIndex].Value);

                // Find the DropDownList that lets us pick "Present" or "Absent"
                DropDownList ddlStatus = (DropDownList)row.FindControl("ddlStatus");

                SqlCommand cmd = new SqlCommand(@"
                    INSERT INTO Attendance (UserID, ClassID, Date, Status) 
                    VALUES (@UserID, @ClassID, @Date, @Status)", conn);

                cmd.Parameters.AddWithValue("@UserID", userID);
                cmd.Parameters.AddWithValue("@ClassID", ddlClass.SelectedValue);
                cmd.Parameters.AddWithValue("@Date", DateTime.Now);
                cmd.Parameters.AddWithValue("@Status", ddlStatus.SelectedValue);

                cmd.ExecuteNonQuery();
            }

            lblMessage.Text = "Attendance marked successfully!";
            lblMessage.ForeColor = System.Drawing.Color.Green;
        }
    }
}
