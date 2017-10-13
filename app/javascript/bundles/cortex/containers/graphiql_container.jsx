import React from 'react';
import GraphiQL from 'graphiql';
import fetch from 'isomorphic-fetch';

import 'graphiql/graphiql.css'

class GraphiqlContainer extends React.PureComponent {
  graphQLFetcher = (graphQLParams) => {
    return fetch(window.location.origin + '/graphql', {
      method: 'post',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(graphQLParams),
    }).then(response => response.json());
  };

  render() {
    return (
      <GraphiQL fetcher={this.graphQLFetcher} />
    )
  }
}

export default GraphiqlContainer
