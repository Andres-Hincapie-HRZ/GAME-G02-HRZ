import React from "react";
import useInfo from "../hooks/useInfo";
import "./footer.css";

function Footer() {

  const { onlinePlayers, patch, coordinates } = useInfo();

  return (
    <>
      <div><p className="text" style={{ textAlign: "end" }}>© 2022 SuperGO2 All Rights Reserved</p></div>
      <div className="c-footer">

        <div className="row">
          <div
            className="col-md-4 footer-section"
            style={{
              borderRight: "1px solid white",
            }}
          >
            <p className="heading">Online Players:</p>
            <p className="text">{onlinePlayers}</p>
          </div>{" "}
          <div
            className="col-md-4 footer-section"
            style={{ borderRight: "1px solid white" }}
          >
            <p className="heading">Last Planet Created:</p>
            <p className="text">
              {coordinates.x},{coordinates.y}
              <span className="sub-heading"> coordinates</span>
            </p>
          </div>
          <div className="col-md-4 footer-section ">
            <p className="heading">Current Patch:</p>
            <p className="text">{patch}</p>
          </div>
        </div>
      </div>
    </>
  );
}

export default Footer;
