<%@ Page Language="C#" AutoEventWireup="true" CodeFile="UserProfile.aspx.cs" Inherits="UserProfile" %>

<!DOCTYPE html>
<html>
<head>
    <title>User Profile - Dance Management</title>
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
            width: 50%;
            margin: auto;
            padding: 20px;
            text-align: center;
        }

        h2 {
            color: #FFD700;
            text-align: center;
            margin-bottom: 20px;
        }

        .form-container {
            background: rgba(255, 255, 255, 0.1);
            padding: 20px;
            border-radius: 10px;
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

        .form-group input {
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
            <h2>User Profile</h2>
            
            <div class="form-container">
                <div class="form-group">
                    <label>Full Name:</label>
                    <asp:TextBox ID="txtFullName" runat="server"></asp:TextBox>
                </div>

                <div class="form-group">
                    <label>Email:</label>
                    <asp:TextBox ID="txtEmail" runat="server" ReadOnly="true"></asp:TextBox>
                </div>

                <div class="form-group">
                    <label>Contact:</label>
                    <asp:TextBox ID="txtContact" runat="server"></asp:TextBox>
                </div>

                <div class="form-group">
                    <label>Address:</label>
                    <asp:TextBox ID="txtAddress" runat="server"></asp:TextBox>
                </div>

                <asp:Button ID="btnUpdate" runat="server" Text="Update Profile" CssClass="btn" OnClick="btnUpdate_Click" />
                <br /><br />
                <asp:Label ID="lblMessage" runat="server" ForeColor="Red"></asp:Label>
            </div>
        </div>
    </form>
</body>
</html>
