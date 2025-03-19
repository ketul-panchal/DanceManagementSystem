using System;
using System.Data.SqlClient;
using System.Web.Configuration;

public partial class Signup : System.Web.UI.Page
{
    protected void btnSignup_Click(object sender, EventArgs e)
    {
        if (txtPassword.Text != txtConfirmPassword.Text)
        {
            lblMessage.Text = "Passwords do not match!";
            return;
        }

        string connString = WebConfigurationManager.ConnectionStrings["DanceDB"].ConnectionString;

        using (SqlConnection conn = new SqlConnection(connString))
        {
            conn.Open();

            // Check if email already exists
            SqlCommand checkEmail = new SqlCommand("SELECT COUNT(*) FROM Users WHERE Email = @Email", conn);
            checkEmail.Parameters.AddWithValue("@Email", txtEmail.Text);
            int count = (int)checkEmail.ExecuteScalar();

            if (count > 0)
            {
                lblMessage.Text = "Error: Email already exists!";
                return;
            }

            // Insert new user
            string query = "INSERT INTO Users (FullName, Email, PasswordHash, Role) VALUES (@FullName, @Email, @Password, @Role)";
            SqlCommand cmd = new SqlCommand(query, conn);
            cmd.Parameters.AddWithValue("@FullName", txtFullName.Text);
            cmd.Parameters.AddWithValue("@Email", txtEmail.Text);
            cmd.Parameters.AddWithValue("@Password", txtPassword.Text); // 🔴 Hash the password in a real project!
            cmd.Parameters.AddWithValue("@Role", ddlRole.SelectedValue);

            int rows = cmd.ExecuteNonQuery();
            if (rows > 0)
            {
                lblMessage.Text = "Signup successful! You can now log in.";
                lblMessage.ForeColor = System.Drawing.Color.Green;
                Response.Redirect("Login.aspx");
            }
            else
            {
                lblMessage.Text = "Signup failed. Try again.";
            }
        }
    }
}
