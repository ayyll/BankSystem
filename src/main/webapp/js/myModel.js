function alertInfo(info,width) {
	
	$("#alertInfo").html("<strong>" + info + "</strong>");
	$('#myModal').modal().css({
		width : width,
		// 居中
		'margin-left' : function() {
			return -($(this).width() / 2);
		}
	});
}