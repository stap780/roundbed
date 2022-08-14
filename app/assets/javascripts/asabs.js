$(document).ready(function() {	
			// Массовое удаление и замена удаления стандартного	
		$('#selectAll').change(function(){
		  	if($('#asabs_table :checked').length === 0){
			   $('#deleteAllitems_asab').css('display','none');	
		  	} else {
			  	$('#deleteAllitems_asab').css('display','inline-block');
		  	}
		});
		
		$('.asab_ids').on('click',function(){
			$('#selectAll').attr('checked', false);
		  	if($('#asabs_table :checked').length === 0){
			   $('#deleteAllitems_asab').css('display','none');	
		  	} else {
			  	$('#deleteAllitems_asab').css('display','inline-block');
		  	}
		});

		$('#deleteAllitems_asab').click(function(){
			var array = [];
			$('#asabs_table :checked').each(function() {
			array.push($(this).val());
			});

			var data = array;
			$.ajax({
			  type: "POST", 
			  url: "/asabs/delete_selected.json",
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
