using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Configuration;


public partial class ManageUsers : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadUsers();
        }
    }

    private void LoadUsers()
    {
        string connStr = WebConfigurationManager.ConnectionStrings["DanceDB"].ConnectionString;
        using (SqlConnection conn = new SqlConnection(connStr))
        {
            conn.Open();
            SqlDataAdapter da = new SqlDataAdapter("SELECT UserID, FullName, Email, Role FROM Users", conn);
            DataTable dt = new DataTable();
            da.Fill(dt);
            gvUsers.DataSource = dt;
            gvUsers.DataBind();
        }
    }

    protected void btnAddUpdate_Click(object sender, EventArgs e)
    {
        string connStr = WebConfigurationManager.ConnectionStrings["DanceDB"].ConnectionString;
        using (SqlConnection conn = new SqlConnection(connStr))
        {
            conn.Open();
            SqlCommand cmd;

            if (ViewState["EditingUserID"] != null) // Updating an existing user
            {
                cmd = new SqlCommand("UPDATE Users SET FullName=@FullName, Email=@Email, Role=@Role WHERE UserID=@UserID", conn);
                cmd.Parameters.AddWithValue("@UserID", ViewState["EditingUserID"]);
                ViewState["EditingUserID"] = null;
            }
            else // Adding a new user
            {
                cmd = new SqlCommand("INSERT INTO Users (FullName, Email, PasswordHash, Role) VALUES (@FullName, @Email, @Password, @Role)", conn);
                cmd.Parameters.AddWithValue("@Password", txtPassword.Text); // Ensure passwords are hashed in real applications
            }

            cmd.Parameters.AddWithValue("@FullName", txtFullName.Text);
            cmd.Parameters.AddWithValue("@Email", txtEmail.Text);
            cmd.Parameters.AddWithValue("@Role", ddlRole.SelectedValue);

            cmd.ExecuteNonQuery();
        }

        txtFullName.Text = "";
        txtEmail.Text = "";
        txtPassword.Text = "";
        ddlRole.SelectedIndex = 0;
        LoadUsers();
    }

    // Edit User - Populate fields for editing
    protected void btnEdit_Click(object sender, EventArgs e)
    {
        string userID = ((Button)sender).CommandArgument;
        string connStr = WebConfigurationManager.ConnectionStrings["DanceDB"].ConnectionString;

        using (SqlConnection conn = new SqlConnection(connStr))
        {
            conn.Open();
            SqlCommand cmd = new SqlCommand("SELECT UserID, FullName, Email, Role FROM Users WHERE UserID=@UserID", conn);
            cmd.Parameters.AddWithValue("@UserID", userID);
            SqlDataReader reader = cmd.ExecuteReader();

            if (reader.Read())
            {
                txtFullName.Text = reader["FullName"].ToString();
                txtEmail.Text = reader["Email"].ToString();
                ddlRole.SelectedValue = reader["Role"].ToString();
                ViewState["EditingUserID"] = userID; // Store ID for updating
            }
        }
    }

    // Delete User
    protected void btnDelete_Click(object sender, EventArgs e)
    {
        string userID = ((Button)sender).CommandArgument;
        string connStr = WebConfigurationManager.ConnectionStrings["DanceDB"].ConnectionString;

        using (SqlConnection conn = new SqlConnection(connStr))
        {
            conn.Open();

            // Delete related event participation records first
            SqlCommand cmdEvents = new SqlCommand("DELETE FROM EventParticipants WHERE UserID = @UserID", conn);
            cmdEvents.Parameters.AddWithValue("@UserID", userID);
            cmdEvents.ExecuteNonQuery();

            // Delete related enrollments first
            SqlCommand cmdEnrollments = new SqlCommand("DELETE FROM Enrollments WHERE UserID = @UserID", conn);
            cmdEnrollments.Parameters.AddWithValue("@UserID", userID);
            cmdEnrollments.ExecuteNonQuery();

            // Now delete the user
            SqlCommand cmdUser = new SqlCommand("DELETE FROM Users WHERE UserID = @UserID", conn);
            cmdUser.Parameters.AddWithValue("@UserID", userID);
            cmdUser.ExecuteNonQuery();
        }

        LoadUsers();
    }


}
