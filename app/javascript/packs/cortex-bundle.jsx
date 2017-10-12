import React from 'react';
import ReactOnRails from 'react-on-rails';
import Layout from '../bundles/cortex/containers/layout';
import { Provider } from 'react-redux';
import CortexStore from '../bundles/cortex/store/store';

ReactOnRails.registerStore({
  CortexStore
});

const CortexApp = (props, railsContext) => {
  const store = ReactOnRails.getStore('CortexStore');
  return (
    <Provider store={ store }>
      <Layout temporary_render={ props.temporary_render } />
    </Provider>
  );
};

ReactOnRails.register({ CortexApp });
