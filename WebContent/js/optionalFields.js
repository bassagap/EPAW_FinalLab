function showOptional() {
	document.getElementById('optional').style.display = 'block';
	document.getElementById('optionalButton').style.display = 'none';
} 
function addSport(){
	var otherSport = document.getElementById('otherSport').value;
	if(otherSport!="" && otherSport.length >= 3){
		var sportsList = document.getElementById('multiSel').innerHTML;
		document.getElementById('multiSel').innerHTML = sportsList+otherSport+", ";
	}
}