import SegmentResults from 'site_search/utils/cse_script_helpers'
import axios from 'axios'
const url = require('url')

function cseQueryService(baseURI, apiKey, engineId) {
  const self = this;

  const creds = {
    key: apiKey,
    cx: engineId
  }

  const searchURI = (config) => axios.get(baseURI + url.format({ query: Object.assign({}, creds, config) }))

  const searchPromise = (query, resultsOffset, num = 3) => {
    return searchURI({
			q: query,
			start: resultsOffset,
			num: num
		}).then((response) => {
      let {data, status} = response
      if (status !== 200) return 'error'
      console.log('Google Search Results', data)

      let segmentedResults = SegmentResults(data.items)
      return Object.assign({}, data, {
        segmentedResults: segmentedResults,
        allResults: data.items || []
      })
    })
  }

  self.search = (inputValue, resultsOffset = 1) => {
    return {
      searchInfo: {
        query: inputValue,
        resultsOffset: resultsOffset
      },
      searchPromise: searchPromise(inputValue, resultsOffset)
    }
  }

}

const GoogleCSEservice = ({google_cse_api_key, google_cse_engine_id}) => {
  return new cseQueryService('https://www.googleapis.com/customsearch/v1', google_cse_api_key, google_cse_engine_id)
}

export default GoogleCSEservice;
