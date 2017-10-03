import { compose, createStore, applyMiddleware, combineReducers } from 'redux';
import logger from 'redux-logger'

import GetReducers from 'cortex/reducers'

const SomeTenentList = [
    {
        "id": "4539d5e0-44f7-48c5-ab23-8cb9979cbaea",
        "name": "Bogus",
        "description": "Example subtenant",
        "parent_id": "98545886-74d8-46bb-a5fe-c074f21658c3",
        "lft": 4,
        "rgt": 5,
        "depth": 1,
        "deleted_at": null,
        "active_at": null,
        "deactive_at": null,
        "owner_id": "4688177a-b983-483a-8571-9d2c6453be00",
        "created_at": "2017-10-03T16:59:42.819Z",
        "updated_at": "2017-10-03T16:59:42.824Z"
    },
    {
        "id": "98545886-74d8-46bb-a5fe-c074f21658c3",
        "name": "Example",
        "description": "ContentTypes to get started with",
        "parent_id": null,
        "lft": 3,
        "rgt": 6,
        "depth": 0,
        "deleted_at": null,
        "active_at": null,
        "deactive_at": null,
        "owner_id": "4688177a-b983-483a-8571-9d2c6453be00",
        "created_at": "2017-10-03T16:59:42.812Z",
        "updated_at": "2017-10-03T16:59:42.857Z"
    },
    {
        "id": "4b0bf1d3-e47e-4a8d-bf45-38eb3720c4db",
        "name": "System",
        "description": "Core tenant for news/etc",
        "parent_id": null,
        "lft": 1,
        "rgt": 2,
        "depth": 0,
        "deleted_at": null,
        "active_at": null,
        "deactive_at": null,
        "owner_id": "4688177a-b983-483a-8571-9d2c6453be00",
        "created_at": "2017-10-03T16:59:42.804Z",
        "updated_at": "2017-10-03T16:59:42.848Z"
    }
];

const SomeCurrentUser = {
    "id": "4688177a-b983-483a-8571-9d2c6453be00",
    "email": "admin@cortexcms.org",
    "firstname": "Cortex",
    "lastname": "Admin",
    "created_at": "2017-10-03T16:59:42.802Z",
    "updated_at": "2017-10-03T17:00:42.722Z",
    "fullname": "Cortex Admin"
}

export default (props, railsContext) => {

  const reducers = GetReducers(props, railsContext);
  const reducer = combineReducers(reducers);

  const composedStore = compose(
    applyMiddleware(logger),
  );

  return composedStore(createStore)(reducer);
};
