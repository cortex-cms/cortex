import React from 'react';
import ReactOnRails from 'react-on-rails';
import Layout from 'containers/layout';
import { Provider } from 'react-redux';
import DashboardStore from 'dashboard/store/store';

ReactOnRails.registerStore({
  DashboardStore
});

const DashboardApp = (props, railsContext) => {
  const store = ReactOnRails.getStore('DashboardStore');
  return (
    <Provider store={ store }>
      <Layout />
    </Provider>
  );
};

ReactOnRails.register({ DashboardApp });
