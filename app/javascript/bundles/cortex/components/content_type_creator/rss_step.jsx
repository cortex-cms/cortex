import React from 'react'
import Table, {TableBody, TableFooter, TableCell, TableHead, TableRow} from 'material-ui/Table';
import {FormControl, FormHelperText} from 'material-ui/Form';
import brace from 'brace';
import AceEditor from 'react-ace';
import 'brace/mode/javascript';
import 'brace/theme/solarized_dark';

class RssStep extends React.PureComponent {
  constructor(props) {
    super(props)
  }
  ReactAceOptions = {
    enableBasicAutocompletion: false,
    enableLiveAutocompletion: false,
    enableSnippets: false,
    showLineNumbers: true,
    tabSize: 2
  }
  AceEditorProps = {
    $blockScrolling: true
  }
  getRSSdata = (data, fieldsLookup, contentType) => {
    if (Object.keys(data.channel).length > 0)
      return data;

    return {
      "channel": {
        "title": {
          "string": contentType.name
        },
        "link": {
          "string": "http://resources.careerbuilder.com"
        },
        "description": {
          "string": contentType.description
        },
        "language": {
          "string": "en-US"
        }
      },
      "item": Object.keys(fieldsLookup).reduce((rssItems, fieldId) => {
        rssItems[fieldsLookup[fieldId].name] = {
          field: fieldId
        };
        return rssItems
      }, {}),
      "content": {
        "encode": true
      }
    }
  }
  renderFieldInfo = (fieldsLookup) => Object.keys(fieldsLookup).map((fieldKey, index) => (
    <TableRow key={index}>
      <TableCell>{index + 1}</TableCell>
      <TableCell>
        <b>{fieldsLookup[fieldKey].name}</b>
      </TableCell>
      <TableCell>
        <b>{fieldKey}</b>
      </TableCell>
    </TableRow>
  ))
  saveAndNext = () => {
    this.props.handleNext(this.ace.editor.getValue())
  }
  render() {
    console.log('RssStep this.props', this.props)
    const {
      fieldsLookup,
      rss_builder,
      dispatch,
      step,
      handlePrev,
      contentType
    } = this.props
    return (
      <section className='step-container'>
        <Table>
          <TableHead>
            <TableCell>Field Name</TableCell>
            <TableCell>Field Id</TableCell>
          </TableHead>
          <TableBody>
            {this.renderFieldInfo(fieldsLookup)}
          </TableBody>
        </Table>
        <div className='mdl-grid'>
          <FormControl fullWidth className=''>
            <AceEditor mode='javascript' theme="solarized_dark" width='100%' highlightActiveLine={true} value={JSON.stringify(this.getRSSdata(rss_builder.data, fieldsLookup, contentType), null, 2)} name='data' ref={editor => this.ace = editor} setOptions={this.ReactAceOptions} editorProps={this.AceEditorProps}/>
          </FormControl>
        </div>
        <footer className='mdl-grid'>
          <div className='mdl-cell mdl-cell--12-col content-type-step--footer'>
            <a href='/' className='mdl-button mdl-js-button mdl-button--cb mdl-js-ripple-effect'>
              Cancel
            </a>
            <button onClick={handlePrev} className='mdl-button form-button--submission mdl-js-button mdl-button--raised mdl-button--alert mdl-js-ripple-effect'>
              Back
            </button>
            <button onClick={this.saveAndNext} disabled={step.valid === false} className='mdl-button form-button--submission mdl-js-button mdl-button--raised mdl-button--success mdl-js-ripple-effect'>
              Next
            </button>
          </div>
        </footer>
      </section>
    )
  }
}

export default RssStep
