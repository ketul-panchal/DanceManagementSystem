using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.Web.UI.WebControls;

public partial class ManageEnrollments : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadDancers();
            LoadClasses();
            LoadEnrollments();
        }
    }

    // Load Dancers (Users with Role 'Dancer')
    private void LoadDancers()
    {
        string connString = WebConfigurationManager.ConnectionStrings["DanceDB"].ConnectionString;
        using (SqlConnection conn = new SqlConnection(connString))
        {
            conn.Open();
            SqlCommand cmd = new SqlCommand("SELECT UserID, FullName FROM Users WHERE Role = 'Dancer'", conn);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            ddlDancer.DataSource = dt;
            ddlDancer.DataTextField = "FullName";
            ddlDancer.DataValueField = "UserID";
            ddlDancer.DataBind();
            ddlDancer.Items.Insert(0, new ListItem("Select Dancer", ""));
        }
    }

    // Load Classes
    private void LoadClasses()
    {
        string connString = WebConfigurationManager.ConnectionStrings["DanceDB"].ConnectionString;
        using (SqlConnection conn = new SqlConnection(connString))
        {
            conn.Open();
            SqlCommand cmd = new SqlCommand("SELECT ClassID, ClassName FROM Classes", conn);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            ddlClass.DataSource = dt;
            ddlClass.DataTextField = "ClassName";
            ddlClass.DataValueField = "ClassID";
            ddlClass.DataBind();
            ddlClass.Items.Insert(0, new ListItem("Select Class", ""));
        }
    }

    // Load Enrollments
    private void LoadEnrollments()
    {
        string connString = WebConfigurationManager.ConnectionStrings["DanceDB"].ConnectionString;
        using (SqlConnection conn = new SqlConnection(connString))
        {
            conn.Open();
            string query = @"SELECT E.EnrollmentID, U.FullName AS DancerName, C.ClassName, E.EnrolledOn
                             FROM Enrollments E
                             INNER JOIN Users U ON E.UserID = U.UserID
                             INNER JOIN Classes C ON E.ClassID = C.ClassID";

            SqlCommand cmd = new SqlCommand(query, conn);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            gvEnrollments.DataSource = dt;
            gvEnrollments.DataBind();
        }
    }

    // Enroll Dancer in Class
    protected void btnEnroll_Click(object sender, EventArgs e)
    {
        if (ddlDancer.SelectedValue == "" || ddlClass.SelectedValue == "")
        {
            lblMessage.Text = "Please select both Dancer and Class.";
            lblMessage.ForeColor = System.Drawing.Color.Red;
            return;
        }

        string connString = WebConfigurationManager.ConnectionStrings["DanceDB"].ConnectionString;
        using (SqlConnection conn = new SqlConnection(connString))
        {
            conn.Open();

            // Check if the user is already enrolled in the class
            SqlCommand checkCmd = new SqlCommand("SELECT COUNT(*) FROM Enrollments WHERE UserID = @UserID AND ClassID = @ClassID", conn);
            checkCmd.Parameters.AddWithValue("@UserID", ddlDancer.SelectedValue);
            checkCmd.Parameters.AddWithValue("@ClassID", ddlClass.SelectedValue);
            int count = (int)checkCmd.ExecuteScalar();

            if (count > 0)
            {
                lblMessage.Text = "This dancer is already enrolled in this class.";
                lblMessage.ForeColor = System.Drawing.Color.Red;
                return;
            }

            // Insert new enrollment
            SqlCommand cmd = new SqlCommand("INSERT INTO Enrollments (UserID, ClassID, EnrolledOn) VALUES (@UserID, @ClassID, GETDATE())", conn);
            cmd.Parameters.AddWithValue("@UserID", ddlDancer.SelectedValue);
            cmd.Parameters.AddWithValue("@ClassID", ddlClass.SelectedValue);
            cmd.ExecuteNonQuery();

            lblMessage.Text = "Dancer successfully enrolled!";
            lblMessage.ForeColor = System.Drawing.Color.Green;

            LoadEnrollments();
        }
    }

    // Remove Enrollment
    protected void btnDelete_Click(object sender, EventArgs e)
    {
        string enrollmentID = ((Button)sender).CommandArgument;
        string connString = WebConfigurationManager.ConnectionStrings["DanceDB"].ConnectionString;
        using (SqlConnection conn = new SqlConnection(connString))
        {
            conn.Open();
            SqlCommand cmd = new SqlCommand("DELETE FROM Enrollments WHERE EnrollmentID = @EnrollmentID", conn);
            cmd.Parameters.AddWithValue("@EnrollmentID", enrollmentID);
            cmd.ExecuteNonQuery();
        }

        lblMessage.Text = "Enrollment removed successfully.";
        lblMessage.ForeColor = System.Drawing.Color.Green;
        LoadEnrollments();
    }
}
