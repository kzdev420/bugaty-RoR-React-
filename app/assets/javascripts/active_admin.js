//= require active_admin/base
//= require tinymce
//= require tinymce-jquery

$(document).ready(function(){
  $('.tinymce').each(function(){
    $(this).tinymce({
      menubar: true,
      toolbar_items_size: 'small',
      fontsize_formats: '8pt 10pt 12pt 14pt 18pt 24pt 36pt 42pt 48pt 56pt 62pt',
      plugins: [
        'advlist autolink link image lists charmap print preview hr anchor pagebreak',
        'searchreplace wordcount visualblocks visualchars code fullscreen insertdatetime media nonbreaking',
        'save table contextmenu directionality template paste textcolor colorpicker uploadimage'
      ],
      toolbar: 'insertfile undo redo | styleselect | bold | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | link image uploadimage | print preview media fullpage | table',
      uploadimage_hint: $(this).attr('id'),
      target_list: false,
      rel_list: [{title: 'nofollow', value: 'nofollow'}],
      link_class_list: [{title: 'default', value: 'green-color'}]
    });
  });
});
