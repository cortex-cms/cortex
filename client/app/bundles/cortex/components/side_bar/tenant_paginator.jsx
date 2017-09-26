import React from 'react';
import PropTypes from 'prop-types';
import { withStyles } from 'material-ui/styles';
import MobileStepper from 'material-ui/MobileStepper';
import Button from 'material-ui/Button';
import KeyboardArrowLeft from 'material-ui-icons/KeyboardArrowLeft';
import KeyboardArrowRight from 'material-ui-icons/KeyboardArrowRight';
import {
  PAGINATE_BACK,
  PAGINATE_NEXT
} from 'constants/tenant_switcher'

const styles = theme => ({
  root: {
    maxWidth: 400,
    flexGrow: 1,
  },
  header: {
    display: 'flex',
    alignItems: 'center',
    height: 50,
    paddingLeft: theme.spacing.unit * 4,
    marginBottom: 20,
    background: theme.palette.background.default,
  },
});

class TenantPaginator extends React.Component {
  constructor(props) {
    super(props);
  }

  handleNext = () => {
    this.props.dispatch({ type: PAGINATE_NEXT, payload: this.props.activeStep + 1});
  };

  handleBack = () => {
    this.props.dispatch({ type: PAGINATE_BACK, payload: this.props.activeStep - 1});
  };

  render() {
    const { classes, activeStep} = this.props;
    return (
      <div className={classes.root}>
        <MobileStepper
          type="text"
          steps={6}
          position="static"
          activeStep={activeStep}
          className={classes.mobileStepper}
          nextButton={
            <Button dense onClick={this.handleNext} disabled={activeStep === 5}>
              Next
              <KeyboardArrowRight />
            </Button>
          }
          backButton={
            <Button dense onClick={this.handleBack} disabled={activeStep === 0}>
              <KeyboardArrowLeft />
              Back
            </Button>
          }
        />
      </div>
    );
  }
}

export default withStyles(styles)(TenantPaginator);
