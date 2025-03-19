<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Signup.aspx.cs" Inherits="Signup" %>

<!DOCTYPE html>
<html>
<head>
    <title>Signup - Dance Management</title>
    <style>
        /* General Styles */
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(to right, #2E0249, #800080);
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
            margin: 0;
        }

        /* Container */
        .signup-container {
            background: rgba(255, 255, 255, 0.15);
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.3);
            width: 400px;
            text-align: center;
            backdrop-filter: blur(15px);
            transition: transform 0.3s ease-in-out;
        }

        

        /* Title */
        h2 {
            font-size: 26px;
            color: #FFD700;
            margin-bottom: 15px;
        }

        /* Input Fields */
        .form-group {
            margin: 15px 0;
            text-align: left;
        }

        .form-group label {
            font-size: 14px;
            font-weight: bold;
        }

        .form-group input, .form-group select {
            width: 96%;
            padding: 12px;
            margin-top: 5px;
            border: none;
            border-radius: 6px;
            background: rgba(255, 255, 255, 0.9);
            font-size: 14px;
            outline: none;
            transition: all 0.3s ease-in-out;
        }

        .form-group input:focus, .form-group select:focus {
            background: #fff;
            box-shadow: 0px 0px 10px rgba(255, 215, 0, 0.6);
        }

        /* Signup Button */
        .signup-btn {
            width: 100%;
            padding: 12px;
            background: #FFD700;
            color: #2E0249;
            border: none;
            font-size: 16px;
            font-weight: bold;
            border-radius: 6px;
            cursor: pointer;
            transition: background 0.3s ease-in-out;
        }

        .signup-btn:hover {
            background: #E6B800;
            box-shadow: 0px 0px 10px rgba(255, 215, 0, 0.8);
        }

        /* Error Message */
        .error-message {
            color: #FF5733;
            font-size: 14px;
            margin-top: 10px;
        }

        /* Responsive */
        @media (max-width: 450px) {
            .signup-container {
                width: 90%;
            }
        }

    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="signup-container">
            <h2>Join Our Dance Family</h2>
            <div class="form-group">
                <label for="txtFullName">Full Name:</label>
                <asp:TextBox ID="txtFullName" runat="server"></asp:TextBox>
            </div>
            <div class="form-group">
                <label for="txtEmail">Email:</label>
                <asp:TextBox ID="txtEmail" runat="server"></asp:TextBox>
            </div>
            <div class="form-group">
                <label for="ddlRole">Role:</label>
                <asp:DropDownList ID="ddlRole" runat="server">
                    <asp:ListItem Text="Select Role" Value="" />
                    <asp:ListItem Text="Dancer" Value="Dancer" />
                    <asp:ListItem Text="Instructor" Value="Instructor" />
                    <asp:ListItem Text="Admin" Value="Admin" />
                </asp:DropDownList>
            </div>
            <div class="form-group">
                <label for="txtPassword">Password:</label>
                <asp:TextBox ID="txtPassword" runat="server" TextMode="Password"></asp:TextBox>
            </div>
            <div class="form-group">
                <label for="txtConfirmPassword">Confirm Password:</label>
                <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password"></asp:TextBox>
            </div>
            <asp:Button ID="btnSignup" runat="server" Text="Sign Up" CssClass="signup-btn" OnClick="btnSignup_Click" />
            <asp:Label ID="lblMessage" runat="server" CssClass="error-message"></asp:Label>
        </div>
    </form>
</body>
</html>
