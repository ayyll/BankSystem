function check(val) {
	if (val < 10) {
		return ("0" + val);
	} else {
		return (val);
	}
}
function ShowTime() {
	var date = new Date();
	var year = date.getFullYear();
	var month = date.getMonth() + 1;
	var day = date.getDate();
	var hour = date.getHours();
	var minutes = date.getMinutes();
	var second = date.getSeconds();
	var timestr = year + "年" + month + "月" + day + "日  " + check(hour) + ":"
			+ check(minutes) + ":" + check(second);
	document.getElementById("stime").innerHTML = timestr;
	var timerID = setTimeout('ShowTime()', 1000);
}