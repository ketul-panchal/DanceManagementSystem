<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AdminDashboard.aspx.cs" Inherits="AdminDashboard" %>

<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard - Dance Management</title>
    <style>
        /* General Styles */
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(to right, #2E0249, #800080);
            color: white;
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

        /* Dashboard Container */
        .container {
            width: 90%;
            max-width: 1200px;
            margin: auto;
            padding: 20px;
        }

        h2 {
            color: #FFD700;
            text-align: center;
            margin-bottom: 20px;
        }

        /* Dashboard Stats Cards */
        .stats-container {
            display: flex;
            justify-content: space-between;
            flex-wrap: wrap;
            gap: 15px;
        }

        .stat-card {
            background: rgba(255, 255, 255, 0.15);
            padding: 20px;
            border-radius: 10px;
            text-align: center;
            flex: 1;
            min-width: 250px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.3);
            transition: transform 0.3s;
        }

        .stat-card:hover {
            transform: scale(1.05);
        }

        .stat-card h3 {
            font-size: 22px;
            color: #FFD700;
        }

        .stat-card p {
            font-size: 28px;
            font-weight: bold;
        }

        /* Tables */
        table {
            width: 100%;
            margin-top: 15px;
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

        tr:hover {
            background: rgba(255, 255, 255, 0.3);
        }

        /* Quick Actions */
        .quick-actions {
            display: flex;
            justify-content: center;
            gap: 15px;
            margin-top: 20px;
        }

        .action-btn {
            background: #FFD700;
            color: #1e3c72;
            padding: 12px 20px;
            font-size: 16px;
            font-weight: bold;
            border-radius: 6px;
            text-decoration: none;
            transition: background 0.3s ease-in-out;
        }

        .action-btn:hover {
            background: #E6B800;
            box-shadow: 0px 0px 10px rgba(255, 215, 0, 0.8);
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <!-- Navbar -->
        <div class="navbar">
            <a href="ManageUsers.aspx">Manage Users</a>
            <a href="ManageClasses.aspx">Manage Classes</a>
            <a href="ManageEnrollments.aspx">Manage Enrollments</a>
            <a href="ManageAttendance.aspx">Attendance</a> <!-- ADDED LINK -->
            <a href="ManageEvents.aspx">Manage Events</a>
            <a href="ManageAnnouncements.aspx">Manage Announcements</a>
            <a href="Logout.aspx">Logout</a>
        </div>

        <div class="container">
            <h2>Welcome, Admin</h2>

            <!-- Dashboard Stats -->
            <div class="stats-container">
                <div class="stat-card">
                    <h3>Total Users</h3>
                    <p><asp:Label ID="lblTotalUsers" runat="server"></asp:Label></p>
                </div>
                <div class="stat-card">
                    <h3>Active Classes</h3>
                    <p><asp:Label ID="lblActiveClasses" runat="server"></asp:Label></p>
                </div>
                <div class="stat-card">
                    <h3>Total Enrollments</h3>
                    <p><asp:Label ID="lblTotalEnrollments" runat="server"></asp:Label></p>
                </div>
                <div class="stat-card">
                    <h3>Upcoming Events</h3>
                    <p><asp:Label ID="lblUpcomingEvents" runat="server"></asp:Label></p>
                </div>
            </div>

            <!-- Latest Announcements -->
            <div class="card">
                <h3>Latest Announcements</h3>
                <asp:GridView ID="gvAnnouncements" runat="server" AutoGenerateColumns="False" EmptyDataText="No announcements found.">
                    <Columns>
                        <asp:BoundField DataField="DatePosted" HeaderText="Date" />
                        <asp:BoundField DataField="Title" HeaderText="Title" />
                        <asp:BoundField DataField="Message" HeaderText="Message" />
                    </Columns>
                </asp:GridView>
            </div>

            <!-- Quick Actions -->
            <div class="quick-actions">
                <a href="ManageUsers.aspx" class="action-btn">Manage Users</a>
                <a href="ManageClasses.aspx" class="action-btn">Manage Classes</a>
                <a href="ManageEvents.aspx" class="action-btn">Manage Events</a>
                <a href="ManageAnnouncements.aspx" class="action-btn">Manage Announcements</a>
                <a href="ManageAttendance.aspx" class="action-btn">Attendance</a> <!-- ADDED LINK -->
            </div>
        </div>
    </form>
</body>
</html>
