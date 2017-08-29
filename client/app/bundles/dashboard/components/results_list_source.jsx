import React from 'react';

const articleThumb = (pagemap) => {
  if (!pagemap) return null;
  return pagemap.cse_thumbnail ? <img className='site-search__results__item-image' src={ pagemap.cse_thumbnail[0].src }/> : null;
}

const searchResultCallback = (result, index) => {
  let { pagemap } = result;
  let thumbImage = articleThumb(pagemap)
  return (
    <li key={ index } className="site-search__results__list-item">
      <a href={ result.link } className="site-search__results__item-link" target="_blank">
        <div className={thumbImage ? 'site-search__results__item-thumb ' : 'hidden '}>
          { thumbImage }
        </div>
        <div className="site-search__results__item-text">
          <h4 className="site-search__results__item-header">
            { result.title }
          </h4>
          <p className="site-search__results__item-description">{ result.snippet }</p>
        </div>
      </a>
    </li>
  )
}

class ResultsListSource extends React.PureComponent {
  render() {
    let { sourceName, results } = this.props;
    const resultsList = results.map(searchResultCallback)
    return (
      <section className={ (results.length ? 'site-search__results__wrapper ' : 'hidden ') + ('site-search__results__wrapper--' + sourceName.toLowerCase()) }>
        <h3 className="site-search__results__heading">{ sourceName }</h3>
        <ul className="site-search__results__list">{ resultsList }</ul>
      </section>
    )
  }
}

export default ResultsListSource;
