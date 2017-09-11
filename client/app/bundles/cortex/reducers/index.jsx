import setTenantSwitcherReducer from 'cortex/reducers/tentant_switcher_reducer';
import setRailsContextReducer from 'cortex/reducers/rails_context_reducer';
import setWizardReducer from 'cortex/reducers/wizard_reducer'

const GetReducers = (CortexState, railsContext) => {
  return {
    session: setTenantSwitcherReducer(CortexState),
    wizard: setWizardReducer(CortexState),
    railsContext: setRailsContextReducer(railsContext)
  }
};

export default GetReducers
