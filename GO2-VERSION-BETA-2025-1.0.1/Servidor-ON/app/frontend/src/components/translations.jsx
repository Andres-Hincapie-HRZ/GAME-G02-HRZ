import React, { useState } from "react";
import { useTranslation } from 'react-i18next';

const Translations = () => {

  const { i18n } = useTranslation();
  const [selectedLang, setSelectedLang] = useState('en');
  const changeLanguage = (event) => {
    setSelectedLang(event);
    i18n.changeLanguage(event);
  }
  const [isSubmitted, setIsSubmitted] = useState(false);

  const { t } = useTranslation();

  return (
    <div>
      <ul className="list-group bg-black text-center">
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
    </div>
  )
}

export default Translations;