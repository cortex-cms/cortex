import setTenantSwitcherReducer from 'dashboard/reducers/tentant_switcher_reducer';
import setRailsContextReducer from 'dashboard/reducers/rails_context_reducer';

const GetReducers = (DashboardState, railsContext) => {
  return {
    session: setTenantSwitcherReducer(DashboardState),
    railsContext: setRailsContextReducer(railsContext)
  }
};

export default GetReducers
