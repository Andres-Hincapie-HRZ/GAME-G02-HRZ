import React, { useState } from "react";
import { Redirect } from "react-router-dom";
import "./form.css";
function Signup(props) {
  const [redi, setRed] = useState(false);
  if (redi) {
    return <Redirect to="/ChangePassword" />;
  }
  return (
    <form className="p-2 test">
      <div class="form-group text-left">
        <div className="label">I FORGOT MY PASSWORD</div>
        <label
          className="mt-1 forgotPassword__subTitleText"
          htmlFor="exampleInputEmail1 "
        >
          Enter your email address
        </label>
        <input
          type="email"
          class="input forgot-input"
          id="exampleInputEmail1"
          //   placeholder="test@gmail.com"
          aria-describedby="emailHelp"
        />
        {/* <small id="emailHelp" class="form-text text-muted">
          We'll never share your email with anyone else.
        </small> */}
      </div>
      <div className="loginBox__buttonGroup">
        <div
          class=" col-md-3 mb-2 form-button text-left centered"
          onClick={() => {
            setRed(true);
            // console.log("helo");
          }}
        >
          <button
            type="submit"
            class="btn btn-primary label button-blue btn-xs"
            style={{
              fontSize: 22,
              paddingLeft: 10,
              paddingRight: 10,
              // width: "10%",
            }}
          >
            SUBMIT
          </button>
        </div>
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
    </form>
  );
}

export default Signup;
