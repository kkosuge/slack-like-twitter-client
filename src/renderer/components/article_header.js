import Timeline from '../timeline/timeline'

export default class ArticleHeader extends React.Component {
  refresh() {
    Timeline.currentWindow().update();
  }

  render() {
    return(
     <div className="article-header">
       <div className="refresh" onClick={ this.refresh }>
         <i className="fa fa-refresh"></i>
       </div>
       <h1>{ this.props.windowName }</h1>
       <div className="ui icon input">
         <input type="text" placeholder="Filter..." />
         <i className="search icon"></i>
      </div>
    </div>
    );
  }
}
