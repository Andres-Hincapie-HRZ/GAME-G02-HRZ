import React, { useState, useRef } from "react";
import { useDispatch } from "react-redux";

import Form from "react-validation/build/form";
import Input from "react-validation/build/input";
import CheckButton from "react-validation/build/button";
import { isEmail } from "validator";
import Swal from "sweetalert2";
import HCaptcha from '@hcaptcha/react-hcaptcha';

import { register } from "../actions/auth";

const ERROR_MAPPING = {
  HCAPTCHA_ERROR: 'Oops, something went wrong with the captcha',
  HCAPTCHA_ERROR_2: 'Oops, something went wrong with the captcha',
  INVALID_CAPTCHA: 'Invalid captcha',
  OTP_INVALID: 'Invalid code',
  OTP_EXPIRED: 'Code expired',
  INTERNAL_ERROR_DURING_EMAIL_SEND: 'Oops, something went wrong during email send',
  EMAIL_TAKEN: 'Email already taken',
  USERNAME_TAKEN: 'Username already taken',
  NOT_VALID_USERNAME: 'Username not valid',
  INVALID_GROUND: 'Invalid ground',
}

const Signup = (props) => {
  const form = useRef();
  const checkBtn = useRef();
  const icon = "233";

  const [hcaptchaToken, setHcaptchaToken] = useState(null);
  const captchaRef = React.useRef(null);

  const [isOtpSent, setIsOtpSent] = useState(false);
  const [otp, setOtp] = useState("");
  const [username, setUsername] = useState("");
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [confirmpassword, setconfirmPassword] = useState("");
  const [successful, setSuccessful] = useState(false);

  const dispatch = useDispatch();

  const onChangeUsername = (e) => {
    const username = e.target.value;
    setUsername(username);
  };
  const onChangeEmail = (e) => {
    const email = e.target.value;
    setEmail(email);
  };

  const onChangePassword = (e) => {
    const password = e.target.value;
    setPassword(password);
  };

  const onChangeconfirmPassword = (e) => {
    const confirmpassword = e.target.value;
    setconfirmPassword(confirmpassword);
  };

  const handleRegister = (e) => {
    e.preventDefault();

    setSuccessful(false);

    if (email === "") {
      return Swal.fire({
        title: "Error!",
        text: "Email Required",
        icon: "error",
        confirmButtonText: "Ok",
      });
    } else if (!isEmail(email)) {
      return Swal.fire({
        title: "Error!",
        text: "This is not a valid email.",
        icon: "error",
        confirmButtonText: "Ok",
      });
    } else if (username == "") {
      return Swal.fire({
        title: "Error!",
        text: "Username Required",
        icon: "error",
        confirmButtonText: "Ok",
      });
    } else if (username.length < 3 || username.length > 20) {
      return Swal.fire({
        title: "Error!",
        text: "The username must be between 3 and 20 characters.",
        icon: "error",
        confirmButtonText: "Ok",
      });
    } else if (password === "") {
      return Swal.fire({
        title: "Error!",
        text: "Password Required",
        icon: "error",
        confirmButtonText: "Ok",
      });
    } else if (password.length < 6 || password.length > 40) {
      return Swal.fire({
        title: "Error!",
        text: "The password must be between 6 and 40 characters.",
        icon: "error",
        confirmButtonText: "Ok",
      });
    } else if (confirmpassword === "") {
      return Swal.fire({
        title: "Error!",
        text: "Confirm password Required",
        icon: "error",
        confirmButtonText: "Ok",
      });
    } else if (password != confirmpassword) {
      return Swal.fire({
        title: "Error!",
        text: "Password and Confirm Password not same.",
        icon: "error",
        confirmButtonText: "Ok",
      });
    } else if(isOtpSent && otp === "") {
      return Swal.fire({
        title: "Error!",
        text: "Please enter verification code.",
        icon: "error",
        confirmButtonText: "Ok",
      });
    }

    if (checkBtn.current.context._errors.length === 0) {
      dispatch(register(email, username, icon, password, hcaptchaToken, otp))
        .then((message) => {
          
          if (message === 'OTP_SENT'){
            setIsOtpSent(true);
            Swal.fire({
              title: "Success!",
              text: "Code sent to your email",
              icon: "success",
              confirmButtonText: "Ok",
            });
          } else {
            setIsOtpSent(false);
            setOtp('');
            setEmail('');
            setUsername('');
            setPassword('');
            setconfirmPassword('');
            captchaRef.current?.resetCaptcha()
            Swal.fire({
              title: "Success!",
              text: "Congratulations, your account has been created, now you can login!",
              icon: "success",
              confirmButtonText: "Ok",
            });
          }
        })
        .catch((error) => {

          const { message } = error; 

          if(message === 'HCAPTCHA_ERROR' || message === 'HCAPTCHA_ERROR_2' || message === 'INVALID_CAPTCHA')
            captchaRef.current?.resetCaptcha()

          if(message === 'OTP_INVALID' || message === 'OTP_EXPIRED'){
            setIsOtpSent(false);
            setOtp('');
            captchaRef.current?.resetCaptcha()
          }
            

          Swal.fire({
            title: "Error!",
            text: ERROR_MAPPING[message],
            icon: "error",
            confirmButtonText: "Ok",
          });
          // setSuccessful(false);
        });
    }
  };

  return (
    <div>
      <Form onSubmit={handleRegister} ref={form}>
        {!successful && (
          <div>
            <div className="form-group text-left">
              <label htmlFor="email" className="label">
                E-mail
              </label>
              <Input
                type="text"
                className="input login-input"
                name="email"
                value={email}
                onChange={onChangeEmail}
              />
            </div>

            <div className="form-group text-left">
              <label htmlFor="email" className="label">
                Username
              </label>
              <Input
                type="text"
                className="input login-input"
                name="username"
                value={username}
                onChange={onChangeUsername}
              />
            </div>
            <div className="form-group text-left">
              <label htmlFor="password" className="label">
                Password
              </label>
              <Input
                type="password"
                className="input login-input"
                name="password"
                value={password}
                onChange={onChangePassword}
              />
            </div>

            <div className="form-group text-left">
              <label htmlFor="password" className="label">
                Confirm Password
              </label>
              <Input
                type="password"
                className="input login-input"
                name="password"
                value={confirmpassword}
                onChange={onChangeconfirmPassword}
              />
            </div>
            {isOtpSent && (
              <div className="form-group text-left">
                <label htmlFor="password" className="label">
                  Verification code
                </label>
                <Input
                  type="text"
                  className="input login-input"
                  name="otp"
                  value={otp}
                  onChange={(e) => setOtp(e.target.value)}
                />
              </div>
            )}
            <HCaptcha
              ref={captchaRef}
              sitekey="45c5e4c1-2fcd-4a2a-b9a2-a06c5d244844"
              theme="dark"
              onExpire={() => {
                setHcaptchaToken('');
                setOtp('');
                setIsOtpSent(false);
              }}
              onVerify={(token) => setHcaptchaToken(token)}
            />
            <div className="form-group text-left loginBox__buttonGroup">
              <button className={`loginBox__button ${hcaptchaToken ? 'btn-primary' : 'btn-neutral'}`} disabled={!hcaptchaToken}>
                <span className="loginBox__buttonText">Submit</span>
              </button>
              <div
                onClick={(event) => {
                  props.setType("Login");
                  event.stopPropagation();
                }}
              >
                <h3 className="loginBox__bottomText">
                  Already have an account?
                </h3>
              </div>
              <div
                onClick={(event) => {
                  props.setType("Login");
                  event.stopPropagation();
                }}
              >
                <h3 className="loginBox__bottomText1">Login</h3>
              </div>
            </div>
          </div>
        )}
        <CheckButton style={{ display: "none" }} ref={checkBtn} />
      </Form>
    </div>
  );
};
export default Signup;
