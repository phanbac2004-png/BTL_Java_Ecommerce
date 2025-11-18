<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<!------ Include the above in your HEAD tag ---------->

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU" crossorigin="anonymous">
        <title>Login Form</title>

        <!-- ? Font & Th? vi?n -->
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

        <!-- ? Giao di?n pastel t�m-h?ng-xanh -->
        <style>
            * {
                box-sizing: border-box;
            }

            body {
                font-family: 'Poppins', sans-serif;
                background: linear-gradient(90deg, #f9d1d7, #e0c3fc, #c2e9fb);
                background-size: 200% 200%;
                animation: gradientMove 8s ease infinite;
                height: 100vh;
                margin: 0;
                display: flex;
                align-items: center;
                justify-content: center;
            }

            @keyframes gradientMove {
                0% { background-position: 0% 50%; }
                50% { background-position: 100% 50%; }
                100% { background-position: 0% 50%; }
            }

            #logreg-forms {
                background: white;
                border-radius: 25px;
                box-shadow: 0px 10px 25px rgba(0,0,0,0.15);
                width: 400px;
                padding: 40px 35px;
                transition: 0.4s;
            }

            #logreg-forms h1 {
                color: #9b59b6;
                font-weight: 600;
                margin-bottom: 25px;
                text-align: center;
            }

            .form-control {
                border-radius: 30px;
                margin-bottom: 15px;
                border: 1px solid #ddd;
                padding: 10px 20px;
                font-size: 15px;
            }

            .form-check-label {
                font-size: 14px;
            }

            .btn {
                border-radius: 30px;
                transition: all 0.3s ease;
                font-weight: 500;
                padding: 10px 20px;
            }

            .btn-success {
                background-color: #a366d1;
                border-color: #a366d1;
                color: white;
            }

            .btn-success:hover {
                background-color: #9248bf;
                border-color: #9248bf;
            }

            .btn-primary {
                background-color: #f06292;
                border-color: #f06292;
                color: white;
            }

            .btn-primary:hover {
                background-color: #e34d84;
                border-color: #e34d84;
            }

            a {
                color: #9b59b6;
                text-decoration: none;
            }

            a:hover {
                text-decoration: underline;
            }

            .alert {
                border-radius: 15px;
                text-align: center;
                font-size: 14px;
            }

            hr {
                margin: 25px 0;
            }

            .position-relative {
                position: relative;
            }

            .position-absolute {
                position: absolute;
                right: 15px;
                top: 50%;
                transform: translateY(-50%);
                cursor: pointer;
                color: #666;
            }

            .form-group.form-check {
                margin-bottom: 15px;
            }
        </style>
    </head>
    <body>
        <div id="logreg-forms">
            <form class="form-signin" action="login" method="post">
                <h1 class="h3 mb-3 font-weight-normal" style="text-align: center"> Sign in</h1>
                <c:if test="${not empty mess}">
                    <div class="alert alert-danger" role="alert">
                    ${mess}
                </div>
                </c:if>
                <c:if test="${not empty thongbao}">
                    <div class="alert alert-danger" role="alert">
                    ${thongbao}
                </div>
                </c:if>
                <input name="user"  type="text" id="inputEmail" class="form-control" placeholder="Username" required="" autofocus="">
                <div class="position-relative">
                    <input name="pass"  type="password" id="inputPassword" class="form-control" placeholder="Password" required="">
                    <i class="fas fa-eye position-absolute" id="togglePassword" style="cursor: pointer; color: #666;"></i>
                </div>

                <div class="form-group form-check">
                    <input name="remember" value="1" type="checkbox" class="form-check-input" id="exampleCheck1">
                    <label class="form-check-label" for="exampleCheck1">Remember me</label>
                </div>

                <button class="btn btn-success btn-block" type="submit"><i class="fas fa-sign-in-alt"></i> Sign in</button>
                <hr>
                <a href="#" id="forgot_pswd" class="d-block text-center mb-3" style="color: #9b59b6; text-decoration: none;"><i class="fas fa-key"></i> Quên mật khẩu?</a>
                <button class="btn btn-primary btn-block" type="button" id="btn-signup"><i class="fas fa-user-plus"></i> Sign up New Account</button>
            </form>

            <form action="forgotpassword" method="post" class="form-reset" id="forgotPasswordForm" style="display: none;">
                <h1 class="h3 mb-3 font-weight-normal" style="text-align: center"> Quên mật khẩu</h1>
                <c:if test="${not empty forgotMess}">
                    <div class="alert alert-${forgotMessType != null ? forgotMessType : 'info'}" role="alert">
                        ${forgotMess}
                    </div>
                </c:if>
                <input name="username" type="text" id="forgot-username" class="form-control" placeholder="Tên đăng nhập" required="" autofocus="">
                <input name="email" type="email" id="forgot-email" class="form-control" placeholder="Email đăng ký" required="">
                
                <button class="btn btn-success btn-block" type="submit"><i class="fas fa-paper-plane"></i> Gửi mật khẩu mới</button>
                <a href="#" id="cancel_reset" class="d-block text-center mt-3"><i class="fas fa-angle-left"></i> Quay lại đăng nhập</a>
            </form>

            <form action="signup" method="post" class="form-signup" id="signupForm" style="display: none;">
                <h1 class="h3 mb-3 font-weight-normal" style="text-align: center"> Sign up</h1>
                <input name="user" type="text" id="user-name" class="form-control" placeholder="User name" required="" autofocus="">
                <input name="phone" type="tel" id="user-phone" class="form-control" placeholder="Phone number (e.g., 0123456789)" pattern="[0-9]{10,11}" required>
                <input name="email" type="email" id="user-email" class="form-control" placeholder="Email (e.g., example@gmail.com)" required>
                <div class="position-relative">
                    <input name="pass" type="password" id="user-pass" class="form-control" placeholder="Password" required autofocus="">
                    <i class="fas fa-eye position-absolute" id="togglePasswordSignup" style="cursor: pointer; color: #666;"></i>
                </div>
                <div class="position-relative">
                    <input name="repass" type="password" id="user-repeatpass" class="form-control" placeholder="Repeat Password" required autofocus="">
                    <i class="fas fa-eye position-absolute" id="toggleRepeatPassword" style="cursor: pointer; color: #666;"></i>
                </div>
                
                <div class="form-group form-check mt-2 mb-2">
                    <input name="agreeTerms" type="checkbox" class="form-check-input" id="agreeTerms" required>
                    <label class="form-check-label" for="agreeTerms" style="font-size: 0.9em;">
                        I agree with the <a href="#" target="_blank">terms and conditions</a>
                    </label>
                </div>

                <button class="btn btn-primary btn-block" type="submit" id="signupBtn"><i class="fas fa-user-plus"></i> Sign Up</button>
                <a href="#" id="cancel_signup" class="d-block text-center mt-3"><i class="fas fa-angle-left"></i> Back</a>
            </form>
            <br>

        </div>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
        <script>
            function toggleResetPswd(e) {
                e.preventDefault();
                $('#logreg-forms .form-signin').toggle(); // display:block or none
                $('#logreg-forms .form-reset').toggle(); // display:block or none
                // Clear form when switching
                if ($('#logreg-forms .form-reset').is(':visible')) {
                    $('#forgotPasswordForm')[0].reset();
                    $('.alert').remove();
                }
            }

            function toggleSignUp(e) {
                e.preventDefault();
                $('#logreg-forms .form-signin').toggle(); // display:block or none
                $('#logreg-forms .form-signup').toggle(); // display:block or none
            }

            $(() => {
                // Login Register Form
                $('#logreg-forms #forgot_pswd').click(toggleResetPswd);
                $('#logreg-forms #cancel_reset').click(toggleResetPswd);
                $('#logreg-forms #btn-signup').click(toggleSignUp);
                $('#logreg-forms #cancel_signup').click(toggleSignUp);
                
                // Toggle password visibility for Login
                $('#togglePassword').click(function() {
                    const passwordInput = $('#inputPassword');
                    const icon = $(this);
                    if (passwordInput.attr('type') === 'password') {
                        passwordInput.attr('type', 'text');
                        icon.removeClass('fa-eye').addClass('fa-eye-slash');
                    } else {
                        passwordInput.attr('type', 'password');
                        icon.removeClass('fa-eye-slash').addClass('fa-eye');
                    }
                });
                
                // Toggle password visibility for Signup Password
                $('#togglePasswordSignup').click(function() {
                    const passwordInput = $('#user-pass');
                    const icon = $(this);
                    if (passwordInput.attr('type') === 'password') {
                        passwordInput.attr('type', 'text');
                        icon.removeClass('fa-eye').addClass('fa-eye-slash');
                    } else {
                        passwordInput.attr('type', 'password');
                        icon.removeClass('fa-eye-slash').addClass('fa-eye');
                    }
                });
                
                // Toggle password visibility for Signup Repeat Password
                $('#toggleRepeatPassword').click(function() {
                    const passwordInput = $('#user-repeatpass');
                    const icon = $(this);
                    if (passwordInput.attr('type') === 'password') {
                        passwordInput.attr('type', 'text');
                        icon.removeClass('fa-eye').addClass('fa-eye-slash');
                    } else {
                        passwordInput.attr('type', 'password');
                        icon.removeClass('fa-eye-slash').addClass('fa-eye');
                    }
                });
            })
        </script>
    </body>
</html>