using System;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.Web.UI;

public partial class UserProfile : Page
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
                LoadUserProfile();
            }
        }
    }

    private void LoadUserProfile()
    {
        int userId = Convert.ToInt32(Session["UserID"]);

        string connString = WebConfigurationManager.ConnectionStrings["DanceDB"].ConnectionString;
        string query = "SELECT FullName, Email, Contact, Address FROM Users WHERE UserID = @UserID";

        using (SqlConnection conn = new SqlConnection(connString))
        using (SqlCommand cmd = new SqlCommand(query, conn))
        {
            cmd.Parameters.AddWithValue("@UserID", userId);
            conn.Open();
            SqlDataReader reader = cmd.ExecuteReader();

            if (reader.Read())
            {
                txtFullName.Text = reader["FullName"].ToString();
                txtEmail.Text = reader["Email"].ToString();
                txtContact.Text = reader["Contact"].ToString();
                txtAddress.Text = reader["Address"].ToString();
            }
        }
    }

    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        int userId = Convert.ToInt32(Session["UserID"]);

        string connString = WebConfigurationManager.ConnectionStrings["DanceDB"].ConnectionString;
        string query = "UPDATE Users SET FullName=@FullName, Contact=@Contact, Address=@Address WHERE UserID=@UserID";

        using (SqlConnection conn = new SqlConnection(connString))
        using (SqlCommand cmd = new SqlCommand(query, conn))
        {
            cmd.Parameters.AddWithValue("@FullName", txtFullName.Text);
            cmd.Parameters.AddWithValue("@Contact", txtContact.Text);
            cmd.Parameters.AddWithValue("@Address", txtAddress.Text);
            cmd.Parameters.AddWithValue("@UserID", userId);

            conn.Open();
            int rows = cmd.ExecuteNonQuery();

            if (rows > 0)
            {
                lblMessage.Text = "Profile updated successfully!";
                lblMessage.ForeColor = System.Drawing.Color.Green;
            }
            else
            {
                lblMessage.Text = "Update failed. Please try again.";
                lblMessage.ForeColor = System.Drawing.Color.Red;
            }
        }
    }
}
