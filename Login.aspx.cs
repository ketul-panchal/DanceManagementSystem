using System;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.Web.Security;

public partial class Login : System.Web.UI.Page
{
    protected void btnLogin_Click(object sender, EventArgs e)
    {
        string connString = WebConfigurationManager.ConnectionStrings["DanceDB"].ConnectionString;

        using (SqlConnection conn = new SqlConnection(connString))
        {
            conn.Open();
            string query = "SELECT UserID, FullName, Role FROM Users WHERE Email = @Email AND PasswordHash = @Password";
            SqlCommand cmd = new SqlCommand(query, conn);
            cmd.Parameters.AddWithValue("@Email", txtEmail.Text);
            cmd.Parameters.AddWithValue("@Password", txtPassword.Text); // 🔴 In production, use password hashing!

            SqlDataReader reader = cmd.ExecuteReader();
            if (reader.Read())
            {
                // Store user session
                Session["UserID"] = reader["UserID"].ToString();
                Session["FullName"] = reader["FullName"].ToString();
                Session["Role"] = reader["Role"].ToString();

                // Redirect based on role
                string role = reader["Role"].ToString();
                if (role == "Admin")
                    Response.Redirect("AdminDashboard.aspx");
                else if (role == "Instructor")
                    Response.Redirect("InstructorDashboard.aspx");
                else
                    Response.Redirect("UserDashboard.aspx");
            }
            else
            {
                lblMessage.Text = "Invalid Email or Password!";
            }
        }
    }
}
