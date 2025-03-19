<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ManageClasses.aspx.cs" Inherits="ManageClasses" %>

<!DOCTYPE html>
<html>
<head>
    <title>Manage Classes - Dance Management</title>
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

        .edit-btn {
            background: #007bff;
            color: white;
        }

        .delete-btn {
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
            <a href="ManageEvents.aspx">Manage Events</a>
            <a href="ManageAnnouncements.aspx">Manage Announcements</a>
            <a href="Logout.aspx">Logout</a>
        </div>

        <div class="container">
            <h2>Manage Dance Classes</h2>

            <!-- Class Form -->
            <div class="form-container">
                <div class="form-group">
                    <label>Class Name:</label>
                    <asp:TextBox ID="txtClassName" runat="server"></asp:TextBox>
                </div>

                <div class="form-group">
                    <label>Dance Style:</label>
                    <asp:TextBox ID="txtDanceStyle" runat="server"></asp:TextBox>
                </div>

                <div class="form-group">
                    <label>Instructor:</label>
                    <asp:DropDownList ID="ddlInstructor" runat="server"></asp:DropDownList>
                </div>

                <div class="form-group">
                    <label>Schedule:</label>
                    <asp:TextBox ID="txtSchedule" runat="server"></asp:TextBox>
                </div>

                <div class="form-group">
                    <label>Max Capacity:</label>
                    <asp:TextBox ID="txtMaxCapacity" runat="server"></asp:TextBox>
                </div>

                <asp:Button ID="btnAddUpdate" runat="server" Text="Add/Update Class" CssClass="btn" OnClick="btnAddUpdate_Click" />
            </div>

            <asp:Label ID="lblMessage" runat="server" ForeColor="Red"></asp:Label>

            <!-- Classes Table -->
            <h3>Available Dance Classes</h3>
            <asp:GridView ID="gvClasses" runat="server" AutoGenerateColumns="False" EmptyDataText="No classes found."
                ShowHeaderWhenEmpty="true">
                <Columns>
                    <asp:BoundField DataField="ClassID" HeaderText="ID" />
                    <asp:BoundField DataField="ClassName" HeaderText="Class Name" />
                    <asp:BoundField DataField="DanceStyle" HeaderText="Dance Style" />
                    <asp:BoundField DataField="InstructorName" HeaderText="Instructor" />
                    <asp:BoundField DataField="Schedule" HeaderText="Schedule" />
                    <asp:BoundField DataField="MaxCapacity" HeaderText="Max Capacity" />
                    <asp:TemplateField HeaderText="Actions">
                        <ItemTemplate>
                            <asp:Button ID="btnEdit" runat="server" Text="Edit" CssClass="btn edit-btn"
                                CommandArgument='<%# Eval("ClassID") %>' OnClick="btnEdit_Click" />
                            <asp:Button ID="btnDelete" runat="server" Text="Delete" CssClass="btn delete-btn"
                                CommandArgument='<%# Eval("ClassID") %>' OnClick="btnDelete_Click" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
    </form>
</body>
</html>
