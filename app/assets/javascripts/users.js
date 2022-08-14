$(document).ready(function() {
//console.log('load users');
	// отображение блока со статусами при загрузке
		if( $('#user_role option:selected').val() === 'manager' ){
			$('.permission_data').css('display','block');
		} else {
			$('.permission_data').css('display','none');
		}

	// отображение блока со статусами при выборе пользователя manager
	$('#user_role').change(function(){
		var value = $( 'option:selected', this ).val();

		if( value === 'manager'){
			console.log(value);
			$('.permission_data').css('display','block');
		} else {
			$('.permission_data').css('display','none');
		}
	});


	//простановка статусов при загрузке страницы
/*
	var user_id = $('#user').val();
		$.ajax({
		  type: "POST",
		  url: "/permissions/user_permissions.json",
		  data: { user_id: user_id },
		  success: function(data, textStatus, jqXHR){
// 			  console.log(data);
			  for(var i = 0; i < data.length; i++) {
						//console.log(data[i].id);
						var permcl_id_json = data[i].permcl_id;
						var permcl_action_id_json = data[i].permcl_action_id;
						$('.action-id-'+permcl_id_json+'-'+permcl_action_id_json+' :checkbox').prop('checked', true);
  				}
				if(data.status === 'ok'){
					console.log(data.message);
				}
		  },
		  error: function(jqXHR, textStatus, errorThrown){
			  //console.log(jqXHR);
				console.log(textStatus);
				//console.log(errorThrown);
		  }
		})
*/

});
