import React from 'react';
import {FormControl, FormHelperText} from 'material-ui/Form';
import brace from 'brace';
import AceEditor from 'react-ace';
import 'brace/mode/javascript';
import 'brace/theme/solarized_dark';
import Button from 'material-ui/Button';
import Dialog, {
  DialogActions,
  DialogContent,
  DialogContentText,
  DialogTitle,
  withMobileDialog
} from 'material-ui/Dialog';


class DataDialog extends React.PureComponent {
  constructor(props) {
    super(props)
  }
  InputLabelProps = {
    shrink: true
  }
  ReactAceOptions = {
    enableBasicAutocompletion: false,
    enableLiveAutocompletion: false,
    enableSnippets: false,
    showLineNumbers: true,
    tabSize: 2,
  }
  AceEditorProps = {
    $blockScrolling: true
  }
  render() {
    const { open, name, handleRequestClose, data,  handleOnSave,  parentContext } = this.props
    return (
      <Dialog open={open} fullWidth onRequestClose={handleRequestClose}>
      <DialogTitle>{`${name} Data`}</DialogTitle>
      <DialogContent>
        <FormControl fullWidth className=''>
          <AceEditor
            mode='javascript'
            theme="solarized_dark"
            width='100%'
            highlightActiveLine={true}
            width='100%'
            ref={input => parentContext.data = input}
            value={JSON.stringify(data)}
            name='data'
            setOptions={this.ReactAceOptions}
            editorProps={this.AceEditorProps}/>
        </FormControl>
      </DialogContent>
      <DialogActions>
        <Button onClick={handleRequestClose} >
          close
        </Button>
        <Button onClick={handleOnSave} color="primary" raised autoFocus>
          Agree
        </Button>
      </DialogActions>
    </Dialog>
    )
  }
}

export default DataDialog;
