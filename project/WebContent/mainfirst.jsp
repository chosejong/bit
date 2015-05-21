
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Insert title here</title>
<link rel="stylesheet" href="Main.css" type="text/css" />
</head>
<script type="text/javascript" src="js/jquery-1.9.1.min.js"></script>
<script>

	function loadList() {
		
		$('.group').remove();
		
		
		$.getJSON('./mainjsp.jsp', function(data){
			console.log(data);
			$.each(data, function(index,item) {
				var GrTag = '<div class="group">';
					GrTag += '<h3>'+item+'</h3>';
					GrTag += '</div>';
				
					$(GrTag).appendTo($('#group_set'));
			});
		});
	};


	function addgroup() {
		$('div#div_screen').show();
		$('div#box').show();

	}
	function submit() {

		var groupName = $('#group_name').val();
		var count = null;
		//가지고 있는 그룹의 숫자를 파악해야한다.
		count = $('.group').length;
		var data = {
			groupName : groupName,
			count : count
		};

		if (groupName == '') {
			alert('그룹명을 입력하세요.');
		} else {
			$.post('./groupadd.jsp', data, function() {
				$('div#div_screen').hide();
				$('div#box').hide();	
				loadList();
			});
		}
	}

	function cancel() {
		$('div#div_screen').hide();
		$('div#box').hide();
	}

	$(document).ready(function() {
		loadList();
	});
	
		
</script>
<body>
	<br>
	<br>
	<h3>Project group</h3>
	<br>

	<div class="cross">
		<div id="group_set">
		</div>
		<img id="addgroupimg" src="img/cross.jpg" width="300" height="120" onclick="addgroup()">
		<!-- <input type="image" src="img/cross1.jpg" width="300" height="120" onclick="addgroup();">
 -->

	</div>

	<div id="div_screen">
		<div id="box">
			<div class="group_select">
				<h3>Create Group</h3>
				<textarea id=group_name "name="form" cols="10" rows="2"
					placeholder="그룹명을 입력하세요" style="overflow: hidden; width: 250px;"></textarea>
			</div>

			<div id="effect">
				<button class="ct-btn white" onclick="submit();">ADD</button>
				<button class="ct-btn white" onclick="cancel();">CANCEL</button>
			</div>
		</div>
	</div>


</body>
</html>

