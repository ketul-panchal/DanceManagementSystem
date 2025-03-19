<%@ Page Language="C#" AutoEventWireup="true" CodeFile="UserDashboard.aspx.cs" Inherits="UserDashboard" %>

<!DOCTYPE html>
<html>
<head>
    <title>User Dashboard - Dance Management</title>
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

        /* Dashboard Sections */
        .dashboard-section {
            background: rgba(255, 255, 255, 0.1);
            padding: 20px;
            border-radius: 10px;
            margin-bottom: 20px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.3);
        }

        /* Table */
        table {
            width: 100%;
            margin-top: 10px;
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
        
        /* Attendance Summary */
        .attendance-summary {
            display: flex;
            justify-content: space-around;
            margin-top: 15px;
        }

        .attendance-summary div {
            background: rgba(255, 255, 255, 0.2);
            padding: 15px;
            border-radius: 10px;
            width: 40%;
            font-size: 18px;
            font-weight: bold;
        }

        .present {
            color: #4CAF50;
        }

        .absent {
            color: #FF5733;
        }

    </style>
</head>
<body>
    <form id="form1" runat="server">
        <!-- Navbar -->
        <div class="navbar">
            <a href="UserDashboard.aspx">Dashboard</a>
            <a href="RegisterEvent.aspx">Events</a>
            <a href="UserProfile.aspx">Profile</a>
            <a href="Logout.aspx">Logout</a>
        </div>

        <div class="container">
            <h2>Welcome, <asp:Label ID="lblUserName" runat="server"></asp:Label></h2>

            <!-- Upcoming Classes -->
            <div class="dashboard-section">
                <h3>Upcoming Classes</h3>
                <asp:GridView ID="gvUpcomingClasses" runat="server" AutoGenerateColumns="False" EmptyDataText="No upcoming classes found.">
                    <Columns>
                        <asp:BoundField DataField="ClassName" HeaderText="Class Name" />
                        <asp:BoundField DataField="DanceStyle" HeaderText="Dance Style" />
                        <asp:BoundField DataField="Schedule" HeaderText="Schedule" />
                        <asp:BoundField DataField="Instructor" HeaderText="Instructor" />
                    </Columns>
                </asp:GridView>
            </div>

            <!-- Attendance Summary -->
            <div class="dashboard-section">
                <h3>Attendance Summary</h3>
                <div class="attendance-summary">
                    <div class="present">Days Present: <asp:Label ID="lblDaysPresent" runat="server"></asp:Label></div>
                    <div class="absent">Days Absent: <asp:Label ID="lblDaysAbsent" runat="server"></asp:Label></div>
                </div>
            </div>

            <!-- Registered Events -->
            <div class="dashboard-section">
                <h3>Registered Events</h3>
                <asp:GridView ID="gvRegisteredEvents" runat="server" AutoGenerateColumns="False" EmptyDataText="No registered events found.">
                    <Columns>
                        <asp:BoundField DataField="EventName" HeaderText="Event Name" />
                        <asp:BoundField DataField="EventDate" HeaderText="Date" />
                        <asp:BoundField DataField="Location" HeaderText="Location" />
                    </Columns>
                </asp:GridView>
            </div>

            <!-- Announcements -->
            <div class="dashboard-section">
                <h3>Latest Announcements</h3>
                <asp:GridView ID="gvAnnouncements" runat="server" AutoGenerateColumns="False" EmptyDataText="No announcements found.">
                    <Columns>
                        <asp:BoundField DataField="DatePosted" HeaderText="Date" />
                        <asp:BoundField DataField="Title" HeaderText="Title" />
                        <asp:BoundField DataField="Message" HeaderText="Message" />
                    </Columns>
                </asp:GridView>
            </div>

        </div>
    </form>
</body>
</html>
