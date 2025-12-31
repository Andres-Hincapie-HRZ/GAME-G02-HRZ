import React, { Suspense } from "react";
import ReactDOM from "react-dom";
import "./index.css";
import App from "./App";
import "bootstrap/dist/css/bootstrap.min.css";
import "bootstrap/dist/js/bootstrap";
import { Provider } from "react-redux";
import reportWebVitals from "./reportWebVitals";
import store from "./store";

import './i18n';

ReactDOM.render(
  <Provider store={store}>
    <Suspense fallback={<span>Loading...</span>}>
      <App useSuspense={true}/>
    </Suspense>
  </Provider>,
  document.getElementById("root")
);

// If you want to start measuring performance in your app, pass a function
// to log results (for example: reportWebVitals(console.log))
// or send to an analytics endpoint. Learn more: https://bit.ly/CRA-vitals
reportWebVitals();
