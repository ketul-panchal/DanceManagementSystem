<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Login" %>

<!DOCTYPE html>
<html>
<head>
    <title>Login - Dance Management</title>
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

        /* Login Container */
        .login-container {
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

        .form-group input {
            width: 94%;
            padding: 12px;
            margin-top: 5px;
            border: none;
            border-radius: 6px;
            background: rgba(255, 255, 255, 0.9);
            font-size: 14px;
            outline: none;
            transition: all 0.3s ease-in-out;
        }

        .form-group input:focus {
            background: #fff;
            box-shadow: 0px 0px 10px rgba(255, 215, 0, 0.6);
        }

        /* Login Button */
        .login-btn {
            width: 100%;
            padding: 12px;
            background: #FFD700;
            color: #D4145A;
            border: none;
            font-size: 16px;
            font-weight: bold;
            border-radius: 6px;
            cursor: pointer;
            transition: background 0.3s ease-in-out;
        }

        .login-btn:hover {
            background: #E6B800;
            box-shadow: 0px 0px 10px rgba(255, 215, 0, 0.8);
        }

        /* Error Message */
        .error-message {
            color: #FF5733;
            font-size: 14px;
            margin-top: 10px;
        }

        /* Sign-up Link */
        .signup-link {
            margin-top: 15px;
            font-size: 14px;
        }

        .signup-link a {
            color: #FFD700;
            text-decoration: none;
            font-weight: bold;
            transition: color 0.3s ease-in-out;
        }

        .signup-link a:hover {
            color: #fff;
        }

        /* Responsive */
        @media (max-width: 450px) {
            .login-container {
                width: 90%;
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="login-container">
            <h2>Dance Management Login</h2>
            <div class="form-group">
                <label for="txtEmail">Email:</label>
                <asp:TextBox ID="txtEmail" runat="server"></asp:TextBox>
            </div>
            <div class="form-group">
                <label for="txtPassword">Password:</label>
                <asp:TextBox ID="txtPassword" runat="server" TextMode="Password"></asp:TextBox>
            </div>
            <asp:Button ID="btnLogin" runat="server" Text="Login" CssClass="login-btn" OnClick="btnLogin_Click" />
            <asp:Label ID="lblMessage" runat="server" CssClass="error-message"></asp:Label>

            <div class="signup-link">
                Don't have an account? <a href="Signup.aspx">Sign up</a>
            </div>
        </div>
    </form>
</body>
</html>
