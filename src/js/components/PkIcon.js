import React, { Component } from "react";
import PropTypes from "prop-types";

class PkIcon extends Component {
  static propTypes = Object.assign({}, super.propTypes, {
    iconSet: PropTypes.string.isRequired,
    icon: PropTypes.string.isRequired,
  });
  render() {
    const baseClassName = "pk" + this.props.iconSet;
    const wrapperClassName = baseClassName + "-wrapper";
    const iconClassName = `${baseClassName} ${baseClassName}-${this.props.icon}`;
    return (
      <span className={wrapperClassName}>
        <i className={iconClassName} />
      </span>
    );
  }
}

export default PkIcon;
