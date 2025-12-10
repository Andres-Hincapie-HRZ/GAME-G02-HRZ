import React, { useState, useRef } from "react";
import "./navbar.css";
import { Link } from "react-router-dom";

import { useTranslation } from 'react-i18next';

function Navbar({ active }) {

  const [user, setUser] = useState(localStorage.getItem("user"));

  const { t } = useTranslation();

  return (
    <nav className="navbar navbar-expand-lg navbar-dark bg-dark1">
      <div className="container-fluid">
        <button
          className="navbar-toggler"
          type="button"
          data-bs-toggle="collapse"
          data-bs-target="#navbarSupportedContent"
          aria-controls="navbarSupportedContent"
          aria-expanded="false"
          aria-label="Toggle navigation"
        >
          <span className="navbar-toggler-icon"></span>
        </button>
        <div className="collapse navbar-collapse" id="navbarSupportedContent">
          <ul
            className="navbar-nav me-auto "
            style={{ borderBottom: "1px solid white" }}
          >
            <li className="nav-item active ">
              <Link className="nav-link" to="/">
                <p
                  className="item-font"
                  style={active === 1 ? styles.navtextactive : styles.navtext}
                >
                  {t('HOME')} <span className="sr-only">({t('CURRENT')})</span>
                </p>
              </Link>
            </li>
            {user ? (
              <li className="nav-item ">
                <Link className="nav-link" to="/myplanets">
                  <p
                    className="item-font"
                    style={active === 2 ? styles.navtextactive : styles.navtext}
                  >
                    {t('MY_PLANETS')}
                  </p>
                </Link>
              </li>
            ):(null)}
            {user ? (
              <li className="nav-item">
                <a className="nav-link" href="/redeem">
                  <p
                    className="item-font"
                    style={active === 3 ? styles.navtextactive : styles.navtext}
                  >
                    {t('REDEEM')}
                  </p>
                </a>
              </li>
            ):(null)}
            <li className="nav-item">
              <a className="nav-link" href="#">
                <p
                  className="item-font"
                  style={active === 4 ? styles.navtextactive : styles.navtext}
                >
                  {t('FORUM')}
                </p>
              </a>
            </li>
            {user ? (
              <li className="nav-item">
                <a className="nav-link" href="#">
                  <p
                    className="item-font"
                    style={active === 5 ? styles.navtextactive : styles.navtext}
                  >
                    {t('SHOP')}
                  </p>
                </a>
              </li>
            ):(null)}
            <li className="nav-item">
              <a className="nav-link" href="#">
                <p
                  className="item-font"
                  style={active === 6 ? styles.navtextactive : styles.navtext}
                >
                  {t('DISCORD')}
                </p>
              </a>
            </li>
          </ul>
        </div>
      </div>
    </nav>
  );
}

export default Navbar;
const styles = {
  navtext: {
    color: "gray",
  },
  navtextactive: {
    color: "white",
  },
};
