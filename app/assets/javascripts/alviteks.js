$(document).ready(function() {	
			// Массовое удаление и замена удаления стандартного	
		$('#selectAll').change(function(){
		  	if($('#alviteks_table :checked').length === 0){
			   $('#deleteAllitems_alvitek').css('display','none');	
		  	} else {
			  	$('#deleteAllitems_alvitek').css('display','inline-block');
		  	}
		});
		
		$('.alvitek_ids').on('click',function(){
			$('#selectAll').attr('checked', false);
		  	if($('#alviteks_table :checked').length === 0){
			   $('#deleteAllitems_alvitek').css('display','none');	
		  	} else {
			  	$('#deleteAllitems_alvitek').css('display','inline-block');
		  	}
		});

		$('#deleteAllitems_alvitek').click(function(){
			var array = [];
			$('#alviteks_table :checked').each(function() {
			array.push($(this).val());
			});

			var data = array;
			$.ajax({
			  type: "POST", 
			  url: "/alviteks/delete_selected.json",
			  data: { ids: data },
			  success: function(data, textStatus, jqXHR){
				  console.log(data);
					if(data.status === 'ok'){
						alert(data.message); 
					location.reload(); 
					}
			  },
			  error: function(jqXHR, textStatus, errorThrown){
				  console.log(jqXHR);
			  }
			})

		});
			
  //

});
