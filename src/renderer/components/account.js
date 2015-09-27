export default class Account extends React.Component {
  render() {
    return(
      <div className="user">
        <div className="profile-image">
          <img src={ this.props.user.profile_image_url } />
        </div>
        <div className="screen-name"><i className="fa fa-at"></i>{ this.props.user.screen_name }</div>
      </div>
    );
  }
}
