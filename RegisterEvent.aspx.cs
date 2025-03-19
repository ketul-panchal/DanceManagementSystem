using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class RegisterEvent : Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadEvents();
            LoadRegisteredEvents();
        }
    }

    private void LoadEvents()
    {
        string connString = WebConfigurationManager.ConnectionStrings["DanceDB"].ConnectionString;

        using (SqlConnection conn = new SqlConnection(connString))
        {
            conn.Open();
            SqlCommand cmd = new SqlCommand("SELECT EventID, EventName FROM Events", conn);
            SqlDataReader reader = cmd.ExecuteReader();

            ddlEvent.DataSource = reader;
            ddlEvent.DataTextField = "EventName";
            ddlEvent.DataValueField = "EventID";
            ddlEvent.DataBind();
            ddlEvent.Items.Insert(0, new ListItem("Select Event", ""));
        }
    }

    private void LoadRegisteredEvents()
    {
        string connString = WebConfigurationManager.ConnectionStrings["DanceDB"].ConnectionString;
        int userId = Convert.ToInt32(Session["UserID"]);

        using (SqlConnection conn = new SqlConnection(connString))
        {
            conn.Open();
            SqlCommand cmd = new SqlCommand(@"
                SELECT E.EventName, E.EventDate, E.Location, EP.Role
                FROM EventParticipants EP
                JOIN Events E ON EP.EventID = E.EventID
                WHERE EP.UserID = @UserID", conn);

            cmd.Parameters.AddWithValue("@UserID", userId);

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            gvRegisteredEvents.DataSource = dt;
            gvRegisteredEvents.DataBind();
        }
    }

    protected void btnRegister_Click(object sender, EventArgs e)
    {
        if (ddlEvent.SelectedValue == "" || string.IsNullOrWhiteSpace(txtRole.Text))
        {
            lblMessage.Text = "Please select an event and enter a role.";
            lblMessage.ForeColor = System.Drawing.Color.Red;
            return;
        }

        string connString = WebConfigurationManager.ConnectionStrings["DanceDB"].ConnectionString;
        int userId = Convert.ToInt32(Session["UserID"]);

        using (SqlConnection conn = new SqlConnection(connString))
        {
            conn.Open();
            SqlCommand cmd = new SqlCommand(@"
                INSERT INTO EventParticipants (EventID, UserID, Role) 
                VALUES (@EventID, @UserID, @Role)", conn);

            cmd.Parameters.AddWithValue("@EventID", ddlEvent.SelectedValue);
            cmd.Parameters.AddWithValue("@UserID", userId);
            cmd.Parameters.AddWithValue("@Role", txtRole.Text);

            cmd.ExecuteNonQuery();
            lblMessage.Text = "Registration successful!";
            lblMessage.ForeColor = System.Drawing.Color.Green;
        }

        LoadRegisteredEvents();
    }
}
