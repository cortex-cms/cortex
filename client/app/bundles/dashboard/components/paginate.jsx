import React from 'react';

const CalculatePaginateProps = (currentResults, resultsOffset, paginateEvents) => {
  let { searchInformation } = currentResults;
  let totalResults = searchInformation ? parseInt(searchInformation.totalResults) : 0;

  return {
    show: (currentResults.allResults.length >= 3 || resultsOffset > 1),
    backArrow: resultsOffset !== 1,
    nextArrow: totalResults > (resultsOffset + 3),
    arrowEvents: paginateEvents
  }
}

class Paginate extends React.PureComponent {
  render() {
    const { show, backArrow, nextArrow, arrowEvents } = this.props;
    return (
      <nav className={show ? 'site-search__paginate' : 'hidden'}>
        <button id='prevArrow' className={backArrow ? 'site-search__paginate__arrow site-search__paginate__arrow--prev ' : 'hidden'} onClick={ arrowEvents('BACK') }>
        Previous
        </button>
        <button id='nextArrow' className={ nextArrow ? 'site-search__paginate__arrow site-search__paginate__arrow--next ' : 'hidden' } onClick={ arrowEvents('NEXT') }>
        Next
        </button>
      </nav>
    )
  }
}

export default Paginate;

export {
  CalculatePaginateProps
}
