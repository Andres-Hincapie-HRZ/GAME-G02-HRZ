import React from "react";
import "./navbar.css";
import { Link } from "react-router-dom";

function Navbar({ active }) {
  return (
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark1">
      <div class="container-fluid">
        <button
          class="navbar-toggler"
          type="button"
          data-bs-toggle="collapse"
          data-bs-target="#navbarSupportedContent"
          aria-controls="navbarSupportedContent"
          aria-expanded="false"
          aria-label="Toggle navigation"
        >
          <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
          <ul
            class="navbar-nav me-auto "
            style={{ borderBottom: "1px solid white" }}
          >
            <li className="nav-item active ">
              <Link className="nav-link" to="/">
                <p
                  className="item-font"
                  style={active === 1 ? styles.navtextactive : styles.navtext}
                >
                  Home <span className="sr-only">(current)</span>
                </p>
              </Link>
            </li>
            <li className="nav-item ">
              <Link className="nav-link" to="/myplanets">
                <p
                  className="item-font"
                  style={active === 2 ? styles.navtextactive : styles.navtext}
                >
                  MY PLANETS
                </p>
              </Link>
            </li>
            <li className="nav-item">
              <a className="nav-link" href="#">
                <p
                  className="item-font"
                  style={active === 3 ? styles.navtextactive : styles.navtext}
                >
                  FORUM
                </p>
              </a>
            </li>
            <li className="nav-item">
              <a className="nav-link" href="#">
                <p
                  className="item-font"
                  style={active === 4 ? styles.navtextactive : styles.navtext}
                >
                  SHOP
                </p>
              </a>
            </li>
            <li className="nav-item">
              <a className="nav-link" href="#">
                <p
                  className="item-font"
                  style={active === 5 ? styles.navtextactive : styles.navtext}
                >
                  DISCORD
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
