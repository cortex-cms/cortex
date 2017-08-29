import React from 'react';

class SearchNoResults extends React.PureComponent {
  render() {
    return (
      <div className='site-search__message-container'>
        <p className='site-search__message__text'>Sorry, No Results Found</p>
      </div>
    )
  }
}
export default SearchNoResults
