// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require autocomplete-rails
//= require best_in_place
//= require popper
//= require bootstrap
//= require bootstrap-sprockets
//= require cocoon
//= require jquery-fileupload/basic
//= require jquery-fileupload/vendor/tmpl
//= require jquery.ui.touch-punch
//= require bootstrap-editable
//= require bootstrap-editable-rails
//= require_tree .


$(document).ready(function(){
	$(".best_in_place").best_in_place();
	$("a[rel~=popover], .has-popover").popover();
	$("a[rel~=tooltip], .has-tooltip").tooltip();
	$('.dropdown-toggle').dropdown();

	$('[data-toggle="popover"]').popover({
		container: 'body'
	});

	$(".alert" ).fadeOut(5000);

	$('#selectAll').click(function(){
		if (this.checked){
			$(':checkbox').each(function(){
			  this.checked = true;
			});
		} else {
			$(':checkbox').each(function(){
			  this.checked = false;
			});
		}
	});

	//$.fn.editable.defaults.mode = 'inline';
	$('.editable').editable({ 
		mode: 'inline'
	});

  $('#deleteAll').click(function() {
    // event.preventDefault();
    var array = [];
    $('#items_table :checked').each(function() {
      array.push($(this).val());
    });

    $.ajax({
      type: "POST",
      url: $(this).attr('href') + '.json',
      data: {
        ids: array
      },
      beforeSend: function() {
        return confirm("Вы уверенны?");
      },
      success: function(data, textStatus, jqXHR) {
        if (data.status === 'ok') {
          //alert(data.message);
          location.reload();
        }
      },
      error: function(jqXHR, textStatus, errorThrown) {
        console.log(jqXHR);
      }
    })

  });


});
