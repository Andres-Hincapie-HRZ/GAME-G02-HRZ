import React, { useEffect } from "react";
import "./App.css";
import Home from "./views/home/home";
import Signup from "./views/signup/signup";
import Signin from "./views/signin/signin";
import ForgetPassword from "./views/forgetPassword/forgetPassword";
import ChangePassword from "./views/changePassword/changePassword";
import Myplanets from "./views/myplanets/myplanets";
import Redeem from "./views/redeem/redeem";
import PlayPage from "./views/playPage/PlayPage.jsx";
import { Route, Router } from "react-router-dom";
import { logout } from "./actions/auth";
import { clearMessage } from "./actions/message";
import { useDispatch, useSelector } from "react-redux";

import { history } from "./helpers/history";
import PrivateRoute from "./components/PrivateRoute";
import { InfoContextProvider } from "./context/InfoContextProvider";

function App() {

  const { user: currentUser } = useSelector((state) => state.auth);
  const dispatch = useDispatch();

  useEffect(() => {
    history.listen((location) => {
      dispatch(clearMessage()); // clear message when changing location
    });
  }, [dispatch]);

  return (
    <div>
      <InfoContextProvider>
        <Router history={history}>
          <Route exact={true} path="/" component={Home} />
          <Route exact={true} path="/play-page/:userId" component={PlayPage} />
          <PrivateRoute exact={true} path="/myplanets" component={Myplanets} />
          <Route path="/signup" component={Signup} />
          <Route path="/signin" component={Signin} />
          <Route path="/forgetPassword" component={ForgetPassword} />
          <PrivateRoute exact={true} path="/redeem" component={Redeem} />
          <Route path="/changePassword" component={ChangePassword} />
        </Router>
      </InfoContextProvider>
    </div>
  );
}

export default App;
