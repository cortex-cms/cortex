import React from 'react';
import BoldHighlight from 'site_search/components/bold_highlight'
import KeywordResult from 'site_search/components/keyword_result'
import {
  MOUSE_OVER_SUGGESTIONS,
  MOUSE_EXIT_SUGGESTIONS
} from 'site_search/constants'

const mapSuggestions = (suggestions, typed, setSuggestionClick) => {
  const SuggestionCallback = (suggestion, i) => {
    if (typeof suggestion === 'string') {
      return (
        <li key={i} onMouseDown={ setSuggestionClick(suggestion) }>
          { BoldHighlight(suggestion, typed) }
        </li>
      )
    }
    return <li key={i}>{ KeywordResult(suggestion) }</li>
  }
  return suggestions.filter(suggestion => typeof suggestion !== 'string').map(SuggestionCallback)
}

class SuggestionsBlock extends React.PureComponent {
  render() {
    let { searchFocus, typed, suggestions, dispatch, setSuggestionClick } = this.props;
    const suggestedList = mapSuggestions(suggestions, typed, setSuggestionClick)
    return (
      <ul
        onMouseEnter={ () => dispatch({ type: MOUSE_OVER_SUGGESTIONS }) }
        onMouseLeave={ () => dispatch({ type: MOUSE_EXIT_SUGGESTIONS }) }
        className={ 'site-search__suggestion-list ' + (searchFocus ? '' : 'hidden') }>
        { suggestedList }
      </ul>
    )
  }
}

export default SuggestionsBlock;
