import "./changePassword.css";
import logo from "../../img/logo.webp";
import translate from "../../img/translate.png";
import { Redirect } from "react-router-dom";
import React, { useState } from "react";

function ChangePassword(props) {
  const [isSubmitted, setIsSubmitted] = useState(false);
  const [language, setLanguage] = useState("English");
  const [showTranslation, setShowTranlation] = useState(false);
  const [redi, setRed] = useState(false);
  if (redi) {
    return <Redirect to="/" />;
  }
  return (
    <div style={{ width: "auto" }}>
      <div className="float-right mt-5 col-2">
        <div
          className="translationLOGO"
          style={{
            marginRight: 40,
          }}
          onClick={() => {
            setShowTranlation(!showTranslation);
            // console.log("props", props);
          }}
        >
          <img
            style={{
              marginTop: 10,
            }}
            height="30"
            width="30"
            src={translate}
            alt="logo"
          />
        </div>
        {showTranslation ? (
          <div>
            <ul className="list-group bg-black text-center">
              <li
                className={
                  language === "English"
                    ? "list-group-item languageListActive"
                    : "list-group-item languageList"
                }
                onClick={() => {
                  setLanguage("English");
                  setShowTranlation(false);
                }}
                style={{
                  fontFamily: "Exo",
                }}
              >
                ENGLISH{" "}
              </li>
              <li
                className={
                  language === "Spanish"
                    ? "list-group-item languageListActive"
                    : "list-group-item languageList"
                }
                onClick={() => {
                  setLanguage("Spanish");
                  setShowTranlation(false);
                }}
                style={{
                  fontFamily: "Exo",
                }}
              >
                SPANISH{" "}
              </li>
            </ul>
          </div>
        ) : null}
      </div>

      <div className="innercontainer">
        <div className="overlay">
          {!isSubmitted ? (
            <form className="p-4">
              <div class="form-group text-left">
                <label className="label1" htmlFor="exampleInputPassword1">
                  NEW PASSWORD
                </label>
                <input
                  type="password"
                  class="input"
                  id="exampleInputPassword1"
                  //   placeholder="Password"
                />
              </div>
              <div class="form-group text-left">
                <label className="label1" htmlFor="exampleInputPassword1">
                  CONFIRM PASSWORD
                </label>
                <input
                  type="password"
                  class="input"
                  id="exampleInputPassword2"
                  //   placeholder="Password"
                />
              </div>

              <div className="row">
                <div class=" col-md-2 form-button text-left">
                  <button
                    type="submit"
                    class="btn btn-primary label mt-2"
                    onClick={() => {
                      console.log("hellp");
                      setIsSubmitted(true);
                    }}
                    style={{
                      fontSize: 18,
                      paddingLeft: 10,
                      paddingRight: 10,
                      // width: "10%",
                    }}
                  >
                    SUBMIT
                  </button>
                </div>
              </div>
            </form>
          ) : (
            <div className="p-5">
              <div className="row mb-4">
                <div
                  class="label2 text-left text-center"
                  style={{
                    color: "#525252",
                  }}
                >
                  You have successfully changed your password
                </div>
              </div>
              <div className="row">
                <div
                  class=" form-button text-center"
                  // style={{ backgroundColor: "red" }}
                >
                  <button
                    type="submit"
                    class="btn btn-primary label"
                    onClick={() => {
                      setRed(true);
                      // setIsSubmitted(false);
                    }}
                    style={{
                      fontSize: 18,
                      paddingLeft: 10,
                      paddingRight: 10,
                      // width: "10%",
                    }}
                  >
                    BACK HOME
                  </button>
                </div>
              </div>
            </div>
          )}
        </div>
        <div className="">
          <img height="100" width="200" src={logo} alt="logo" />
        </div>
      </div>
    </div>
  );
}

export default ChangePassword;
// const styles = {
//   background: {
//     backgroundImage: `url(${background})`,
//     backgroundSize: "cover",
//     backgroundPosition: "center",
//     width: "100%",
//     height: "100vh",
//     // flex: 1,
//   },
// };
