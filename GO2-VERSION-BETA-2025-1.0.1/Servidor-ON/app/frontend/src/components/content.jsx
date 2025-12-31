import React, { useState } from "react";
import Navbar from "../components/navbar";
// import "../App.css";
import "./content.css";

import { useTranslation } from 'react-i18next';

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

  const { t } = useTranslation();

  return (
    <div
      className={'Content'}
    >
      <Navbar active={props.active} />
      <div style={{ marginLeft: 30 }}>
        <p style={styles.text} className="content-text subContent">
          {t('HOME_INTRO')}
        </p>
        <p className="title-font">{t('CONQUER_THE_GALAXY')}</p>
      </div>
      <div
        style={{ marginLeft: 30 }}
      >
        <p className="content-text">
          {t('HOME_TEXT')}
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
