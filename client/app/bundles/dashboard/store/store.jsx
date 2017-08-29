import { compose, createStore, applyMiddleware, combineReducers } from 'redux';
import logger from 'redux-logger'

import GetReducers from 'dashboard/reducers'

export default (props, railsContext) => {

  const reducers = GetReducers(props, railsContext);
  const reducer = combineReducers(reducers);

  const composedStore = compose(
    applyMiddleware(logger),
  );

  return composedStore(createStore)(reducer);
};
