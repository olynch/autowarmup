'use strict';

var React = require("react");
var ReactDOMRe = require("reason-react/src/ReactDOMRe.js");
var App$ReasonReactStarter = require("./App.bs.js");

((require("./styles.scss")));

ReactDOMRe.renderToElementWithId(React.createElement(App$ReasonReactStarter.make, { }), "root");

/*  Not a pure module */
