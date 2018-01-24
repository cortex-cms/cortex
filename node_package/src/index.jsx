import React from 'react';
import ReactOnRails from 'react-on-rails';
import {Provider} from 'react-redux';

import Layout from './containers/layout';
import CortexStore from './store/store';

ReactOnRails.registerStore({
  CortexStore
});

const CortexApp = (props, railsContext) => {
  const store = ReactOnRails.getStore('CortexStore');
  return (
    <Provider store={store}>
      <Layout temporary_render={props.temporary_render}/>
    </Provider>
  );
};

ReactOnRails.register({CortexApp});
