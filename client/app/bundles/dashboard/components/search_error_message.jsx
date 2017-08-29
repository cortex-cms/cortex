import React from 'react';

class SearchErrorMessage extends React.PureComponent {
  render() {
    return (
      <div className='site-search__message-container'>
        <p className='site-search__message__text'>Oops! Site Search is Currently Experiencing Some Difficulties</p>
      </div>
    )
  }
}
export default SearchErrorMessage
