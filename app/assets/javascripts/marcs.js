$(document).ready(function() {	
			// Массовое удаление и замена удаления стандартного	
		$('#selectAll').change(function(){
		  	if($('#marcs_table :checked').length === 0){
			   $('#deleteAllitems_marc').css('display','none');	
		  	} else {
			  	$('#deleteAllitems_marc').css('display','inline-block');
		  	}
		});
		
		$('.marc_ids').on('click',function(){
			$('#selectAll').attr('checked', false);
		  	if($('#marcs_table :checked').length === 0){
			   $('#deleteAllitems_marc').css('display','none');	
		  	} else {
			  	$('#deleteAllitems_marc').css('display','inline-block');
		  	}
		});

		$('#deleteAllitems_marc').click(function(){
			var array = [];
			$('#marcs_table :checked').each(function() {
			array.push($(this).val());
			});

			var data = array;
			$.ajax({
			  type: "POST", 
			  url: "/marcs/delete_selected.json",
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

