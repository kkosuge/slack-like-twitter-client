import Tweet from '../model/tweet'

var $document = $(document);

class ImageModal {
  constructor() {
    this.template = Hogan.compile(this.template());
  }

  show(statusId) {
    let tweet = Tweet.find(statusId);
    if (!tweet) return;

    let imageUrl = tweet.entities.media[0].media_url_https;
    let url =  tweet.entities.media[0].url;
    let el = document.getElementById('modal');

    el.innerHTML = this.template.render({
      imageUrl: imageUrl,
      url: url
    });
  }

  template() {
    return `
      <div class="modal image-modal show">
        <div class="modal-close-btn">
          <i class="fa fa-times"></i>
        </div>
        <a onclick="Helper.openUrl('{{ url }}')">
          <img src="{{ imageUrl }}" />
        </a>
      </div>
    `
  }
}

var imageModal = new ImageModal();

$document.ready(function(){
  $document.on('click', '.media img', function() {
    let statusId = $(this).parents('.tweet').data('status-id');
    imageModal.show(statusId);
  });
  $document.on('click', '.modal-close-btn', function() {
    document.querySelector('.modal').remove();
  });
});
