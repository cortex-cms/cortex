import React from 'react';
import ReactOnRails from 'react-on-rails';
import Layout from 'containers/layout';
import { Provider } from 'react-redux';
import CortexStore from 'cortex/store/store';

ReactOnRails.registerStore({
  CortexStore
});

const CortexApp = (props, railsContext) => {
  const store = ReactOnRails.getStore('CortexStore');
  return (
    <Provider store={ store }>
      <Layout />
    </Provider>
  );
};

ReactOnRails.register({ CortexApp });
