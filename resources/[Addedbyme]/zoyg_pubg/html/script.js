
var Config;
var currentWeapon;
var currentItem;



function CloseMenu() {
	$("#pubgmenu").hide();
	$("#statisticmenu").hide();
	$("#pubgstoremenu").hide();
	$("#pubgmenubut").hide();
	$('#settingsmenu').hide();
    $.post('https://zoyg_pubg/ClosePUBGMenu');
}

function joinGame() {
    $.post('https://zoyg_pubg/joinmatch');
}



function main() {
	$("#mystatsButton").hide();
	$("#topwinnersButton").hide();
	$("#topkillersButton").hide();
	$("#weaponButton").hide();
	$('#settingsmenu').hide();
	$("#itemButton").hide();
	$("#pubgmenu").show();
	$("#pubgstoremenu").hide();
	$("#statisticmenu").hide();
}


function store() {
	$("#mystatsButton").hide();
	$("#topwinnersButton").hide();
	$("#topkillersButton").hide();
	$("#weaponButton").show();
	$("#itemButton").show();
	$("#pubgstoremenu").show();
	$("#pubgmenu").hide();
	$('#settingsmenu').hide();
	$("#statisticmenu").hide();

	weapons();
}

function weapons() {
	
	$('#previewstore').hide();
	$("#productstore").show();
	showWeapons()
}

function items() {
	$('#previewstore').hide();
	$("#productstore").show();
	showItems()
}


function statistic() {
	$("#weaponButton").hide();
	$("#itemButton").hide();
	$("#statisticmenu").show();
	$('#settingsmenu').hide();
	$('#pubgmenu').hide();
	$("#pubgstoremenu").hide();
	$("#mystatsButton").show();
	$("#topwinnersButton").show();
	$("#topkillersButton").show();
	mystats()
}

function topwinners() {
	$('.statisticmenu').html(`<div style="position: absolute; top: 46%; left: 52%;"><div class="lds-facebook"><div></div><div></div><div></div></div></div>`);
	$.post('https://zoyg_pubg/showtopwinners');
}

function topkillers() {
	$('.statisticmenu').html(`<div style="position: absolute; top: 46%; left: 52%;"><div class="lds-facebook"><div></div><div></div><div></div></div></div>`);
	$.post('https://zoyg_pubg/showtopkillers');
}

function mystats() {
	$('.statisticmenu').html(`<div style="position: absolute; top: 46%; left: 52%;"><div class="lds-facebook"><div></div><div></div><div></div></div></div>`);
	$.post('https://zoyg_pubg/showmystats');
}


function settings() {
	$("#weaponButton").hide();
	$("#itemButton").hide();
	$("#mystatsButton").hide();
	$("#topwinnersButton").hide();
	$("#topkillersButton").hide();
	$("#statisticmenu").hide();
	$('#settingsmenu').show();
	$('#pubgmenu').hide();
	$("#pubgstoremenu").hide();
	$('.cmp').html(`` + Config.MaxPlayers + ``);
	$('.cmpts').html(`` + Config.MinPlayersToStartPUBGGame + ``);
	$('.cttsg').html(`` + Config.MaxGameTime + ``);
	$('.csv').html(`` + Config.spawnVehicles + ``);
	$('.bppw').html(`` + Config.BPForWinner + ``);
	$('.bppk').html(`` + Config.BPPerKill + ``);
	$('.rppw').html(`` + Config.RankPointsFromWins + ``);
	$('.rppk').html(`` + Config.RankPointsFromKills + ``);
}

function exitMap() {
    $.post('https://zoyg_pubg/exitmap');
}

$(document).keyup(function(e) {
     if (e.key === "Escape") {
        CloseMenu()
    }
});

$(function(){
	
	function LoadMenu(pname,bp,maxplayers,playerson,statuss)
    {
		$("#pubgstoremenu").hide();
		$("#statisticmenu").hide();
		$('#settingsmenu').hide();
		$("#weaponButton").hide();
		$("#itemButton").hide();
		$("#mystatsButton").hide();
		$("#topwinnersButton").hide();
		$("#topkillersButton").hide();
        $("#pubgmenu").fadeIn();
        $("#pubgmenubut").fadeIn();
		
		$('.panem').html(`<span>` + pname + `</span>`);
		$('.bp').html(`<span>` + bp + `</span>`);
		$('#maxplayers').html(`<span>` + Config.MaxPlayers + `</span>`);
		$('#playersin').html(`<span>` + playerson + `</span>`);
		$('#status1').html(`<span>` + statuss + `</span>`);

    }
	
	 $("#close").click(function() {
        CloseMenu()
    });



	
	
	
    window.addEventListener('message', function(event) {
		if(event.data.type == "showmenu") {
			Config = event.data.Configg;
            LoadMenu(event.data.npame,event.data.bp,event.data.maxplayers,event.data.playerson,event.data.statuss)
        } else if (event.data.type == "updatetimer") {
			startTimer()
        } else if (event.data.type == "showstarttimer") {
			showstarttimer()
        } else if(event.data.type == "show_game_ui") {
			$("#pubgstoremenu").hide();
			$("#pubgmenu").hide();
			$("#pubgmenubut").hide();
			$("#statisticmenu").hide();
			$('#settingsmenu').hide();
			$("#killedby").hide();
			$("#stl").hide();
            $("#pubggamemenu").show();
			$('#pregamestats').html(`<span>In Queue...</span>`);
        } else if (event.data.type == "updatejumptimer") {
            $('#pregamestats').html(`<span>In Plane: Jump !</span>`);
			_stopTimer = false;
			var fiveMinutes = event.data.timercount,
				display = $('#gametimer');
			startjumpTimer((fiveMinutes - 2), display);
			setTimeout(function(){ _stopTimer = true; $('#pregamestats').html(``); $('#pkills').html(`<span>0</span>`); $('#aliaveplayers').html(`<span>` + event.data.players + `</span>`); $("#gamestatssss").show();}, (fiveMinutes * 1000))
			
			
			resettimer();
			
        } else if (event.data.type == "updatealiveplayers") {
			$('#aliaveplayers').html(`` + event.data.players + ``);
        } else if (event.data.type == "updateplayerkills") {
			$('#pkills').html(`` + event.data.kills + ``);
        } else if (event.data.type == "closeeverything") {
			$("#pubgstoremenu").hide();
			$('#settingsmenu').hide();
			$("#pubgmenu").hide();
			$("#pubgmenubut").hide();
			$("#statisticmenu").hide();
            $("#pubggamemenu").hide();
			$("#gamestatssss").hide();
			$("#stl").hide();
			$("#killedby").fadeOut();
			$("#losermenu").fadeOut();
			pausetimer()
			resettimer()
        } else if(event.data.type == "game_start") {
            startPUBGGame();
        } else if(event.data.type == "startexitmaptimer") {
			_stopTimer2 = false;
			$("#stl").show();
			var fiveMinutes = 15,
			display = $('#sectolobby');
			startEndingTimer(fiveMinutes, display);
			setTimeout(function(){ _stopTimer2 = true; $.post('https://zoyg_pubg/exitmapcheck'); }, (fiveMinutes * 1000))
        } else if (event.data.type == "endgameloser") {
            $("#pubgmenu").hide();
			$("#pubgstoremenu").hide();
			$('#settingsmenu').hide();
			$("#statisticmenu").hide();
			$("#pubgmenubut").hide();
            $("#pubggamemenu").hide();
			$("#gamestatssss").hide();
			pausetimer()
			resettimer()

			$('#playernamelose').html(`` + event.data.name + ``);
			$('#winnertick').html(`` + event.data.reasonn + ``);
			$('#rank').html(`#` + event.data.placementt + ``);
			$('#rank2').html(`#` + event.data.placementt + ``);
			$('#killsss').html(`` + event.data.kill + ``);
			$('#rewardedbp').html(`` + event.data.rewardd + ``);
			$('#pointsfromplacements').html(`` + event.data.placebp + ``);
			$('#pointsfromkills').html(`` + event.data.killbp + ``);
			$('#killer').html(`` + event.data.dolofon + ``);
			$('#maxedplayers').html(`` + event.data.plfromstart + ``);
			$("#losermenu").fadeIn();
			$("#killedby").fadeIn();
        } else if(event.data.type == "endgamewinner") {
			$("#pubgmenu").hide();
			$("#pubgstoremenu").hide();
			$('#settingsmenu').hide();
			$("#pubgmenubut").hide();
			$("#statisticmenu").hide();
            $("#pubggamemenu").hide();
			$("#gamestatssss").hide();
			$("#killedby").hide();
			$('#killer').html(``);
			pausetimer()
			resettimer()

			$('#playernamelose').html(`` + event.data.name + ``);
			$('#winnertick').html(`WINNER WINNER CHICKEN DINNER`);
			$('#rank').html(`#` + event.data.placementt + ``);
			$('#rank2').html(`#` + event.data.placementt + ``);
			$('#killsss').html(`` + event.data.kill + ``);
			$('#rewardedbp').html(`` + event.data.rewardd + ``);
			$('#pointsfromplacements').html(`` + event.data.placebp + ``);
			$('#pointsfromkills').html(`` + event.data.killbp + ``);
			$('#maxedplayers').html(`` + event.data.plfromstart + ``);
			$("#losermenu").fadeIn();
        } else if(event.data.type == "updatebppoints") {
			
			$('.bp').html(`<span>` + event.data.bpoints + `</span>`);
			
        } else if(event.data.type == "mystatsappdata") {
			if(event.data.rank == "Unranked") {
				$('.statisticmenu').html(`<div style="position:absolute; top:34%; left:40%; height: 350px; width:200px; background: rgba(50,50,50,0.7); border: 2px solid rgba(150,150,150,0.7); ">
					<span style="font-family: 'Teko'; font-size: 50px; text-align: center; color: white; text-shadow: 0px 0px 10px white; "><b>Rank</b></span>
					<p><img src="./images/Rank-` + event.data.rank + `.png" /></p>
					<span style="font-family: 'Teko'; font-size: 40px; text-align: center; color: rgb(235, 176, 20); text-shadow: 0px 0px 10px rgb(235, 176, 20); "><b>` + event.data.rank + `</b></span><br/>
					<span style="font-family: 'Teko'; font-size: 20px; text-align: center; color: white; text-shadow: 0px 0px 10px white; ">` + event.data.games + `/10 games played</span><br/>

						<img style="position:absolute; left: 1%; top: 77%; width: 40px; height: 40px; " src="./images/Rank-` + event.data.rank + `.png"/>
						<div style=" text-align: left;  width: 60%; height:15px; background:rgba(150,150,150,0.7);"><div style="text-align: left;width: ` + event.data.barwidth + `%; height:15px; background:rgb(235, 176, 20); box-shadow: 0px 0px 10px rgb(235, 176, 20);"></div></div>
						<img style="position:absolute; top: 77%; left: 79%;width: 40px; height: 40px;" src="./images/Rank-` + event.data.nextrank + `.png"/>

				</div>
				<div style="position:absolute; top:34%; left:52.5%; height: 100px; width:400px; background: rgba(50,50,50,0.7); border: 2px solid rgba(150,150,150,0.7); ">
					<div style="font-family: 'Karantina'; font-size: 50px; color: white; text-shadow: 0px 0px 10px white; ">Wins</div>
					<div style="font-family: 'Teko'; font-size: 40px; color: rgb(235, 176, 20); text-shadow: 0px 0px 10px rgb(235, 176, 20); ">` + event.data.wins + `</div>
				</div>
				<div style="position:absolute; top:45.5%; left:52.5%; height: 100px; width:400px; background: rgba(50,50,50,0.7); border: 2px solid rgba(150,150,150,0.7); ">
					<div style="font-family: 'Karantina'; font-size: 50px; color: white; text-shadow: 0px 0px 10px white; ">Kills</div>
					<div style="font-family: 'Teko'; font-size: 40px; color: rgb(235, 176, 20); text-shadow: 0px 0px 10px rgb(235, 176, 20); ">` + event.data.kills + `</div>
				</div>
				<div style="position:absolute; top:57%; left:52.5%; height: 100px; width:400px; background: rgba(50,50,50,0.7); border: 2px solid rgba(150,150,150,0.7); ">
					<div style="font-family: 'Karantina'; font-size: 50px; color: white; text-shadow: 0px 0px 10px white; ">Games Played</div>
					<div style="font-family: 'Teko'; font-size: 40px; color: rgb(235, 176, 20); text-shadow: 0px 0px 10px rgb(235, 176, 20); ">` + event.data.games + `</div>
				</div>`);
			} else if(event.data.rank == "Grandmaster") {
				$('.statisticmenu').html(`<div style="position:absolute; top:34%; left:40%; height: 350px; width:200px; background: rgba(50,50,50,0.7); border: 2px solid rgba(150,150,150,0.7); ">
					<span style="font-family: 'Teko'; font-size: 50px; text-align: center; color: white; text-shadow: 0px 0px 10px white; "><b>Rank</b></span>
					<p><img src="./images/Rank-` + event.data.rank + `.png" /></p>
					<span style="font-family: 'Teko'; font-size: 40px; text-align: center; color: rgb(235, 176, 20); text-shadow: 0px 0px 10px rgb(235, 176, 20); "><b>` + event.data.rank + `</b></span><br/>
					<span style="font-family: 'Teko'; font-size: 20px; text-align: center; color: white; text-shadow: 0px 0px 10px white; ">` + event.data.rankpoints + ` Rank Points</span><br/>

						<div style=" text-align: left;  width: 60%; height:15px; background:rgba(150,150,150,0.7);"><div style="text-align: left;width: ` + event.data.barwidth + `%; height:15px; background:rgb(235, 176, 20); box-shadow: 0px 0px 10px rgb(235, 176, 20);"></div></div>
						<img style="position:absolute; top: 77%; left: 79%;width: 40px; height: 40px;" src="./images/Rank-` + event.data.rank + `.png"/>

				</div>
				<div style="position:absolute; top:34%; left:52.5%; height: 100px; width:400px; background: rgba(50,50,50,0.7); border: 2px solid rgba(150,150,150,0.7); ">
					<div style="font-family: 'Karantina'; font-size: 50px; color: white; text-shadow: 0px 0px 10px white; ">Wins</div>
					<div style="font-family: 'Teko'; font-size: 40px; color: rgb(235, 176, 20); text-shadow: 0px 0px 10px rgb(235, 176, 20); ">` + event.data.wins + `</div>
				</div>
				<div style="position:absolute; top:45.5%; left:52.5%; height: 100px; width:400px; background: rgba(50,50,50,0.7); border: 2px solid rgba(150,150,150,0.7); ">
					<div style="font-family: 'Karantina'; font-size: 50px; color: white; text-shadow: 0px 0px 10px white; ">Kills</div>
					<div style="font-family: 'Teko'; font-size: 40px; color: rgb(235, 176, 20); text-shadow: 0px 0px 10px rgb(235, 176, 20); ">` + event.data.kills + `</div>
				</div>
				<div style="position:absolute; top:57%; left:52.5%; height: 100px; width:400px; background: rgba(50,50,50,0.7); border: 2px solid rgba(150,150,150,0.7); ">
					<div style="font-family: 'Karantina'; font-size: 50px; color: white; text-shadow: 0px 0px 10px white; ">Games Played</div>
					<div style="font-family: 'Teko'; font-size: 40px; color: rgb(235, 176, 20); text-shadow: 0px 0px 10px rgb(235, 176, 20); ">` + event.data.games + `</div>
				</div>`);
			} else {
				$('.statisticmenu').html(`<div style="position:absolute; top:34%; left:40%; height: 350px; width:200px; background: rgba(50,50,50,0.7); border: 2px solid rgba(150,150,150,0.7); ">
					<span style="font-family: 'Teko'; font-size: 50px; text-align: center; color: white; text-shadow: 0px 0px 10px white; "><b>Rank</b></span>
					<p><img src="./images/Rank-` + event.data.rank + `.png" /></p>
					<span style="font-family: 'Teko'; font-size: 40px; text-align: center; color: rgb(235, 176, 20); text-shadow: 0px 0px 10px rgb(235, 176, 20); "><b>` + event.data.rank + `</b></span><br/>
					<span style="font-family: 'Teko'; font-size: 20px; text-align: center; color: white; text-shadow: 0px 0px 10px white; ">` + event.data.rankpoints + `/1000 Rank Points</span><br/>

						<img style="position:absolute; left: 1%; top: 77%; width: 40px; height: 40px; " src="./images/Rank-` + event.data.rank + `.png"/>
						<div style=" text-align: left;  width: 60%; height:15px; background:rgba(150,150,150,0.7);"><div style="text-align: left; width: ` + event.data.barwidth + `% ; height:15px; background:rgb(235, 176, 20); box-shadow: 0px 0px 10px rgb(235, 176, 20);"></div></div>
						<img style="position:absolute; top: 77%; left: 79%;width: 40px; height: 40px;" src="./images/Rank-` + event.data.nextrank + `.png"/>

				</div>
				<div style="position:absolute; top:34%; left:52.5%; height: 100px; width:400px; background: rgba(50,50,50,0.7); border: 2px solid rgba(150,150,150,0.7); ">
					<div style="font-family: 'Karantina'; font-size: 50px; color: white; text-shadow: 0px 0px 10px white; ">Wins</div>
					<div style="font-family: 'Teko'; font-size: 40px; color: rgb(235, 176, 20); text-shadow: 0px 0px 10px rgb(235, 176, 20); ">` + event.data.wins + `</div>
				</div>
				<div style="position:absolute; top:45.5%; left:52.5%; height: 100px; width:400px; background: rgba(50,50,50,0.7); border: 2px solid rgba(150,150,150,0.7); ">
					<div style="font-family: 'Karantina'; font-size: 50px; color: white; text-shadow: 0px 0px 10px white; ">Kills</div>
					<div style="font-family: 'Teko'; font-size: 40px; color: rgb(235, 176, 20); text-shadow: 0px 0px 10px rgb(235, 176, 20); ">` + event.data.kills + `</div>
				</div>
				<div style="position:absolute; top:57%; left:52.5%; height: 100px; width:400px; background: rgba(50,50,50,0.7); border: 2px solid rgba(150,150,150,0.7); ">
					<div style="font-family: 'Karantina'; font-size: 50px; color: white; text-shadow: 0px 0px 10px white; ">Games Played</div>
					<div style="font-family: 'Teko'; font-size: 40px; color: rgb(235, 176, 20); text-shadow: 0px 0px 10px rgb(235, 176, 20); ">` + event.data.games + `</div>
				</div>`);
				
			}
        } else if(event.data.type == "showtop10winners") {

				$('.statisticmenu').html(`<table id="topwinteble">
					<tr style="border: 1px solid white;">
						<th style="width: 8%; font-size: 22px; color: rgb(235, 176, 20);text-shadow: 0px 0px 10px rgb(235, 176, 20);"><b>TOP</b></th>
						<th  style="width: 67%;font-size: 22px;color: rgb(235, 176, 20);text-shadow: 0px 0px 10px rgb(235, 176, 20);"><b>NAME</b></th>
						<th  style="width: 25%;font-size: 22px;color: rgb(235, 176, 20);text-shadow: 0px 0px 10px rgb(235, 176, 20);"><b>WINS</b></th>
					  </tr>
				</table>
			</div>`);
			
			
			var table1 = event.data.topwin;

			let tableBody = this.document.getElementById("topwinteble");
			var i;
			var substract = 0;
			var counter = 4;


			table1.sort(function(a, b) {
                if (a.wins == b.wins){
                    return a.wins == b.wins
                }
            });

			for (i = 0; i < table1.length; i++) {
				if (table1[i] != undefined){
					if (table1[i].wins >= 0){

						if ((i+1-substract) == 1){
							$("#topwinteble").append(`<tr><td><img src="./images/first.png"></img></td><td>` + event.data.topwin[i].name + `</td><td>` + event.data.topwin[i].wins + `</td></tr>`);
						} else if ((i+1-substract) == 2){
							$("#topwinteble").append(`<tr><td><img src="./images/second.png"></img></td><td>` + event.data.topwin[i].name + `</td><td>` + event.data.topwin[i].wins + `</td></tr>`);
						}else if ((i+1-substract) == 3){
							$("#topwinteble").append(`<tr><td><img src="./images/third.png"></img></td><td>` + event.data.topwin[i].name + `</td><td>` + event.data.topwin[i].wins + `</td></tr>`);
						}else{
							$("#topwinteble").append(`<tr><td>`+counter+`</td><td>` + event.data.topwin[i].name + `</td><td>` + event.data.topwin[i].wins + `</td></tr>`);
							counter++;
						}
						
						if ((i+1-substract) == 10){
							break;
						} 
					
						
					}else{
						substract++;
					}					
				}
			}
			

			
        } else if(event.data.type == "showtop10killers") {

				$('.statisticmenu').html(`<table id="topkillteble">
					<tr style="border: 1px solid white;">
						<th style="width: 8%; font-size: 22px; color: rgb(235, 176, 20);text-shadow: 0px 0px 10px rgb(235, 176, 20);"><b>TOP</b></th>
						<th  style="width: 67%;font-size: 22px;color: rgb(235, 176, 20);text-shadow: 0px 0px 10px rgb(235, 176, 20);"><b>NAME</b></th>
						<th  style="width: 25%;font-size: 22px;color: rgb(235, 176, 20);text-shadow: 0px 0px 10px rgb(235, 176, 20);"><b>KILLS</b></th>
					  </tr>
				</table>
			</div>`);
			
			
			var table1 = event.data.topkill;

			let tableBody = this.document.getElementById("topkillteble");
			var i;
			var substract = 0;
			var counter = 4;


			table1.sort(function(a, b) {
                if (a.kills == b.kills){
                    return a.kills == b.kills
                }
            });

			for (i = 0; i < table1.length; i++) {
				if (table1[i] != undefined){
					if (table1[i].kills >= 0){

						if ((i+1-substract) == 1){
							$("#topkillteble").append(`<tr><td><img src="./images/first.png"></img></td><td>` + event.data.topkill[i].name + `</td><td>` + event.data.topkill[i].kills + `</td></tr>`);
						} else if ((i+1-substract) == 2){
							$("#topkillteble").append(`<tr><td><img src="./images/second.png"></img></td><td>` + event.data.topkill[i].name + `</td><td>` + event.data.topkill[i].kills + `</td></tr>`);
						}else if ((i+1-substract) == 3){
							$("#topkillteble").append(`<tr><td><img src="./images/third.png"></img></td><td>` + event.data.topkill[i].name + `</td><td>` + event.data.topkill[i].kills + `</td></tr>`);
						}else{
							$("#topkillteble").append(`<tr><td>`+counter+`</td><td>` + event.data.topkill[i].name + `</td><td>` + event.data.topkill[i].kills + `</td></tr>`);
							counter++;
						}
						
						if ((i+1-substract) == 10){
							break;
						} 
					
						
					}else{
						substract++;
					}					
				}
			}
			

			
        } else if(event.data.type == "previewtheweapon") {
			
			setTimeout(() => { 
			$('.previewstore').html("");
			$(".previewstore").append(`<center><img style="min-width: 300px; max-width: 301px;height:auto;" src="nui://esx_inventoryhud/html/img/items/` + currentWeapon + `.png"/></center>`);

			$(".previewstore").append(`
			<div class="bp-pointstobuy">
				<img class="bp-pointstobuy-img" src="./images/bpcoin.png"/>
				<div class="bp-pointstobuy-name">` + Config.Weapons[currentWeapon].cost + ` <span style="color: yellow;">BP</span></div>
			</div>
			<div style="position: absolute;left:440px; bottom: 15px;cursor: pointer;">
				<button onclick="weaponBuy()" class="productplus-preview-buy">BUY WEAPON</button>
			</div>
			<div style="box-shadow: 0px 0px 10px white;text-align: left; height: 300px; width:220px;position: absolute; left:77%; border: 1px solid rgb(100,100,100); bottom: 24%; background:rgba(10,10,10,0.7);">
				<span style="margin-left: 10px;text-shadow: 0px 0px 10px white;text-align: left; font-family: 'Teko'; font-size: 30px; "><b><i>Damage: ` + event.data.damage + `</i></b></span>
				<div style="margin: auto;height: 15px;text-align: left;width: 90%;transform: skewX(-20deg); background: rgba(100,100,100,0.6);"><div style=" width: ` + event.data.damage + `%; text-align: left; background: white; box-shadow: 0px 0px 10px white; height: 100%; "></div></div>
				<span style="margin-left: 10px;text-shadow: 0px 0px 10px white;text-align: left; font-family: 'Teko'; font-size: 30px; "><b><i>Speed: ` + event.data.speed + `</i></b></span>
				<div style="margin: auto;height: 15px;text-align: left;width: 90%;transform: skewX(-20deg); background: rgba(100,100,100,0.6);"><div style=" width: ` + event.data.speed + `%; text-align: left; background: white; box-shadow: 0px 0px 10px white; height: 100%; "></div></div>
				<span style="margin-left: 10px;text-shadow: 0px 0px 10px white;text-align: left; font-family: 'Teko'; font-size: 30px; "><b><i>Capacity: ` + event.data.capacity + `</i></b></span>
				<div style="margin: auto;height: 15px;text-align: left;width: 90%;transform: skewX(-20deg); background: rgba(100,100,100,0.6);"><div style=" width: ` + event.data.capacity + `%; text-align: left; background: white; box-shadow: 0px 0px 10px white; height: 100%; "></div></div>
				<span style="margin-left: 10px;text-shadow: 0px 0px 10px white;text-align: left; font-family: 'Teko'; font-size: 30px; "><b><i>Accuracy: ` + event.data.accuracy + `</i></b></span>
				<div style="margin: auto;height: 15px;text-align: left;width: 90%;transform: skewX(-20deg); background: rgba(100,100,100,0.6);"><div style=" width: ` + event.data.accuracy + `%; text-align: left; background: white; box-shadow: 0px 0px 10px white; height: 100%; "></div></div>
				<span style="margin-left: 10px;text-shadow: 0px 0px 10px white;text-align: left; font-family: 'Teko'; font-size: 30px; "><b><i>Range: ` + event.data.range + `</i></b></span>
				<div style="margin: auto;height: 15px;text-align: left;width: 90%;transform: skewX(-20deg); background: rgba(100,100,100,0.6);"><div style=" width: ` + event.data.range + `%; text-align: left; background: white; box-shadow: 0px 0px 10px white; height: 100%; "></div></div>
			
			</div>`);
			}, 500);
		

		
		}
		
    });
});

function showWeapons(){
	$('#previewstore').fadeOut()
	$('#productstore').fadeIn();
	$('.productstore').html(`<div style="position: absolute; top: 41%; left: 47%;"><div class="lds-facebook"><div></div><div></div><div></div></div></div>`);
	setTimeout(() => { 
	$('.productstore').html("");
	Object.keys(Config.Weapons).forEach(function(key,index) {

		$(".productstore").append(`
			<div class="productplus">
				<div class="productplus-img"><img style="max-height: 75px;max-width: 150px;" src="nui://esx_inventoryhud/html/img/items/` + key + `.png"/></div><br/>
				<span class="productplus-name">` + Config.Weapons[key].label + `</span><br/>
				<button class="productplus-preview" onclick="previewWeapon('` + key + `')">PREVIEW</button>
			</div>`);
	});
	}, 500);
}


function showItems() {
	$('#previewstore').fadeOut()
	$('#productstore').fadeIn();
	$('.productstore').html(`<div style="position: absolute; top: 41%; left: 47%;"><div class="lds-facebook"><div></div><div></div><div></div></div></div>`);
	setTimeout(() => { 
	$('.productstore').html("");
	Object.keys(Config.Items).forEach(function(key,index) {

		$(".productstore").append(`
			<div class="productplus">
				<div class="productplus-img"><img style="max-height: 75px;max-width: 150px;" src="nui://esx_inventoryhud/html/img/items/` + key + `.png"/></div><br/>
				<span class="productplus-name">` + Config.Items[key].label + `</span><br/>
				<button class="productplus-preview" onclick="previewItem('` + key + `')">PREVIEW</button>
			</div>`);
	});
	}, 500);
}

function previewItem(item) {
	$('#productstore').fadeOut();
	$('#previewstore').fadeIn();
	currentItem = item;
	$('.previewstore').html(`<div style="position: absolute; top: 41%; left: 47%;"><div class="lds-facebook"><div></div><div></div><div></div></div></div>`);
	setTimeout(() => { 
	$('.previewstore').html("");
	$(".previewstore").append(`<center><img style="width: 200px; height:auto;" src="nui://esx_inventoryhud/html/img/items/` + item + `.png"/></center>`);

	$(".previewstore").append(`
	<div class="bp-pointstobuy">
		<img class="bp-pointstobuy-img" src="./images/bpcoin.png"/>
		<div class="bp-pointstobuy-name">` + Config.Items[item].cost + ` <span style="color: yellow;">BP</span></div>
	</div>
	<div style="position: absolute;left:440px; bottom: 15px;cursor: pointer;">
		<button onclick="itemBuy()" class="productplus-preview-buy">BUY ITEM</button>
	</div>`);
	}, 500);
	
	
}



function previewWeapon(weapon){
	$.post('https://zoyg_pubg/weaponstats', JSON.stringify({ weaponName : weapon }))
	$('#productstore').fadeOut();
	$('#previewstore').fadeIn();
	currentWeapon = weapon;
	$('.previewstore').html(`<div style="position: absolute; top: 41%; left: 47%;"><div class="lds-facebook"><div></div><div></div><div></div></div></div>`);
	
	
}


function weaponBuy() {
	weapons()
	$.post('https://zoyg_pubg/buyWeapon', JSON.stringify({ weaponName : currentWeapon }));
}

function itemBuy() {
	$.post('https://zoyg_pubg/buyItem', JSON.stringify({ itemName : currentItem }));
}




function startPUBGGame() {
	pausetimer();
	$('#pregamestats').html(`<span>Game is starting...</span>`);
	showstarttimer();
}

function showstarttimer() {
	$("#startcounter").show();
    var ttstart = 30;
    var interppol = setInterval(function () {
        $('#startcounter10').text(ttstart); 
        ttstart--;

        if(ttstart < 0) {
            clearInterval(interppol);
        }
    }, 1000);
		setTimeout(function(){ $("#startcounter").hide(); resettimer(); }, 32000)
}


function timeToString(time) {
  let diffInHrs = time / 3600000;
  let hh = Math.floor(diffInHrs);

  let diffInMin = (diffInHrs - hh) * 60;
  let mm = Math.floor(diffInMin);

  let diffInSec = (diffInMin - mm) * 60;
  let ss = Math.floor(diffInSec);

  let diffInMs = (diffInSec - ss) * 100;
  let ms = Math.floor(diffInMs);

  let formattedMM = mm.toString().padStart(2, "0");
  let formattedSS = ss.toString().padStart(2, "0");


  return `${formattedMM}:${formattedSS}`;
}

// Declare variables to use in our functions below

let startTime;
let elapsedTime = 0;
let timerInterval;

// Create function to modify innerHTML

function printtimer(txt) {
  document.getElementById("gametimer").innerHTML = txt;
}

// Create "start", "pause" and "reset" functions

function startTimer() {
  startTime = Date.now() - elapsedTime;
  timerInterval = setInterval(function printTime() {
    elapsedTime = Date.now() - startTime;
    printtimer(timeToString(elapsedTime));
  }, 10);

}

function pausetimer() {
  clearInterval(timerInterval);
}

function resettimer() {
  clearInterval(timerInterval);
  printtimer("00:00");
  elapsedTime = 0;
}

var _stopTimer = false;
var _stopTimer2 = false;

function startjumpTimer(duration, display) {
	var timer = duration, minutes, seconds;
	var _interVal = setInterval(function () {
		minutes = parseInt(timer / 60, 10);
		seconds = parseInt(timer % 60, 10);

		minutes = minutes < 10 ? "0" + minutes : minutes;
		seconds = seconds < 10 ? "0" + seconds : seconds;

		display.text(minutes + ":" + seconds);

		if (--timer < 0) {
			timer = duration;
		}
		if(_stopTimer) {
			clearInterval(_interVal);
		}
	}, 1000);
}


function startEndingTimer(duration, display) {
	var timer = duration, minutes, seconds;
	var _interVal2 = setInterval(function () {
		minutes = parseInt(timer / 60, 10);
		seconds = parseInt(timer % 60, 10);

		minutes = minutes < 10 ? "0" + minutes : minutes;
		seconds = seconds < 10 ? "" + seconds : seconds;

		display.text(""+ seconds +"");

		if (--timer < 0) {
			timer = duration;
		}
		if(_stopTimer2) {
			clearInterval(_interVal2);
		}
	}, 1000);
}




