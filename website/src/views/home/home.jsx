import "./home.css";
import Content from "../../components/content";

import Topbar from "../../components/topbar";
import Footer from "../../components/footer";
import React, { useState } from "react";

function Home() {
  const [showLogin, setShowLogin] = useState(false);
  const [showTranslation, setShowTranlation] = useState(false);
  const [isReadMore, setIsReadMore] = useState(true);
  if (!isReadMore) {
    document.getElementById("root").setAttribute("class", "wrapper-overlay");
  } else {
    document.getElementById("root").setAttribute("class", "none");
  }

  return (
    <div id="wrapper" className={"wrapper"}>
      <div class="header">
        <Topbar
          showLogin={showLogin}
          setShowLogin={setShowLogin}
          showTranslation={showTranslation}
          setShowTranlation={setShowTranlation}
        />
      </div>
      <div className="px-3">
        <div class="content">
          <Content
            isReadMore={isReadMore}
            setIsReadMore={setIsReadMore}
            active={1}
          />
        </div>
        <footer className="foot mt-5 p-3">
          <Footer />
        </footer>
      </div>
    </div>
  );
}

export default Home;
