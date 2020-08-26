var lastResFind=""; // последний удачный результат
var copy_page=""; // копия страницы в ихсодном виде
var olg_page=""
function TrimStr(s) {
	s = s.replace( /^\s+/g, '');
	return s.replace( /\s+$/g, '');
}
function FindOnPage(inputId) { //ищет текст на странице, в параметр передается ID поля для ввода
	var obj = window.document.getElementById(inputId);
	var textToFind;
	if (obj) {
		textToFind = TrimStr(obj.value);//обрезаем пробелы
	} else {
		alert("Введенная фраза не найдена");
		return;
	}
	if (textToFind == "") {
		alert("Вы ничего не ввели!");
		return;
	}
	if(document.body.innerHTML.indexOf(textToFind)=="-1")
		alert("Ничего не найдено!");
	if(copy_page.length>0)
		document.body.innerHTML=copy_page;
	else copy_page=document.body.innerHTML;
	document.body.innerHTML = document.body.innerHTML.replace(eval("/name="+lastResFind+"/gi")," ");//стираем предыдущие якори для скрола
	document.body.innerHTML = document.body.innerHTML.replace(eval("/"+textToFind+"/gi"),"<a name="+textToFind+" style='background:Yellow'>"+textToFind+"</a>"); //Заменяем найденный текст ссылками с якорем;
	lastResFind=textToFind; // сохраняем фразу для поиска, чтобы в дальнейшем по ней стереть все ссылки
	window.location = '#'+textToFind;//перемещаем скрол к последнему найденному совпадению
}
function funonload() {
	olg_page=document.body.innerHTML;
}
function ClearOnPage() {
	document.body.innerHTML=olg_page;
	document.getElementById("inform").value = "";
}
function view(n) {
    style = document.getElementById(n).style;
    style.display = (style.display == 'block') ? 'none' : 'block';
}
window.onload = funonload;
