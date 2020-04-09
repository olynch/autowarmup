module RandomSection = {
  type state = {section: Flesch.FleschSection.t};

  type action = NewSection;

  let initialState = {section: Flesch.randomSection(())};

  let reducer = (_state,_action) => {
    {section: Flesch.randomSection(())}
  };

  [@react.component]
    let make = () => {
      let (state, dispatch) = React.useReducer(reducer, initialState);

      <div>
        <div>
          {React.string{Flesch.FleschSection.show(state.section)}}
        </div>
        <div>
          <button onClick={_event => dispatch(NewSection)}>
            {React.string("New Section")}
          </button>
        </div>
      </div>;
    };
};

module RandomNote = {
  let notes = ["A","B-flat","B","C","C-sharp","D","E-flat","E","F","F-sharp","G","G-sharp"];

  type state = {note: string};

  type action = NewNote;

  let initialState = {note: Flesch.uniformChoice(notes)};

  let reducer = (_state,_action) => {
    {note: Flesch.uniformChoice(notes)}
  };

  [@react.component]
    let make = () => {
      let (state, dispatch) = React.useReducer(reducer, initialState);

      <div>
        <div>
          {React.string{state.note}}
        </div>
        <div>
          <button onClick={_event => dispatch(NewNote)}>
            {React.string("New Key")}
          </button>
        </div>
      </div>;
    };
};

[@react.component]
let make = () => {
  <div className="section">
    <div className="container">
      <div className="columns">
        <div className="column">
          <h1 className="title">
            {React.string("Random Section of Flesch")}
          </h1>
        </div>
      </div>
      <div className="columns">
        <div className="column">
            <RandomNote />
        </div>
        <div className="column">
            <RandomSection />
        </div>
      </div>
    </div>
  </div>;
};
