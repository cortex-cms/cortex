import tenantSwitcherReducer from 'cortex/reducers/tentant_switcher_reducer';
import railsContextReducer from 'cortex/reducers/rails_context_reducer';
import wizardReducer from 'cortex/reducers/wizard_reducer'

const GetReducers = (CortexState, railsContext) => {
  return {
    session: tenantSwitcherReducer(CortexState),
    wizard: wizardReducer(CortexState),
    railsContext: railsContextReducer(railsContext)
  }
};

export default GetReducers
