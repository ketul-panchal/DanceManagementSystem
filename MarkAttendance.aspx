<%@ Page Language="C#" AutoEventWireup="true" CodeFile="MarkAttendance.aspx.cs" Inherits="MarkAttendance" %>

<!DOCTYPE html>
<html>
<head>
    <title>Mark Attendance - Dance Management</title>
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

        .form-container {
            background: rgba(255, 255, 255, 0.1);
            padding: 20px;
            border-radius: 10px;
            margin-bottom: 20px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.3);
            text-align: center;
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
        <div class="navbar">
            <a href="InstructorDashboard.aspx">Dashboard</a>
            <a href="MarkAttendance.aspx">Mark Attendance</a>
            <a href="Logout.aspx">Logout</a>
        </div>

        <div class="container">
            <h2>Mark Attendance</h2>

            <div class="form-container">
                <div class="form-group">
                    <label>Select Class:</label>
                    <asp:DropDownList ID="ddlClass" runat="server"></asp:DropDownList>
                </div>

                <asp:Button ID="btnLoadDancers" runat="server" Text="Load Dancers" CssClass="btn" OnClick="btnLoadDancers_Click" />
            </div>

            <asp:Label ID="lblMessage" runat="server" ForeColor="Red"></asp:Label>

            <asp:GridView ID="gvAttendance" runat="server" AutoGenerateColumns="False" EmptyDataText="No dancers found."
                DataKeyNames="UserID">
                <Columns>
                    <asp:BoundField DataField="UserID" HeaderText="Dancer ID" />
                    <asp:BoundField DataField="FullName" HeaderText="Dancer Name" />
                    <asp:TemplateField HeaderText="Status">
                        <ItemTemplate>
                            <asp:DropDownList ID="ddlStatus" runat="server">
                                <asp:ListItem Text="Present" Value="Present"></asp:ListItem>
                                <asp:ListItem Text="Absent" Value="Absent"></asp:ListItem>
                            </asp:DropDownList>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>

            <asp:Button ID="btnMarkAttendance" runat="server" Text="Mark Attendance" CssClass="btn" OnClick="btnMarkAttendance_Click" />
        </div>
    </form>
</body>
</html>
