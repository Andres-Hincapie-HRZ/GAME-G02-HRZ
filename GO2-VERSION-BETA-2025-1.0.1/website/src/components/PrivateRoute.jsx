import React from "react";
import { Route, Redirect } from "react-router-dom";
import { useSelector } from "react-redux";

const PrivateRoute = ({ component: RouteComponent, ...rest }) => {
  const user = localStorage.getItem("user");
  return (
    <Route
      {...rest}
      render={(routeprops) =>
        user ? <RouteComponent {...routeprops} /> : <Redirect to={"/"} />
      }
    />
  );
};

export default PrivateRoute;
