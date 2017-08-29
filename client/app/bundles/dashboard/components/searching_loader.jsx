import React from 'react';

class SearchingLoader extends React.PureComponent {
  render() {
    return (
      <div className='site-search__loader'>
        <p className='site-search__message__text'>Searching. . . .</p>
      </div>
    )
  }
}
export default SearchingLoader
