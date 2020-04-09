'use strict';

var Curry = require("bs-platform/lib/js/curry.js");
var React = require("react");
var Flesch$ReasonReactStarter = require("./Flesch.bs.js");

var initialState = {
  section: Flesch$ReasonReactStarter.randomSection(/* () */0)
};

function reducer(_state, _action) {
  return {
          section: Flesch$ReasonReactStarter.randomSection(/* () */0)
        };
}

function App$RandomSection(Props) {
  var match = React.useReducer(reducer, initialState);
  var dispatch = match[1];
  return React.createElement("div", undefined, React.createElement("div", undefined, Flesch$ReasonReactStarter.FleschSection.show(match[0].section)), React.createElement("div", undefined, React.createElement("button", {
                      onClick: (function (_event) {
                          return Curry._1(dispatch, /* NewSection */0);
                        })
                    }, "New Section")));
}

var RandomSection = {
  initialState: initialState,
  reducer: reducer,
  make: App$RandomSection
};

var notes = /* :: */[
  "A",
  /* :: */[
    "B-flat",
    /* :: */[
      "B",
      /* :: */[
        "C",
        /* :: */[
          "C-sharp",
          /* :: */[
            "D",
            /* :: */[
              "E-flat",
              /* :: */[
                "E",
                /* :: */[
                  "F",
                  /* :: */[
                    "F-sharp",
                    /* :: */[
                      "G",
                      /* :: */[
                        "G-sharp",
                        /* [] */0
                      ]
                    ]
                  ]
                ]
              ]
            ]
          ]
        ]
      ]
    ]
  ]
];

var initialState$1 = {
  note: Flesch$ReasonReactStarter.uniformChoice(notes)
};

function reducer$1(_state, _action) {
  return {
          note: Flesch$ReasonReactStarter.uniformChoice(notes)
        };
}

function App$RandomNote(Props) {
  var match = React.useReducer(reducer$1, initialState$1);
  var dispatch = match[1];
  return React.createElement("div", undefined, React.createElement("div", undefined, match[0].note), React.createElement("div", undefined, React.createElement("button", {
                      onClick: (function (_event) {
                          return Curry._1(dispatch, /* NewNote */0);
                        })
                    }, "New Key")));
}

var RandomNote = {
  notes: notes,
  initialState: initialState$1,
  reducer: reducer$1,
  make: App$RandomNote
};

function App(Props) {
  return React.createElement("div", {
              className: "section"
            }, React.createElement("div", {
                  className: "container"
                }, React.createElement("div", {
                      className: "columns"
                    }, React.createElement("div", {
                          className: "column"
                        }, React.createElement("h1", {
                              className: "title"
                            }, "Random Section of Flesch"))), React.createElement("div", {
                      className: "columns"
                    }, React.createElement("div", {
                          className: "column"
                        }, React.createElement(App$RandomNote, { })), React.createElement("div", {
                          className: "column"
                        }, React.createElement(App$RandomSection, { })))));
}

var make = App;

exports.RandomSection = RandomSection;
exports.RandomNote = RandomNote;
exports.make = make;
/* initialState Not a pure module */
