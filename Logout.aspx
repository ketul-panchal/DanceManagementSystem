<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Logout.aspx.cs" Inherits="Logout" %>

<!DOCTYPE html>
<html>
<head>
    <title>Logout - NCC Management</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(to right, #1e3c72, #2a5298);
            color: white;
            text-align: center;
            padding: 20px;
        }
        .message {
            background: rgba(255, 255, 255, 0.2);
            padding: 20px;
            border-radius: 10px;
            margin-top: 50px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.3);
        }
    </style>
</head>
<body>
    <div class="message">
        <h2>You have been logged out successfully.</h2>
        <p><a href="Login.aspx" style="color: #FFD700; text-decoration: none;">Click here to log in again</a></p>
    </div>
</body>
</html>
