import React from 'react';

class EnvironmentFlag extends React.PureComponent {
  render() {
    const { environment, environment_abbreviated } = this.props
    if (environment === 'production') return null
    const flagClass = `mdl-navigation__link nav__item environment environment--${environment}`
    return (
      <div className={flagClass}>
        <div className='environment__full'>
          {environment}
        </div>
        <div className='environment__abbreviated'>
          {environment_abbreviated}
        </div>
      </div>
    )
  }
}

export default EnvironmentFlag
