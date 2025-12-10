import "./myplanets.css";
import Navbar from "../../components/navbar";

import Topbar from "../../components/topbar";
import Footer from "../../components/footer";
import React, { useState, useEffect } from "react";
import { PlusIcon } from "@heroicons/react/outline";

import loadTerrain from "../../img/load.jpg";
import desertTerrain from "../../img/desert.jpg";
import snowTerrain from "../../img/snow.jpg";
import cashImg from "../../img/cash.png";
import goldImg from "../../img/gold.png";
import metalImg from "../../img/metal.png";
import he3Img from "../../img/he3.png";
import planetPlaceholder from "../../img/planet-holder.png";
import { Api } from "../../components/Api";
import { useHistory } from "react-router-dom";

function MyPlanet() {
  const history = useHistory();
  const [showLogin, setShowLogin] = useState(false);
  const [showTranslation, setShowTranlation] = useState(false);
  const [isReadMore, setIsReadMore] = useState(true);

  const [showPlanetSelector, setShowPlanetSelector] = useState(false);
  const [selectedPlanet, setSelectedPlanet] = useState(0);
  const [addedPlanets, setAddedPlanets] = useState([]);
  const [planetName, setPlanetName] = useState("");
  const [refresh, setreFresh] = useState(false);
  const [planetSubmited, setPlanetSubmited] = useState(false);
  const [selectedPlanetUser, setSelectedPlanetUser] = useState({});

  if (!isReadMore) {
    document.getElementById("root").setAttribute("class", "wrapper-overlay");
  } else {
    document.getElementById("root").setAttribute("class", "none");
  }

  useEffect(() => {
    getPlanets();
  }, [refresh]);

  const getPlanets = async () => {
    const response = await Api("get", "account/list/user");
    setAddedPlanets(response.data);
  };

  const submitPlanet = async () => {
    if (addedPlanets.length === 5) {
      return;
    }
    setPlanetSubmited(true);

    const response = await Api("post", "account/create/user", {
      username: planetName,
      ground: selectedPlanet,
    });
    if (
      response.data.message == "MAX_USER" ||
      response.data.message == "INVALID_GROUND"
    ) {
      alert(response.data.message);
      setPlanetName("");
      setSelectedPlanet(0);
      setShowPlanetSelector(false);
      setreFresh(!refresh);
    } else {
      addedPlanets.data.push({
        username: planetName,
        ground: selectedPlanet,
      });

      setPlanetName("");
      setSelectedPlanet(0);
      setShowPlanetSelector(false);
      setreFresh(!refresh);
    }

    // setPlanetName("");
    // setSelectedPlanet(0);
    // setShowPlanetSelector(false);
    // setreFresh(!refresh);
  };

  const handlePlay = async () => {
    history.push(`/play-page/${selectedPlanetUser.userId}`);
  };

  return (
    <div id="wrapper" className={"wrapper"}>
      <div className="content-container">
        <Topbar
          showLogin={showLogin}
          setShowLogin={setShowLogin}
          showTranslation={showTranslation}
          setShowTranlation={setShowTranlation}
        />
        <Navbar active={2} />

        <div className="d-flex ml-4 flex-wrap align-items-center">
          {addedPlanets?.data?.map((name, index) => {
            return (
              <div
                className="d-flex align-items-center"
                key={index}
                onClick={() => {
                  setSelectedPlanetUser(name);
                }}
              >
                <div
                  className="added__plannetContainer ml-4 mt-3"
                  style={{
                    border:
                      name.username == selectedPlanetUser?.username
                        ? "2px solid green"
                        : "",
                  }}
                >
                  <div className="added__plannet--img">
                    <img src={planetPlaceholder} alt="" />
                  </div>
                </div>
                <div className="myPlanet_addedPlanetContainer ml-3 mt-3">
                  <p>{name.username}</p>
                  <div className="d-flex flex-column items-center justify-center px-3">
                    <h4 style={{ fontSize: 20, fontWeight: 100 }}>
                      {name.userId}
                    </h4>
                    <div className="myPlanet_addedPlanetContainer--image d-inline-flex items-center">
                      <img src={goldImg} alt="" />
                      <p>{name?.resources?.gold}</p>
                    </div>
                    <div className="myPlanet_addedPlanetContainer--image d-inline-flex items-center">
                      <img src={he3Img} alt="" />
                      <p>{name?.resources?.he3}</p>
                    </div>
                    <div className="myPlanet_addedPlanetContainer--image d-inline-flex items-center">
                      <img src={metalImg} alt="" />
                      <p>{name?.resources?.metal}</p>
                    </div>
                    <div className="myPlanet_addedPlanetContainer--image d-inline-flex items-center">
                      <img src={cashImg} alt="" />
                      <p>{name?.resources?.mallPoints}</p>
                    </div>
                  </div>
                </div>
              </div>
            );
          })}
          {addedPlanets.length % 2 !== 0 && (
            <div className="d-flex align-items-center">
              <div className="add__plannetContainer ml-4 mt-3">
                <div
                  className="add__plannet"
                  onClick={() => setShowPlanetSelector(true)}
                >
                  <PlusIcon color="white" className="plus__icon" />
                </div>
              </div>
              {showPlanetSelector && (
                <div className="myPlanet_addPlanetContainer ml-3">
                  <div className="myPlanet_addPlanet">
                    <h3>Username:</h3>
                    <input
                      type="text"
                      placeholder="Enter the username"
                      value={planetName}
                      onChange={(e) => setPlanetName(e.target.value)}
                    />
                  </div>
                  <div className="myPlanet_addPlanet">
                    <h3>Choose a terrain:</h3>
                    <div className="d-flex mt-2">
                      <div
                        className="myPlanet__addPlanet--image"
                        style={
                          selectedPlanet === 1
                            ? { border: "1px solid green" }
                            : {}
                        }
                        onClick={() => setSelectedPlanet(1)}
                      >
                        <img src={loadTerrain} alt="" />
                      </div>
                      <div
                        className="myPlanet__addPlanet--image"
                        style={
                          selectedPlanet === 2
                            ? { border: "1px solid green" }
                            : {}
                        }
                        onClick={() => setSelectedPlanet(2)}
                      >
                        <img src={desertTerrain} alt="" />
                      </div>
                      <div
                        className="myPlanet__addPlanet--image"
                        style={
                          selectedPlanet === 3
                            ? { border: "1px solid green" }
                            : {}
                        }
                        onClick={() => setSelectedPlanet(3)}
                      >
                        <img src={snowTerrain} alt="" />
                      </div>
                    </div>
                  </div>
                  <div className="myPlanet_addPlanetButtonContainer d-flex justify-content-end mt-3">
                    <button
                      onClick={submitPlanet}
                      disabled={selectedPlanet === 0}
                      style={selectedPlanet === 0 ? { background: "gray" } : {}}
                    >
                      SUBMIT
                    </button>
                  </div>
                </div>
              )}
            </div>
          )}
        </div>
      </div>
      <div className="px-3">
        <div className="myPlanet__selector d-flex flex-column justify-content-end align-items-end px-5">
          <div className="myPlanet__selectorTitle">
            <p>select a planet to play</p>
          </div>
          <div
            className={
              Object.keys(selectedPlanetUser).length == 0
                ? "myPlanet__buttonContainer"
                : "myPlanet__buttonContainer activeBtn"
            }
            onClick={() => {
              if (Object.keys(selectedPlanetUser).length != 0) {
                handlePlay();
              } else {
                return;
              }
            }}
          >
            <h1 className="display-2">PLAY</h1>
          </div>
        </div>
        <footer className="foot mt-5 p-3">
          <Footer />
        </footer>
      </div>
    </div>
  );
}

export default MyPlanet;
