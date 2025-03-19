<%@ Page Language="C#" AutoEventWireup="true" CodeFile="RegisterEvent.aspx.cs" Inherits="RegisterEvent" %>

<!DOCTYPE html>
<html>
<head>
    <title>Register for Events - Dance Management</title>
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

        .form-group select {
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

        .register-btn {
            background: #007bff;
            color: white;
        }

    </style>
</head>
<body>
    <form id="form1" runat="server">
        <!-- Navbar -->
        <div class="navbar">
           <a href="UserDashboard.aspx">Dashboard</a>
            <a href="RegisterEvent.aspx">Register for Events</a>
            <a href="UserProfile.aspx">My Profile</a>
            <a href="Logout.aspx">Logout</a>
        </div>

        <div class="container">
            <h2>Register for Events</h2>

            <div class="form-container">
                <div class="form-group">
                    <label>Select Event:</label>
                    <asp:DropDownList ID="ddlEvent" runat="server"></asp:DropDownList>
                </div>

                <div class="form-group">
                    <label>Role:</label>
                    <asp:TextBox ID="txtRole" runat="server"></asp:TextBox>
                </div>

                <asp:Button ID="btnRegister" runat="server" Text="Register" CssClass="btn" OnClick="btnRegister_Click" />
            </div>

            <h3>My Event Registrations</h3>
            <asp:GridView ID="gvRegisteredEvents" runat="server" AutoGenerateColumns="False" EmptyDataText="No events registered.">
                <Columns>
                    <asp:BoundField DataField="EventName" HeaderText="Event Name" />
                    <asp:BoundField DataField="EventDate" HeaderText="Date" />
                    <asp:BoundField DataField="Location" HeaderText="Location" />
                    <asp:BoundField DataField="Role" HeaderText="Role" />
                </Columns>
            </asp:GridView>
        </div>
        <asp:Label ID="lblMessage" runat="server" ForeColor="Red"></asp:Label>
    </form>
</body>
</html>
