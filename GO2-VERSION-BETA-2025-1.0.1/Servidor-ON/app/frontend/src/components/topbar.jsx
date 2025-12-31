import React, { useState, useRef } from "react";
import { useDispatch, useSelector } from "react-redux";
import { Link } from "react-router-dom";
import logo from "../img/logo.webp";
import translate from "../img/translate.png";
import userImage from "../img/user.png";
import "./topbar.css";
import { logout } from "../actions/auth";
import { useTranslation } from 'react-i18next';

function Topbar(props) {
  const { i18n } = useTranslation();
  const [selectedLang, setSelectedLang] = useState('en');

  const changeLanguage = (event) => {
    setSelectedLang(event);
    i18n.changeLanguage(event);
  }

  const [modalType, setType] = useState("Login");
  const [user, setUser] = useState(localStorage.getItem("user"));

  const dispatch = useDispatch();

  const signout = () => {
    dispatch(logout());
    localStorage.removeItem("user");
    setUser("");
  };

  const { t } = useTranslation();

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
        <ul className="nav justify-content-end px-4">
          {user ? (
            <li className="nav-item dropdown">
              <a
                className="nav-link"
                href="#"
                id="navbarDropdown"
                role="button"
                data-bs-toggle="dropdown"
                aria-expanded="false"
              >
                <img height="30" width="30" src={userImage} alt="logo" />
              </a>
              <ul
                className="dropdown-menu bg-black p-3"
                aria-labelledby="navbarDropdown"
                style={{ width: 250, textAlign: "end" }}
              >
                <li
                  className="list-group-item languageList"
                  style={{ display: "flex", flexWrap: "no-wrap" }}
                >
                  <Link
                    to="/changePassword"
                    className="userBox__listText btn-primary"
                  >
                    {t('CHANGE_PASSWORD')}
                  </Link>
                </li>
                <li className="list-group-item languageList" onClick={signout}>
                  <button className="userBox__listText btn-primary">
                    {t('LOGOUT')}
                  </button>
                </li>
              </ul>
            </li>
          ) : (
            <li className="nav-item dropdown p-2">
              <Link
                to="/signin"
                className="nav-item gray-heading-font login-link"
              >
                {t('LOGIN')}
              </Link>
            </li>
          )}
          <li className="nav-item dropdown">
            <a
              className="nav-link"
              href="#"
              id="navbarDropdown"
              role="button"
              data-bs-toggle="dropdown"
              aria-expanded="false"
            >
              <img height="30" width="30" src={translate} alt="logo" />
            </a>
            <ul className="dropdown-menu bg-black" aria-labelledby="navbarDropdown">
              <li
                className={
                  i18n.language === "en"
                    ? "list-group-item languageListActive"
                    : "list-group-item languageList"
                }
                onClick={() => {
                  changeLanguage("en");
                }}
                style={{
                  fontFamily: "Exo",
                }}
              >
                {t('ENGLISH')}{" "}
              </li>
              <li
                className={
                  i18n.language === "fr"
                    ? "list-group-item languageListActive"
                    : "list-group-item languageList"
                }
                onClick={() => {
                  changeLanguage("fr");
                }}
                style={{
                  fontFamily: "Exo",
                }}
              >
                {t('FRENCH')}{" "}
              </li>
              <li
                className={
                  i18n.language === "pt"
                    ? "list-group-item languageListActive"
                    : "list-group-item languageList"
                }
                onClick={() => {
                  changeLanguage("pt");
                }}
                style={{
                  fontFamily: "Exo",
                }}
              >
                {t('PORTUGUESE')}{" "}
              </li>
              <li
                className={
                  i18n.language === "es"
                    ? "list-group-item languageListActive"
                    : "list-group-item languageList"
                }
                onClick={() => {
                  changeLanguage("es");
                }}
                style={{
                  fontFamily: "Exo",
                }}
              >
                {t('SPANISH')}{" "}
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
