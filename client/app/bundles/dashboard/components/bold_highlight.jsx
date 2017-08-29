import React from 'react';

const matchHighlight = (matchText) => {
  return (text, i) => {
    if (matchText.test(text)) {
      return <strong key={i}>{ text }</strong>
    }
    return <span key={i}>{ text }</span>
  }
}
const BoldHighlight = ( suggestion, typed ) => {
  let regex = new RegExp('(' + typed + ')', 'gi')
  let matchText = new RegExp(typed, 'i')
  const highlightCallback = matchHighlight(matchText)
  let highlightedText = suggestion.split(regex).map(highlightCallback)
  return <span className='site-search__suggestion-list-item--highlight'>{ highlightedText }</span>
}

export default BoldHighlight
