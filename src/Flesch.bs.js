'use strict';

var List = require("bs-platform/lib/js/list.js");
var Block = require("bs-platform/lib/js/block.js");
var Random = require("bs-platform/lib/js/random.js");
var Caml_builtin_exceptions = require("bs-platform/lib/js/caml_builtin_exceptions.js");

var all = /* :: */[
  /* Major */0,
  /* :: */[
    /* Minor */1,
    /* [] */0
  ]
];

function show(x) {
  if (x) {
    return "minor";
  } else {
    return "major";
  }
}

var Mode = {
  all: all,
  show: show
};

var all$1 = List.concat(/* :: */[
      List.map((function (x) {
              return /* TonicArpeggio */Block.__(0, [x]);
            }), all),
      /* :: */[
        List.map((function (x) {
                return /* DominantArpeggio */Block.__(1, [x]);
              }), all),
        /* :: */[
          /* :: */[
            /* Diminished */0,
            /* :: */[
              /* Dominant7 */1,
              /* [] */0
            ]
          ],
          /* [] */0
        ]
      ]
    ]);

function show$1(x) {
  if (typeof x === "number") {
    if (x === /* Diminished */0) {
      return "diminished";
    } else {
      return "dominant 7";
    }
  } else if (x.tag) {
    return (
            x[0] ? "minor" : "major"
          ) + " dominant";
  } else {
    return (
            x[0] ? "minor" : "major"
          ) + " tonic";
  }
}

var ArpeggioType = {
  all: all$1,
  show: show$1
};

var all$2 = /* :: */[
  /* Thirds */0,
  /* :: */[
    /* Sixths */1,
    /* :: */[
      /* Octaves */2,
      /* [] */0
    ]
  ]
];

function show$2(x) {
  switch (x) {
    case /* Thirds */0 :
        return "thirds";
    case /* Sixths */1 :
        return "sixths";
    case /* Octaves */2 :
        return "octaves";
    
  }
}

var ChordType = {
  all: all$2,
  show: show$2
};

var all$3 = /* :: */[
  /* Melodic */0,
  /* :: */[
    /* InThirds */1,
    /* :: */[
      /* Chromatic */2,
      /* [] */0
    ]
  ]
];

function show$3(x) {
  switch (x) {
    case /* Melodic */0 :
        return "";
    case /* InThirds */1 :
        return "melodic thirds";
    case /* Chromatic */2 :
        return "chromatic";
    
  }
}

var ScaleType = {
  all: all$3,
  show: show$3
};

var all$4 = List.concat(/* :: */[
      List.map((function (x) {
              return /* Scale */Block.__(0, [x]);
            }), all$3),
      /* :: */[
        List.map((function (x) {
                return /* Arpeggio */Block.__(1, [x]);
              }), all$1),
        /* [] */0
      ]
    ]);

function show$4(x) {
  if (x.tag) {
    return show$1(x[0]) + " arpeggio";
  } else {
    return show$3(x[0]) + " scale";
  }
}

var ScaleArpeggio = {
  all: all$4,
  show: show$4
};

var all$5 = /* :: */[
  /* IV */0,
  /* :: */[
    /* III */1,
    /* :: */[
      /* II */2,
      /* :: */[
        /* I */3,
        /* [] */0
      ]
    ]
  ]
];

function show$5(x) {
  switch (x) {
    case /* IV */0 :
        return "IV";
    case /* III */1 :
        return "III";
    case /* II */2 :
        return "II";
    case /* I */3 :
        return "I";
    
  }
}

var ViolinString = {
  all: all$5,
  show: show$5
};

function cross(xs, ys) {
  return List.flatten(List.map((function (x) {
                    return List.map((function (y) {
                                  return /* tuple */[
                                          x,
                                          y
                                        ];
                                }), ys);
                  }), xs));
}

var all$6 = List.concat(/* :: */[
      List.map((function (param) {
              return /* SingleOctave */Block.__(0, [
                        param[0],
                        param[1]
                      ]);
            }), cross(all$4, all$5)),
      /* :: */[
        List.map((function (x) {
                return /* ThreeOctave */Block.__(1, [x]);
              }), all$4),
        /* :: */[
          List.map((function (param) {
                  return /* ChordScale */Block.__(2, [
                            param[0],
                            param[1]
                          ]);
                }), cross(all$3, all$2)),
          /* [] */0
        ]
      ]
    ]);

function show$6(x) {
  switch (x.tag | 0) {
    case /* SingleOctave */0 :
        return "single octave " + (show$4(x[0]) + (" on " + show$5(x[1])));
    case /* ThreeOctave */1 :
        return "three octave " + show$4(x[0]);
    case /* ChordScale */2 :
        return show$3(x[0]) + (" scale in " + show$2(x[1]));
    
  }
}

var FleschSection = {
  all: all$6,
  show: show$6
};

function uniformChoice(xs) {
  return List.nth(xs, Random.$$int(List.length(xs)));
}

function biasedChoice(xs) {
  var helper = function (param) {
    if (param) {
      var xs = param[1];
      var match = param[0];
      var p = match[1];
      var x = match[0];
      return (function (s, t) {
          if (t <= p) {
            return x;
          } else {
            return helper(xs)(s - p, t - p);
          }
        });
    } else {
      throw [
            Caml_builtin_exceptions.match_failure,
            /* tuple */[
              "Flesch.ml",
              105,
              17
            ]
          ];
    }
  };
  var t = Random.$$float(1);
  return helper(xs)(List.fold_left((function (prim, prim$1) {
                    return prim + prim$1;
                  }), 0, List.map((function (prim) {
                        return prim[1];
                      }), xs)), t);
}

function randomSection(param) {
  return uniformChoice(all$6);
}

exports.Mode = Mode;
exports.ArpeggioType = ArpeggioType;
exports.ChordType = ChordType;
exports.ScaleType = ScaleType;
exports.ScaleArpeggio = ScaleArpeggio;
exports.ViolinString = ViolinString;
exports.cross = cross;
exports.FleschSection = FleschSection;
exports.uniformChoice = uniformChoice;
exports.biasedChoice = biasedChoice;
exports.randomSection = randomSection;
/* all Not a pure module */
