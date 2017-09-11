import setTenantSwitcherReducer from 'cortex/reducers/tentant_switcher_reducer';
import setRailsContextReducer from 'cortex/reducers/rails_context_reducer';

const GetReducers = (DashboardState, railsContext) => {
  return {
    session: setTenantSwitcherReducer(DashboardState),
    railsContext: setRailsContextReducer(railsContext)
  }
};

export default GetReducers
