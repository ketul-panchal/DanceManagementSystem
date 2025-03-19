<%@ Page Language="C#" AutoEventWireup="true" CodeFile="InstructorDashboard.aspx.cs" Inherits="InstructorDashboard" %>

<!DOCTYPE html>
<html>
<head>
    <title>Instructor Dashboard - Dance Management</title>
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(to right, #2E0249, #800080);
            color: white;
            margin: 0;
            padding: 0;
        }

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

        .dashboard-section {
            background: rgba(255, 255, 255, 0.1);
            padding: 20px;
            border-radius: 10px;
            margin-bottom: 20px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.3);
        }

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

    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="navbar">
            <a href="InstructorDashboard.aspx">Dashboard</a>
            <a href="MarkAttendance.aspx">Mark Attendance</a>
            <a href="Logout.aspx">Logout</a>
        </div>

        <div class="container">
            <h2>Welcome, <asp:Label ID="lblUserName" runat="server"></asp:Label></h2>

            <div class="dashboard-section">
                <h3>Upcoming Classes</h3>
                <asp:GridView ID="gvUpcomingClasses" runat="server" AutoGenerateColumns="False" EmptyDataText="No upcoming classes.">
                    <Columns>
                        <asp:BoundField DataField="ClassName" HeaderText="Class Name" />
                        <asp:BoundField DataField="DanceStyle" HeaderText="Dance Style" />
                        <asp:BoundField DataField="Schedule" HeaderText="Schedule" />
                    </Columns>
                </asp:GridView>
            </div>

            <div class="dashboard-section">
                <h3>Latest Announcements</h3>
                <asp:GridView ID="gvAnnouncements" runat="server" AutoGenerateColumns="False" EmptyDataText="No announcements.">
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
