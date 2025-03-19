using System;

public partial class Logout : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        // Clear all session variables
        Session.Clear();

        // Abandon the session
        Session.Abandon();

        // Redirect to Login page after clearing session
        Response.Redirect("Login.aspx");
    }
}
