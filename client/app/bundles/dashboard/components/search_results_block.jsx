import React from 'react';
import SearchingLoader from 'site_search/components/searching_loader';
import SearchErrorMessage from 'site_search/components/search_error_message';
import SearchNoResults from 'site_search/components/search_no_results';
import ResultsListSource from 'site_search/components/results_list_source';
import Paginate from 'site_search/components/paginate';
import { CLOSE_SEARCH_RESULTS } from 'site_search/constants'

const checkForNoResults = (searchResults) => {
  return !(searchResults['hiring'] || searchResults['resources'])
}

class SearchResultsBlock extends React.PureComponent {
  render() {
    let {
      PaginateProps,
      resultsDisplay,
      fetching,
      searchResults,
      dispatch,
      searchResultError
    } = this.props;

    const resultsNotFound = checkForNoResults(searchResults)
    const hiringResults = searchResults.hiring;
    return (
      <div id='searchResultsBlock' className={ resultsDisplay ? '' : 'hidden' } >
        <div className='site-search__results__background' onClick={ () => dispatch({ type: CLOSE_SEARCH_RESULTS }) }></div>
        <section className='site-search__results__container'>
          <h2 className="sr-only">Search Results</h2>
          <a className="site-search__results__close" onClick={ () => dispatch({ type: CLOSE_SEARCH_RESULTS }) }>
            <span className="sr-only">Close</span>
          </a>
          { fetching ? <SearchingLoader/> : null }
          <div id='siteSearchResultsWrapper' className={ fetching ? 'hidden' : 'site-search__results--outer-wrapper' }>

            <div className={ (searchResultError || resultsNotFound) ? 'hidden' : ' site-search__results--inner-wrapper ' }>
              {hiringResults ? (<ResultsListSource sourceName='Products' results={ searchResults['hiring'] || [] }/>) : ''}
              <ResultsListSource sourceName='Resources' results={ searchResults['resources'] || [] }/>
            </div>
            <div className={ (resultsNotFound && !searchResultError) ? '' : 'hidden' }>
              <SearchNoResults/>
            </div>
            <div className={ searchResultError ? '' : 'hidden' }>
              <SearchErrorMessage/>
            </div>
          </div>
          { !fetching ? <Paginate { ...PaginateProps }/> : null }
        </section>
      </div>
    )
  }
}
export default SearchResultsBlock
