import tenantSwitcherReducer from './tenant_switcher_reducer';
import railsContextReducer from './rails_context_reducer';
import wizardReducer from './wizard_reducer'

const GetReducers = (CortexState, railsContext) => {
  return {
    session: tenantSwitcherReducer(CortexState),
    wizard: wizardReducer(CortexState),
    railsContext: railsContextReducer(railsContext)
  }
};

export default GetReducers
