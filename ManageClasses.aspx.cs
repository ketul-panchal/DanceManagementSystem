using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ManageClasses : Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadInstructors();
            LoadClasses();
        }
    }

    private void LoadInstructors()
    {
        string connStr = WebConfigurationManager.ConnectionStrings["DanceDB"].ConnectionString;

        using (SqlConnection conn = new SqlConnection(connStr))
        {
            conn.Open();
            SqlCommand cmd = new SqlCommand("SELECT UserID, FullName FROM Users WHERE Role = 'Instructor'", conn);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            ddlInstructor.DataSource = dt;
            ddlInstructor.DataTextField = "FullName";
            ddlInstructor.DataValueField = "UserID";
            ddlInstructor.DataBind();

            ddlInstructor.Items.Insert(0, new ListItem("-- Select Instructor --", ""));
        }
    }

    private void LoadClasses()
    {
        string connStr = WebConfigurationManager.ConnectionStrings["DanceDB"].ConnectionString;

        using (SqlConnection conn = new SqlConnection(connStr))
        {
            conn.Open();
            string query = @"
                SELECT Classes.ClassID, Classes.ClassName, Classes.DanceStyle, Users.FullName AS InstructorName, 
                       Classes.Schedule, Classes.MaxCapacity
                FROM Classes
                INNER JOIN Users ON Classes.InstructorID = Users.UserID";

            SqlCommand cmd = new SqlCommand(query, conn);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            gvClasses.DataSource = dt;
            gvClasses.DataBind();
        }
    }

    protected void btnAddUpdate_Click(object sender, EventArgs e)
    {
        string connStr = WebConfigurationManager.ConnectionStrings["DanceDB"].ConnectionString;

        using (SqlConnection conn = new SqlConnection(connStr))
        {
            conn.Open();
            SqlCommand cmd;

            if (ViewState["EditingClassID"] != null)
            {
                // Update class
                cmd = new SqlCommand("UPDATE Classes SET ClassName=@ClassName, DanceStyle=@DanceStyle, InstructorID=@InstructorID, Schedule=@Schedule, MaxCapacity=@MaxCapacity WHERE ClassID=@ClassID", conn);
                cmd.Parameters.AddWithValue("@ClassID", ViewState["EditingClassID"]);
                ViewState["EditingClassID"] = null;
            }
            else
            {
                // Insert new class
                cmd = new SqlCommand("INSERT INTO Classes (ClassName, DanceStyle, InstructorID, Schedule, MaxCapacity) VALUES (@ClassName, @DanceStyle, @InstructorID, @Schedule, @MaxCapacity)", conn);
            }

            cmd.Parameters.AddWithValue("@ClassName", txtClassName.Text);
            cmd.Parameters.AddWithValue("@DanceStyle", txtDanceStyle.Text);
            cmd.Parameters.AddWithValue("@InstructorID", ddlInstructor.SelectedValue);
            cmd.Parameters.AddWithValue("@Schedule", txtSchedule.Text);
            cmd.Parameters.AddWithValue("@MaxCapacity", txtMaxCapacity.Text);

            cmd.ExecuteNonQuery();
        }

        txtClassName.Text = "";
        txtDanceStyle.Text = "";
        ddlInstructor.SelectedIndex = 0;
        txtSchedule.Text = "";
        txtMaxCapacity.Text = "";
        lblMessage.Text = "Class saved successfully!";
        lblMessage.ForeColor = System.Drawing.Color.Green;
        LoadClasses();
    }

    protected void btnEdit_Click(object sender, EventArgs e)
    {
        string classID = ((Button)sender).CommandArgument;
        string connStr = WebConfigurationManager.ConnectionStrings["DanceDB"].ConnectionString;

        using (SqlConnection conn = new SqlConnection(connStr))
        {
            conn.Open();
            SqlCommand cmd = new SqlCommand("SELECT * FROM Classes WHERE ClassID=@ClassID", conn);
            cmd.Parameters.AddWithValue("@ClassID", classID);
            SqlDataReader reader = cmd.ExecuteReader();

            if (reader.Read())
            {
                txtClassName.Text = reader["ClassName"].ToString();
                txtDanceStyle.Text = reader["DanceStyle"].ToString();
                ddlInstructor.SelectedValue = reader["InstructorID"].ToString();
                txtSchedule.Text = reader["Schedule"].ToString();
                txtMaxCapacity.Text = reader["MaxCapacity"].ToString();

                ViewState["EditingClassID"] = classID;
            }
        }
    }

    protected void btnDelete_Click(object sender, EventArgs e)
    {
        string classID = ((Button)sender).CommandArgument;
        string connStr = WebConfigurationManager.ConnectionStrings["DanceDB"].ConnectionString;

        using (SqlConnection conn = new SqlConnection(connStr))
        {
            conn.Open();
            SqlCommand cmd = new SqlCommand("DELETE FROM Classes WHERE ClassID = @ClassID", conn);
            cmd.Parameters.AddWithValue("@ClassID", classID);
            cmd.ExecuteNonQuery();
        }

        LoadClasses();
    }
}
