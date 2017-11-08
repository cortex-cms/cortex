import tenantSwitcherReducer from './tenant_switcher_reducer';
import railsContextReducer from './rails_context_reducer';
import wizardReducer from './wizard_reducer'
import contentTypeCreatorReducer from './content_type_creator_reducer'

const GetReducers = (CortexState, railsContext) => {
  return {
    session: tenantSwitcherReducer(CortexState),
    wizard: wizardReducer(CortexState),
    creator: contentTypeCreatorReducer(CortexState),
    railsContext: railsContextReducer(railsContext)
  }
};

export default GetReducers
