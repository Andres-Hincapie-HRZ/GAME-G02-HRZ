import React, { useState } from "react";
import Navbar from "../components/navbar";
// import "../App.css";
import "./content.css";

const ReadMore = (props) => {
  const text = props.children;

  const toggleReadMore = () => {
    props.setIsReadMore(!props.isReadMore);
  };

  return (
    <p className="content-text">
      {props.isReadMore ? text.slice(0, 84) : text}
      <span onClick={toggleReadMore} className="read-or-hide">
        {props.isReadMore ? "(...)" : " (less)"}
      </span>
    </p>
  );
};

const Content = (props) => {
  return (
    <div
      className={'Content'}
    >
      <Navbar active={props.active} />
      <div style={{ marginLeft: 30 }}>
        <p style={styles.text} className="content-text subContent">
          bringing planets back to life from the Ashes
        </p>
        <p className="title-font">CONQUER THE GALAXY</p>
      </div>
      <div
        style={{ marginLeft: 30 }}
      >
        <p className="content-text">
          Be the leader of the vast universe of Super Galaxy Online II, 
          build your strategies and emerge victorious through the battles.
          Super Galaxy Online II is a 2D Isometric sci-fi strategy game for
          PC and Mobile, taking place in an epic battle for the future of the
          universe, where powerful planet-owners face off the odysseys of a 
          wild universe. Who will have the best strategies? 
        </p>
      </div>
    </div>
  );
};

export default Content;
const styles = {
  text: {
    fontSize: 18,
    color: " #b7b5b5",
    fontFamily: "Exo",
    transform: "uppercase",
  },
};
