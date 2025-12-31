import React, { useState, useEffect } from "react";
import Topbar from "../../components/topbar";
import "./PlayPage.css";
import btn from "../../img/ui icons/outline_first_page_white_48dp.png";
import { useHistory, useParams } from "react-router-dom";
import { Api } from "../../components/Api";

const PlayPage = () => {

  const [sessionKey, setSessionKey] = useState("");
  const history = useHistory();
  const { userId } = useParams();

  useEffect(() => {
    getCurrentuser();
    document.body.setAttribute("data-bg", "play");
    console.log(document.body)
  }, []);

  const getCurrentuser = async () => {
    const response = await Api("get", `account/play/user/${userId}`);
    console.log("response", response);
    setSessionKey(response.data.data.sessionKey);
  };

  return (
    <div id="wrapper" className={"wrapper"}>
      <Topbar imgCentered={true} />
      {sessionKey ? (
        <iframe
          src={`${process.env.REACT_APP_CLIENT}/?userId=${userId}&sessionKey=${sessionKey}`}
          title="game"
          frameborder="0"
          scrolling="no"
          height="650px"
          className="play-page-cambus"
        ></iframe>
      ) : null}
      <div
        className="play-page-btn"
        onClick={() => {
          document.body.removeAttribute("data-bg");
          history.push("/myplanets");
        }}
        style={{ display: "block", marginLeft: "auto" }}
      >
        <img src={btn} style={{ width: "75px", height: "75px" }} />
        <br />
        <span style={{ color: "gray" }}>My Planets</span>
      </div>
    </div>
  );
};

export default PlayPage;
