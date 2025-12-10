import React, { useState, useRef } from "react";
import { useDispatch, useSelector } from "react-redux";
import { Link, Redirect } from "react-router-dom";

import Form from "react-validation/build/form";
import Input from "react-validation/build/input";
import CheckButton from "react-validation/build/button";
// import { ToastContainer, toast } from 'react-toastify';
// import 'react-toastify/dist/ReactToastify.css';
import Swal from "sweetalert2";

import { login } from "../actions/auth";

import "./form.css";

const Login = (props) => {
  const form = useRef();
  const checkBtn = useRef();

  const [username, setUsername] = useState("");
  const [password, setPassword] = useState("");
  const [loading, setLoading] = useState(false);

  const { isLoggedIn } = useSelector((state) => state.auth);
  const { message } = useSelector((state) => state.message);

  const dispatch = useDispatch();

  const onChangeUsername = (e) => {
    const username = e.target.value;
    setUsername(username);
  };

  const onChangePassword = (e) => {
    const password = e.target.value;
    setPassword(password);
  };

  const handleLogin = (e) => {
    e.preventDefault();
    setLoading(true);

    if (username === "") {
      setLoading(false);
      return Swal.fire({
        title: "Error!",
        text: "Username Required",
        icon: "error",
        confirmButtonText: "Ok",
      });
    } else if (password == "") {
      setLoading(false);
      return Swal.fire({
        title: "Error!",
        text: "Password Required",
        icon: "error",
        confirmButtonText: "Ok",
      });
    }

    if (checkBtn.current.context._errors.length === 0) {
      dispatch(login(username, password))
        .then(() => {
          // props.history.push("/profile");
          Swal.fire({
            title: "Success!",
            text: "User logged in.",
            icon: "success",
            confirmButtonText: "Ok",
          });
          setTimeout(() => {
            window.location.reload();
          }, 2000);
        })
        .catch((error) => {
          setLoading(false);
          return Swal.fire({
            title: "Error!",
            text: "Invalid Credentials",
            icon: "error",
            confirmButtonText: "Ok",
          });
        });
    } else {
      setLoading(false);
    }
  };

  return (
    <div>
      <Form onSubmit={handleLogin} ref={form} className="test">
        <div className="form-group text-left inputfield">
          <label htmlFor="username" className="label">
            Username / E-Mail
          </label>
          <Input
            type="text"
            className="input login-input"
            name="username"
            value={username}
            onChange={onChangeUsername}
          />
        </div>

        <div className="form-group text-left  inputfield">
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

        <div className="form-group text-left loginBox__buttonGroup">
          <button className="loginBox__button btn-primary" disabled={loading}>
            {loading && (
              <span className="spinner-border spinner-border-sm"></span>
            )}
            <span className="loginBox__buttonText">Enter</span>
          </button>
          <div
            onClick={(event) => {
              props.setType("Signup");
              event.stopPropagation();
            }}
          >
            <h3 className="loginBox__bottomText">Don't have an account yet?</h3>
          </div>
          <div
            onClick={(event) => {
              props.setType("Signup");
              event.stopPropagation();
            }}
          >
            <h3 className="loginBox__bottomText1">Sign Up</h3>
          </div>
        </div>

        <div
          className="loginBox__bottomText1"
          onClick={(event) => {
            props.setType("Forget");
            event.stopPropagation();
          }}
        >
          Forgot your password?
        </div>

        <CheckButton style={{ display: "none" }} ref={checkBtn} />
      </Form>
    </div>
  );
};

export default Login;
