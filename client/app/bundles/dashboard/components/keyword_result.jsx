import React from 'react';

const KeywordResult = ( suggestion ) => {
  return (
    <a href={ suggestion.href } className="site-search__suggestion-list-item--keyword">
      { suggestion.text }
    </a>
  )
}
export default KeywordResult
