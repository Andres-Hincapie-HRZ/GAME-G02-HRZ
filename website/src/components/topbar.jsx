import React, { useState} from "react";
import { Link } from "react-router-dom";
import logo from "../img/logo.webp";
import translate from "../img/translate.png";
import userImage from "../img/user.png";
import Signin from "./signin";
import Signup from "./signup";
import ForgetPassword from "./forgetPassword";
import "./topbar.css";
import { useDispatch } from "react-redux";
import { logout } from "../actions/auth";

function Topbar(props) {
  const [language, setLanguage] = useState("English");
  const [modalType, setType] = useState("Login");
  const [user, setUser] = useState(localStorage.getItem("user"));

  const dispatch = useDispatch();

  const signout = () => {
    dispatch(logout());
    localStorage.removeItem("user");
    setUser("");
  };

  return (
    <div className="row">
      <div className={` ${props.imgCentered ? "p-3 col-10" : "p-5 col-6"}`}>
        <div>
          <img
            style={{
              width: "100%",
              maxWidth: props.imgCentered ? "200px" : "260px",
              minWidth: "150px",
              marginLeft: props.imgCentered ? "50%" : "",
              marginRight: props.imgCentered ? "50%" : "",
            }}
            src={logo}
            alt="logo"
            className="main-logo"
          />
        </div>
      </div>
      <div
        className={` ${props.imgCentered ? "col-2 signup" : "col-6 signup "}`}
      >
        <ul class="nav justify-content-end px-4">
          {user ? (
            <li class="nav-item dropdown">
              <a
                class="nav-link"
                href="#"
                id="navbarDropdown"
                role="button"
                data-bs-toggle="dropdown"
                aria-expanded="false"
              >
                <img height="30" width="30" src={userImage} alt="logo" />
              </a>
              <ul
                class="dropdown-menu bg-black p-3"
                aria-labelledby="navbarDropdown"
                style={{ width: 250, textAlign: "end" }}
              >
                <li
                  className="list-group-item languageList"
                  onClick={() => {
                    setLanguage("English");
                  }}
                >
                  <Link
                    to="/changePassword"
                    className="userBox__listText btn-primary"
                  >
                    Change Password
                  </Link>
                </li>
                <li className="list-group-item languageList" onClick={signout}>
                  <button className="userBox__listText btn-primary">
                    Logout
                  </button>
                </li>
              </ul>
            </li>
          ) : (
            <li class="nav-item dropdown p-2">
              <span
                className="nav-item gray-heading-font"
                href="#"
                id="navbarDropdown"
                role="button"
                data-bs-toggle="dropdown"
                aria-expanded="false"
                style={{ color: "#707070", fontSize: 22 }}
              >
                Login
              </span>
              <ul
                class="dropdown-menu bg-black p-3"
                aria-labelledby="navbarDropdown"
                style={{
                  width: "max-content",
                }}
              >
                <li>
                  <div>
                    {modalType === "Login" ? (
                      <div>
                        <Signin setType={setType} />
                      </div>
                    ) : modalType === "Signup" ? (
                      <div>
                        <Signup setType={setType} />
                      </div>
                    ) : modalType === "Forget" ? (
                      <div>
                        <ForgetPassword setType={setType} />
                      </div>
                    ) : null}
                  </div>
                </li>
              </ul>
            </li>
          )}
          <li class="nav-item dropdown">
            <a
              class="nav-link"
              href="#"
              id="navbarDropdown"
              role="button"
              data-bs-toggle="dropdown"
              aria-expanded="false"
            >
              <img height="30" width="30" src={translate} alt="logo" />
            </a>
            <ul class="dropdown-menu bg-black" aria-labelledby="navbarDropdown">
              <li
                className={
                  language === "English"
                    ? "list-group-item languageListActive"
                    : "list-group-item languageList"
                }
                onClick={() => {
                  setLanguage("English");
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
                }}
                style={{
                  fontFamily: "Exo",
                }}
              >
                SPANISH{" "}
              </li>
            </ul>
          </li>
        </ul>
      </div>
    </div>
  );
}
const styles = {
  container: {
    display: "flex",
    justifyContent: "space-between",
  },
};
export default Topbar;
