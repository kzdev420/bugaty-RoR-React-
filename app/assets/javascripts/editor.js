$(document).ready(function(){
  var minLength, maxLength
  var placeholder = $('#listing_name').attr('placeholder')
  if (placeholder === 'Enter seo title') {
    maxLength = 6000
  } else {
    maxLength = 1100
  }
  placeholder = $('.comment-form')
  if (placeholder.length > 0) {
    minLength = 1
  } else {
    minLength = 120
  }

  tinymce.PluginManager.add('maxchars', function (editor) {
    // set a default value for the maxChars peroperty
    editor.maxChars = editor.maxChars || maxLength;
    editor.minChars = editor.minChars || minLength;

    var label = null;

    function init () {
      // add a custom style which will be injected into the iframe
      editor.contentStyles.push(".maxchars {color: red !important;}");

      // try and add label to to the status bar
      var statusbar = editor.theme.panel && editor.theme.panel.find('#statusbar')[0];

      if (statusbar) {
        statusbar.insert({
          type: 'label',
          name: 'maxcharslabel',
          style: "color:red;",
          classes: 'wordcount' //this puts it on the right
        }, 0);

        // cache the newly created element
        label = statusbar.find('#maxcharslabel')
      }

      updateStyle(); // check if the initial content is valid
    };

    function updateMsg(showMin, showMax) {
      if (!label) {
        return;
      }
      var msg = '';
      if (showMin) {
        msg = editor.minChars + ' chars min';
      } else if (showMax) {
        msg = editor.maxChars + ' chars max';
      }

      label.text(msg);
    }

    function updateStyle () {
      var content = editor.getContent({
        format: 'text'
      });
      var $body = editor.$('.mce-content-body');

      //add class to content body based on content length
      if (content.length < editor.minChars) {
        $body.addClass("maxchars");
        updateMsg(true, false)
      } else if (content.length > editor.maxChars) {
        $body.addClass("maxchars");
        updateMsg(false, true);

      } else {
        $body.removeClass("maxchars");
        updateMsg(false, false);
      }

    };

    editor.on('init', init);
    editor.on("change keyUp", updateStyle);
  });
});
