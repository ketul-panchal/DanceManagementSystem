<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ManageAttendance.aspx.cs" Inherits="ManageAttendance" %>

<!DOCTYPE html>
<html>
<head>
    <title>Manage Attendance - Dance Management</title>
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

        .form-group input, .form-group select {
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

        tr:hover {
            background: rgba(255, 255, 255, 0.3);
        }

        .present-btn {
            background: #28a745;
            color: white;
        }

        .absent-btn {
            background: #dc3545;
            color: white;
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
            <h2>Manage Attendance</h2>

            <!-- Attendance Form -->
            <div class="form-container">
                <div class="form-group">
                    <label>Select Class:</label>
                    <asp:DropDownList ID="ddlClass" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlClass_SelectedIndexChanged"></asp:DropDownList>
                </div>

                <div class="form-group">
                    <label>Select Date:</label>
                    <asp:TextBox ID="txtDate" runat="server" TextMode="Date"></asp:TextBox>
                </div>

                <asp:Button ID="btnLoadDancers" runat="server" Text="Load Dancers" CssClass="btn" OnClick="btnLoadDancers_Click" />
            </div>

            <asp:Label ID="lblMessage" runat="server" ForeColor="Red"></asp:Label>

            <!-- Attendance Table -->
            <asp:GridView ID="gvAttendance" runat="server" AutoGenerateColumns="False" EmptyDataText="No dancers found." DataKeyNames="UserID">
                <Columns>
                    <asp:BoundField DataField="UserID" HeaderText="ID" />
                    <asp:BoundField DataField="FullName" HeaderText="Dancer Name" />
                    <asp:TemplateField HeaderText="Status">
                        <ItemTemplate>
                            <asp:Button ID="btnPresent" runat="server" Text="Present" CssClass="btn present-btn"
                                CommandArgument='<%# Eval("UserID") %>' OnClick="btnPresent_Click" />
                            <asp:Button ID="btnAbsent" runat="server" Text="Absent" CssClass="btn absent-btn"
                                CommandArgument='<%# Eval("UserID") %>' OnClick="btnAbsent_Click" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
    </form>
</body>
</html>
