export default class ArticleHeader extends React.Component {
  render() {
    return(
     <div className="article-header">
       <h1>{ this.props.windowName }</h1>
       <div className="ui icon input">
         <input type="text" placeholder="Filter..." />
         <i className="search icon"></i>
      </div>
    </div>
    );
  }
}
