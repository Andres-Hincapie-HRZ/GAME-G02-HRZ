import React from "react";
import useInfo from "../hooks/useInfo";
import "./footer.css";

import { useTranslation } from 'react-i18next';

function Footer() {

  const { onlinePlayers, patch, coordinates } = useInfo();

  const { t } = useTranslation();

  return (
    <>
      <div><p className="text" style={{ textAlign: "end" }}>© 2022 SuperGO2 {t('ALL_RIGHTS_RESERVED')}</p></div>
      <div className="c-footer">

        <div className="row">
          <div
            className="col-md-4 footer-section"
            style={{
              borderRight: "1px solid white",
            }}
          >
            <p className="heading">{t('ONLINE_PLAYERS')}</p>
            <p className="text">{onlinePlayers}</p>
          </div>{" "}
          <div
            className="col-md-4 footer-section"
            style={{ borderRight: "1px solid white" }}
          >
            <p className="heading">{t('LAST_PLANET_CREATED')}</p>
            <p className="text">
              {coordinates.x},{coordinates.y}
              <span className="sub-heading"> {t('COORDINATES')}</span>
            </p>
          </div>
          <div className="col-md-4 footer-section ">
            <p className="heading">{t('CURRENT_PATCH')}</p>
            <p className="text">{patch}</p>
          </div>
        </div>
      </div>
    </>
  );
}

export default Footer;
