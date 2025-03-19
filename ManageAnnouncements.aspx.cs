using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ManageAnnouncements : Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadAnnouncements();
        }
    }

    private void LoadAnnouncements()
    {
        string connString = WebConfigurationManager.ConnectionStrings["DanceDB"].ConnectionString;

        using (SqlConnection conn = new SqlConnection(connString))
        {
            conn.Open();
            SqlCommand cmd = new SqlCommand("SELECT * FROM Announcements ORDER BY DatePosted DESC", conn);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            gvAnnouncements.DataSource = dt;
            gvAnnouncements.DataBind();
        }
    }

    protected void btnAddUpdate_Click(object sender, EventArgs e)
    {
        string connString = WebConfigurationManager.ConnectionStrings["DanceDB"].ConnectionString;

        using (SqlConnection conn = new SqlConnection(connString))
        {
            conn.Open();

            if (!string.IsNullOrEmpty(hfAnnouncementID.Value))
            {
                // Update existing announcement
                SqlCommand cmd = new SqlCommand("UPDATE Announcements SET Title=@Title, Message=@Message WHERE AnnouncementID=@AnnouncementID", conn);
                cmd.Parameters.AddWithValue("@Title", txtTitle.Text);
                cmd.Parameters.AddWithValue("@Message", txtMessage.Text);
                cmd.Parameters.AddWithValue("@AnnouncementID", hfAnnouncementID.Value);
                cmd.ExecuteNonQuery();

                lblMessage.Text = "Announcement updated successfully!";
            }
            else
            {
                // Insert new announcement
                SqlCommand cmd = new SqlCommand("INSERT INTO Announcements (Title, Message, DatePosted) VALUES (@Title, @Message, GETDATE())", conn);
                cmd.Parameters.AddWithValue("@Title", txtTitle.Text);
                cmd.Parameters.AddWithValue("@Message", txtMessage.Text);
                cmd.ExecuteNonQuery();

                lblMessage.Text = "Announcement added successfully!";
            }

            lblMessage.ForeColor = System.Drawing.Color.Green;
            hfAnnouncementID.Value = ""; // Clear the hidden field
            txtTitle.Text = "";
            txtMessage.Text = "";
            LoadAnnouncements();
        }
    }

    protected void btnEdit_Click(object sender, EventArgs e)
    {
        Button btn = (Button)sender;
        int announcementID = Convert.ToInt32(btn.CommandArgument);

        string connString = WebConfigurationManager.ConnectionStrings["DanceDB"].ConnectionString;

        using (SqlConnection conn = new SqlConnection(connString))
        {
            conn.Open();
            SqlCommand cmd = new SqlCommand("SELECT * FROM Announcements WHERE AnnouncementID = @AnnouncementID", conn);
            cmd.Parameters.AddWithValue("@AnnouncementID", announcementID);
            SqlDataReader reader = cmd.ExecuteReader();

            if (reader.Read())
            {
                hfAnnouncementID.Value = reader["AnnouncementID"].ToString();
                txtTitle.Text = reader["Title"].ToString();
                txtMessage.Text = reader["Message"].ToString();
            }
        }
    }

    protected void btnDelete_Click(object sender, EventArgs e)
    {
        Button btn = (Button)sender;
        int announcementID = Convert.ToInt32(btn.CommandArgument);

        string connString = WebConfigurationManager.ConnectionStrings["DanceDB"].ConnectionString;

        using (SqlConnection conn = new SqlConnection(connString))
        {
            conn.Open();
            SqlCommand cmd = new SqlCommand("DELETE FROM Announcements WHERE AnnouncementID = @AnnouncementID", conn);
            cmd.Parameters.AddWithValue("@AnnouncementID", announcementID);
            cmd.ExecuteNonQuery();
        }

        lblMessage.Text = "Announcement deleted successfully!";
        lblMessage.ForeColor = System.Drawing.Color.Red;
        LoadAnnouncements();
    }
}
