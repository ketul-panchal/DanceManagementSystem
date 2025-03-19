<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ManageAnnouncements.aspx.cs" Inherits="ManageAnnouncements" %>

<!DOCTYPE html>
<html>
<head>
    <title>Manage Announcements - Dance Management</title>
    <style>
        /* General Styles */
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(to right, #2E0249, #800080);
            color: white;
            text-align: center;
            margin: 0;
            padding: 0;
        }

        /* Navbar */
        .navbar {
            background: #2E0249;
            padding: 15px;
            text-align: center;
            font-size: 18px;
            border-bottom: 2px solid #FFD700;
        }

        .navbar a {
            color: white;
            text-decoration: none;
            margin: 0 15px;
            font-weight: bold;
            padding: 10px 15px;
            transition: 0.3s;
            border-radius: 5px;
            display: inline-block;
        }

        .navbar a:hover {
            background: #FFD700;
            color: #1e3c72;
        }

        .container {
            width: 80%;
            margin: auto;
            padding: 20px;
        }

        h2 {
            color: #FFD700;
            text-align: center;
            margin-bottom: 20px;
        }

        /* Form Styles */
        .form-container {
            background: rgba(255, 255, 255, 0.1);
            padding: 20px;
            border-radius: 10px;
            margin-bottom: 20px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.3);
        }

        .form-group {
            margin-bottom: 15px;
            text-align: left;
        }

        .form-group label {
            font-weight: bold;
            display: block;
            margin-bottom: 5px;
        }

        .form-group input, .form-group textarea {
            width: 98%;
            padding: 10px;
            border-radius: 5px;
            border: none;
            background: rgba(255, 255, 255, 0.9);
        }

        .btn {
            background: #FFD700;
            color: #1e3c72;
            font-weight: bold;
            padding: 10px 15px;
            border-radius: 5px;
            border: none;
            cursor: pointer;
            transition: background 0.3s;
        }

        .btn:hover {
            background: #E6B800;
        }

        /* Table */
        table {
            width: 100%;
            margin-top: 20px;
            border-collapse: collapse;
            background: rgba(255, 255, 255, 0.2);
            border-radius: 8px;
            overflow: hidden;
        }

        th, td {
            padding: 12px;
            text-align: center;
            border-bottom: 1px solid #ddd;
            color: white;
        }

        th {
            background: rgba(255, 255, 255, 0.3);
            color: #FFD700;
        }

        .edit-btn {
            background: #007bff;
            color: white;
            padding: 5px 10px;
            border-radius: 5px;
            border: none;
            cursor: pointer;
        }

        .delete-btn {
            background: #dc3545;
            color: white;
            padding: 5px 10px;
            border-radius: 5px;
            border: none;
            cursor: pointer;
        }

        .edit-btn:hover {
            background: #0056b3;
        }

        .delete-btn:hover {
            background: #a71d2a;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <!-- Navbar -->
        <div class="navbar">
            <a href="AdminDashboard.aspx">Dashboard</a>
            <a href="ManageUsers.aspx">Manage Users</a>
            <a href="ManageClasses.aspx">Manage Classes</a>
            <a href="ManageEnrollments.aspx">Manage Enrollments</a>
            <a href="ManageAttendance.aspx">Manage Attendance</a>
            <a href="ManageEvents.aspx">Manage Events</a>
            <a href="Logout.aspx">Logout</a>
        </div>

        <div class="container">
            <h2>Manage Announcements</h2>

            <!-- Announcement Form -->
            <div class="form-container">
                <asp:HiddenField ID="hfAnnouncementID" runat="server" />

                <div class="form-group">
                    <label>Title:</label>
                    <asp:TextBox ID="txtTitle" runat="server"></asp:TextBox>
                </div>

                <div class="form-group">
                    <label>Message:</label>
                    <asp:TextBox ID="txtMessage" runat="server" TextMode="MultiLine"></asp:TextBox>
                </div>

                <asp:Button ID="btnAddUpdate" runat="server" Text="Add/Update Announcement" CssClass="btn" OnClick="btnAddUpdate_Click" />
            </div>

            <asp:Label ID="lblMessage" runat="server" ForeColor="Red"></asp:Label>

            <!-- Announcements Table -->
            <asp:GridView ID="gvAnnouncements" runat="server" AutoGenerateColumns="False" EmptyDataText="No announcements found." ShowHeaderWhenEmpty="true">
                <Columns>
                    <asp:BoundField DataField="AnnouncementID" HeaderText="ID" />
                    <asp:BoundField DataField="Title" HeaderText="Title" />
                    <asp:BoundField DataField="Message" HeaderText="Message" />
                    <asp:BoundField DataField="DatePosted" HeaderText="Posted Date" DataFormatString="{0:yyyy-MM-dd}" />
                    <asp:TemplateField HeaderText="Actions">
                        <ItemTemplate>
                            <asp:Button ID="btnEdit" runat="server" Text="Edit" CssClass="edit-btn"
                                CommandArgument='<%# Eval("AnnouncementID") %>' OnClick="btnEdit_Click" />
                            <asp:Button ID="btnDelete" runat="server" Text="Delete" CssClass="delete-btn"
                                CommandArgument='<%# Eval("AnnouncementID") %>' OnClick="btnDelete_Click" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
    </form>
</body>
</html>
