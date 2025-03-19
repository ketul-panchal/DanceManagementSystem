using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ManageEvents : Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadEvents();
        }
    }

    private void LoadEvents()
    {
        string connString = WebConfigurationManager.ConnectionStrings["DanceDB"].ConnectionString;
        using (SqlConnection conn = new SqlConnection(connString))
        {
            conn.Open();
            SqlCommand cmd = new SqlCommand("SELECT EventID, EventName, EventDate, Location, Description FROM Events", conn);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            gvEvents.DataSource = dt;
            gvEvents.DataBind();
        }
    }

    protected void btnAddUpdate_Click(object sender, EventArgs e)
    {
        string connString = WebConfigurationManager.ConnectionStrings["DanceDB"].ConnectionString;
        using (SqlConnection conn = new SqlConnection(connString))
        {
            conn.Open();
            SqlCommand cmd;

            if (string.IsNullOrEmpty(hfEventID.Value)) // Add Event
            {
                cmd = new SqlCommand("INSERT INTO Events (EventName, EventDate, Location, Description) VALUES (@EventName, @EventDate, @Location, @Description)", conn);
            }
            else // Update Event
            {
                cmd = new SqlCommand("UPDATE Events SET EventName=@EventName, EventDate=@EventDate, Location=@Location, Description=@Description WHERE EventID=@EventID", conn);
                cmd.Parameters.AddWithValue("@EventID", hfEventID.Value);
            }

            cmd.Parameters.AddWithValue("@EventName", txtEventName.Text);
            cmd.Parameters.AddWithValue("@EventDate", txtEventDate.Text);
            cmd.Parameters.AddWithValue("@Location", txtLocation.Text);
            cmd.Parameters.AddWithValue("@Description", txtDescription.Text);

            cmd.ExecuteNonQuery();
            lblMessage.Text = "Event saved successfully!";
            lblMessage.ForeColor = System.Drawing.Color.Green;

            ResetForm();
            LoadEvents();
        }
    }

    protected void btnEdit_Click(object sender, EventArgs e)
    {
        Button btn = (Button)sender;
        int eventID = Convert.ToInt32(btn.CommandArgument);

        string connString = WebConfigurationManager.ConnectionStrings["DanceDB"].ConnectionString;
        using (SqlConnection conn = new SqlConnection(connString))
        {
            conn.Open();
            SqlCommand cmd = new SqlCommand("SELECT * FROM Events WHERE EventID = @EventID", conn);
            cmd.Parameters.AddWithValue("@EventID", eventID);
            SqlDataReader reader = cmd.ExecuteReader();

            if (reader.Read())
            {
                hfEventID.Value = reader["EventID"].ToString();
                txtEventName.Text = reader["EventName"].ToString();
                txtEventDate.Text = Convert.ToDateTime(reader["EventDate"]).ToString("yyyy-MM-dd");
                txtLocation.Text = reader["Location"].ToString();
                txtDescription.Text = reader["Description"].ToString();
            }
        }
    }

    protected void btnDelete_Click(object sender, EventArgs e)
    {
        Button btn = (Button)sender;
        int eventID = Convert.ToInt32(btn.CommandArgument);

        string connString = WebConfigurationManager.ConnectionStrings["DanceDB"].ConnectionString;
        using (SqlConnection conn = new SqlConnection(connString))
        {
            conn.Open();
            SqlCommand cmd = new SqlCommand("DELETE FROM Events WHERE EventID = @EventID", conn);
            cmd.Parameters.AddWithValue("@EventID", eventID);
            cmd.ExecuteNonQuery();
        }

        lblMessage.Text = "Event deleted successfully!";
        lblMessage.ForeColor = System.Drawing.Color.Red;
        LoadEvents();
    }

    private void ResetForm()
    {
        hfEventID.Value = "";
        txtEventName.Text = "";
        txtEventDate.Text = "";
        txtLocation.Text = "";
        txtDescription.Text = "";
    }
}
