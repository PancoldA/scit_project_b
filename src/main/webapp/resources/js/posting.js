var postingList = [];
var anskwdList = [];
	
function akinator() {

	while(postingList[postingList.length-1].length == 0){
	    postingList.pop();

	    if(postingList.length == 0) break;
	}

	if(postingList.length == 0) {
		let answer = '';
		answer += '<div id="posting" class="col-12">';
		answer += '    <section class="box">';
		answer += '	       <h3>추천할 채용공고가 없습니다</h3>';
		answer += '    </section>';
		answer += '</div>';

		$('section:last a').attr('onclick','');
		$('#main > :last').append(answer);
		return;
	}
	
	if(postingList[postingList.length-1].length == 1) {
		let ansPosting = postingList[postingList.length-1][0];
		let ansPosLoc = ansPosting['posting_location'].split(',')[0];
		let ansPosCr = ansPosting['posting_career_code'];
		let ansPosEd = ansPosting['posting_education_code'];
		let ansPosT = ansPosting['posting_type'].split(',');
		let ansPosCt = ansPosting['posting_job_category'].split(',');

		if(ansPosLoc.indexOf('전국') != -1) ansPosLoc = /전국/.exec(ansPosLoc)[0];
		else if(ansPosLoc.indexOf('전체') != -1) ansPosLoc = /[가-힣·]+전체$/.exec(ansPosLoc)[0];
		else if(ansPosLoc.indexOf('세종특별자치시') != -1) ansPosLoc = /세종특별자치시/.exec(ansPosLoc)[0];
		else if(ansPosLoc.indexOf('중국.홍콩 기타') != -1) ansPosLoc = /중국.홍콩 기타/.exec(ansPosLoc)[0];
		else if(/[가-힣·]+기타$/.test(ansPosLoc)) ansPosLoc = /[가-힣·]+기타$/.exec(ansPosLoc)[0];

		if(ansPosCr == 0) ansPosCr = '경력무관';
		else if(ansPosCr == 1) ansPosCr = '신입';
		else if(ansPosCr == 2) ansPosCr = '경력';
		else ansPosCr = '신입·경력';

		if(ansPosEd == 1) ansPosEd = '고등학교졸업';
		else if(ansPosEd == 2) ansPosEd = '대학교졸업(2,3년)';
		else if(ansPosEd == 3) ansPosEd = '대학교졸업(4년)';
		else if(ansPosEd == 4) ansPosEd = '석사졸업';
		else if(ansPosEd == 5) ansPosEd = '박사졸업';
		else if(ansPosEd == 6) ansPosEd = '고등학교졸업이상';
		else if(ansPosEd == 7) ansPosEd = '대학교졸업(2,3년)이상';
		else if(ansPosEd == 8) ansPosEd = '대학교졸업(4년)이상';
		else if(ansPosEd == 9) ansPosEd = '석사졸업이상';
		else ansPosEd = '학력무관';

		if(ansPosT.indexOf('null') != -1) ansPosT.splice(ansPosT.indexOf('null'),1);
		ansPosT = ansPosT[0];

		if(ansPosCt.length < 3) {
			ansPosCt = ansPosCt.join(',');
		} else {
			ansPosCt.splice(2);
			ansPosCt = ansPosCt.join(',') + ' 외';
		}
		
		let answer = '';
		answer += '<div id="posting" class="col-12">';
		answer += '    <section class="box">';
		answer += '	       <h3>추천할 채용공고는 다음과 같습니다</h3>';
		answer += '        <hr>';
		answer += '        <div class="row">';
		answer += '		       <div class="col-8">';
		answer += '                <h4><b>'+ansPosting['posting_title']+'</b> <a href="'+ansPosting['posting_url']+'" class="button more small" target="_blank">more</a></h4>';
		answer += '            </div>';
		answer += '            <div class="col-4">';
		answer += '                <h4><b>'+ansPosting['posting_company']+'</b></h4>';
		answer += '            </div>';
		answer += '        </div>';
		answer += '        <div class="row job-condition">';
		answer += '            <div class="col-12">';
		answer += '                <span>'+ansPosLoc+'</span>';
		answer += '                <span>|</span>';
		answer += '                <span>'+ansPosCr+'</span>';
		answer += '                <span>|</span>';
		answer += '                <span>'+ansPosEd+'</span>';
		answer += '                <span>|</span>';
		answer += '                <span>'+ansPosT+'</span>';
		answer += '            </div>';
		answer += '        </div>';
		answer += '        <div class="row job-category">';
		answer += '            <div class="col-12">';
		answer += '                <span>'+ansPosCt+'</span>';
		answer += '            </div>';
		answer += '        </div>';
		answer += '        <hr>';
		answer += '        <div class="row">';
		answer += '            <div class="col-8">';
		answer += '                <h4 style="line-height: 2em">채용공고에 만족하십니까?</h4>';
		answer += '            </div>';
		answer += '            <div class="col-2" style="text-align: left">';
		answer += '                <a href="javascript:void(0);" class="button alt small" onclick="recommend(this)">Yes</a>';
		answer += '            </div>';
		answer += '            <div class="col-2" style="text-align: end">';
		answer += '                <a href="javascript:void(0);" class="button alt small" onclick="withdraw()">No</a>';
		answer += '            </div>';
		answer += '        </div>';
		answer += '    </section>';
		answer += '</div>';

		$('section:last a').attr('onclick','');
		$('#main > :last').append(answer);
		return;
	} 
	
	var temp = [];

	postingList[postingList.length-1].forEach(function(item){
		temp.push(item['posting_keyword']);
	});

	if(Array.from(new Set(temp)).length == 1 || anskwdList.length % 10 == 0) {
		let ansPosting = postingList[postingList.length-1][Math.floor(Math.random() * postingList[postingList.length-1].length)];
		let ansPosLoc = ansPosting['posting_location'].split(',')[0];
		let ansPosCr = ansPosting['posting_career_code'];
		let ansPosEd = ansPosting['posting_education_code'];
		let ansPosT = ansPosting['posting_type'].split(',');
		let ansPosCt = ansPosting['posting_job_category'].split(',');

		if(ansPosLoc.indexOf('전국') != -1) ansPosLoc = /전국/.exec(ansPosLoc)[0];
		else if(ansPosLoc.indexOf('전체') != -1) ansPosLoc = /[가-힣·]+전체$/.exec(ansPosLoc)[0];
		else if(ansPosLoc.indexOf('세종특별자치시') != -1) ansPosLoc = /세종특별자치시/.exec(ansPosLoc)[0];
		else if(ansPosLoc.indexOf('중국.홍콩 기타') != -1) ansPosLoc = /중국.홍콩 기타/.exec(ansPosLoc)[0];
		else if(/[가-힣·]+기타$/.test(ansPosLoc)) ansPosLoc = /[가-힣·]+기타$/.exec(ansPosLoc)[0];

		if(ansPosCr == 0) ansPosCr = '경력무관';
		else if(ansPosCr == 1) ansPosCr = '신입';
		else if(ansPosCr == 2) ansPosCr = '경력';
		else ansPosCr = '신입·경력';

		if(ansPosEd == 1) ansPosEd = '고등학교졸업';
		else if(ansPosEd == 2) ansPosEd = '대학교졸업(2,3년)';
		else if(ansPosEd == 3) ansPosEd = '대학교졸업(4년)';
		else if(ansPosEd == 4) ansPosEd = '석사졸업';
		else if(ansPosEd == 5) ansPosEd = '박사졸업';
		else if(ansPosEd == 6) ansPosEd = '고등학교졸업이상';
		else if(ansPosEd == 7) ansPosEd = '대학교졸업(2,3년)이상';
		else if(ansPosEd == 8) ansPosEd = '대학교졸업(4년)이상';
		else if(ansPosEd == 9) ansPosEd = '석사졸업이상';
		else ansPosEd = '학력무관';

		if(ansPosT.indexOf('null') != -1) ansPosT.splice(ansPosT.indexOf('null'),1);
		ansPosT = ansPosT[0];

		if(ansPosCt.length < 3) {
			ansPosCt = ansPosCt.join(',');
		} else {
			ansPosCt.splice(2);
			ansPosCt = ansPosCt.join(',') + ' 외';
		}
		
		let answer = '';
		answer += '<div id="posting" class="col-12">';
		answer += '    <section class="box">';
		answer += '	       <h3>추천할 채용공고는 다음과 같습니다</h3>';
		answer += '        <hr>';
		answer += '        <div class="row">';
		answer += '		       <div class="col-8">';
		answer += '                <h4><b>'+ansPosting['posting_title']+'</b> <a href="'+ansPosting['posting_url']+'" class="button more small" target="_blank">more</a></h4>';
		answer += '            </div>';
		answer += '            <div class="col-4">';
		answer += '                <h4><b>'+ansPosting['posting_company']+'</b></h4>';
		answer += '            </div>';
		answer += '        </div>';
		answer += '        <div class="row job-condition">';
		answer += '            <div class="col-12">';
		answer += '                <span>'+ansPosLoc+'</span>';
		answer += '                <span>|</span>';
		answer += '                <span>'+ansPosCr+'</span>';
		answer += '                <span>|</span>';
		answer += '                <span>'+ansPosEd+'</span>';
		answer += '                <span>|</span>';
		answer += '                <span>'+ansPosT+'</span>';
		answer += '            </div>';
		answer += '        </div>';
		answer += '        <div class="row job-category">';
		answer += '            <div class="col-12">';
		answer += '                <span>'+ansPosCt+'</span>';
		answer += '            </div>';
		answer += '        </div>';
		answer += '        <hr>';
		answer += '        <div class="row">';
		answer += '            <div class="col-8">';
		answer += '                <h4 style="line-height: 2em">채용공고에 만족하십니까?</h4>';
		answer += '            </div>';
		answer += '            <div class="col-2" style="text-align: left">';
		answer += '                <a href="javascript:void(0);" class="button alt small" onclick="recommend(this)">Yes</a>';
		answer += '            </div>';
		answer += '            <div class="col-2" style="text-align: end">';
		answer += '                <a href="javascript:void(0);" class="button alt small" onclick="withdraw()">No</a>';
		answer += '            </div>';
		answer += '        </div>';
		answer += '    </section>';
		answer += '</div>';

		$('section:last a').attr('onclick','');
		$('#main > :last').append(answer);

		if(anskwdList.length % 10 == 0) anskwdList.push('/');
		
		return;
	}
		
	var kwdList = Array.from(new Set(temp.join().split(',')));

	anskwdList.forEach(function(item){					     
		if(kwdList.indexOf(item) != -1){
        	kwdList.splice(kwdList.indexOf(item),1);
    	}
	});

	if(kwdList.length == 0) {
		let ansPosting = postingList[postingList.length-1][Math.floor(Math.random() * postingList[postingList.length-1].length)];
		let ansPosLoc = ansPosting['posting_location'].split(',')[0];
		let ansPosCr = ansPosting['posting_career_code'];
		let ansPosEd = ansPosting['posting_education_code'];
		let ansPosT = ansPosting['posting_type'].split(',');
		let ansPosCt = ansPosting['posting_job_category'].split(',');

		if(ansPosLoc.indexOf('전국') != -1) ansPosLoc = /전국/.exec(ansPosLoc)[0];
		else if(ansPosLoc.indexOf('전체') != -1) ansPosLoc = /[가-힣·]+전체$/.exec(ansPosLoc)[0];
		else if(ansPosLoc.indexOf('세종특별자치시') != -1) ansPosLoc = /세종특별자치시/.exec(ansPosLoc)[0];
		else if(ansPosLoc.indexOf('중국.홍콩 기타') != -1) ansPosLoc = /중국.홍콩 기타/.exec(ansPosLoc)[0];
		else if(/[가-힣·]+기타$/.test(ansPosLoc)) ansPosLoc = /[가-힣·]+기타$/.exec(ansPosLoc)[0];

		if(ansPosCr == 0) ansPosCr = '경력무관';
		else if(ansPosCr == 1) ansPosCr = '신입';
		else if(ansPosCr == 2) ansPosCr = '경력';
		else ansPosCr = '신입·경력';

		if(ansPosEd == 1) ansPosEd = '고등학교졸업';
		else if(ansPosEd == 2) ansPosEd = '대학교졸업(2,3년)';
		else if(ansPosEd == 3) ansPosEd = '대학교졸업(4년)';
		else if(ansPosEd == 4) ansPosEd = '석사졸업';
		else if(ansPosEd == 5) ansPosEd = '박사졸업';
		else if(ansPosEd == 6) ansPosEd = '고등학교졸업이상';
		else if(ansPosEd == 7) ansPosEd = '대학교졸업(2,3년)이상';
		else if(ansPosEd == 8) ansPosEd = '대학교졸업(4년)이상';
		else if(ansPosEd == 9) ansPosEd = '석사졸업이상';
		else ansPosEd = '학력무관';

		if(ansPosT.indexOf('null') != -1) ansPosT.splice(ansPosT.indexOf('null'),1);
		ansPosT = ansPosT[0];

		if(ansPosCt.length < 3) {
			ansPosCt = ansPosCt.join(',');
		} else {
			ansPosCt.splice(2);
			ansPosCt = ansPosCt.join(',') + ' 외';
		}
		
		let answer = '';
		answer += '<div id="posting" class="col-12">';
		answer += '    <section class="box">';
		answer += '	       <h3>추천할 채용공고는 다음과 같습니다</h3>';
		answer += '        <hr>';
		answer += '        <div class="row">';
		answer += '		       <div class="col-8">';
		answer += '                <h4><b>'+ansPosting['posting_title']+'</b> <a href="'+ansPosting['posting_url']+'" class="button more small" target="_blank">more</a></h4>';
		answer += '            </div>';
		answer += '            <div class="col-4">';
		answer += '                <h4><b>'+ansPosting['posting_company']+'</b></h4>';
		answer += '            </div>';
		answer += '        </div>';
		answer += '        <div class="row job-condition">';
		answer += '            <div class="col-12">';
		answer += '                <span>'+ansPosLoc+'</span>';
		answer += '                <span>|</span>';
		answer += '                <span>'+ansPosCr+'</span>';
		answer += '                <span>|</span>';
		answer += '                <span>'+ansPosEd+'</span>';
		answer += '                <span>|</span>';
		answer += '                <span>'+ansPosT+'</span>';
		answer += '            </div>';
		answer += '        </div>';
		answer += '        <div class="row job-category">';
		answer += '            <div class="col-12">';
		answer += '                <span>'+ansPosCt+'</span>';
		answer += '            </div>';
		answer += '        </div>';
		answer += '        <hr>';
		answer += '        <div class="row">';
		answer += '            <div class="col-8">';
		answer += '                <h4 style="line-height: 2em">채용공고에 만족하십니까?</h4>';
		answer += '            </div>';
		answer += '            <div class="col-2" style="text-align: left">';
		answer += '                <a href="javascript:void(0);" class="button alt small" onclick="recommend(this)">Yes</a>';
		answer += '            </div>';
		answer += '            <div class="col-2" style="text-align: end">';
		answer += '                <a href="javascript:void(0);" class="button alt small" onclick="withdraw()">No</a>';
		answer += '            </div>';
		answer += '        </div>';
		answer += '    </section>';
		answer += '</div>';

		$('section:last a').attr('onclick','');
		$('#main > :last').append(answer);
		return;
	}
	
	var choiceKwd = kwdList[Math.floor(Math.random() * kwdList.length)];
	var question = '';
	question += '<hr>';
	question += '<div class="row">';
	question += '	<div class="col-8">';
	question += '		<h4 style="line-height: 2em">'+choiceKwd+'에 관련된 분야입니까?</h4>';
	question += '	</div>';
	question += '	<div class="col-2" style="text-align: left">';
	question += '		<a href="javascript:void(0);" class="button alt small" onclick="lightSwitch(this, true);">Yes</a>';
	question += '	</div>';
	question += '	<div class="col-2" style="text-align: end">';
	question += '		<a href="javascript:void(0);" class="button alt small" onclick="lightSwitch(this, false);">No</a>';
	question += '	</div>';
	question += '</div>';

	$('section:last a').attr('onclick','');
	$('section:last').append(question);
	anskwdList.push(choiceKwd);
	
	if(anskwdList.indexOf('/') != -1) {
		anskwdList.splice(anskwdList.indexOf('/'),1);
	}
}

function lightSwitch(button, answer) {
	button.classList.remove('alt');

	if(answer) explorer();
	else akinator();
		
}
	
function explorer() {
	var temp = [];
	postingList[postingList.length-1].forEach(function(item){
		if(item['posting_keyword'].indexOf(anskwdList[anskwdList.length-1]) != -1){
			temp.push(item);
		}
	});

	postingList.push(temp);
	akinator();
}

function withdraw() {
	var posTitle = $('#posting h4:first > b').text();
	$('#posting').remove();
	
	postingList.forEach(function(item){
	    item.forEach(function(item2){
		    if(item2['posting_title'] == posTitle){
			    item.splice(item.indexOf(item2),1);
			}
		});
	});

	setTimeout(function(){
		akinator();
	},1000);
}

function recommend(button) {
	button.classList.remove('alt');
	var posTitle = $('#posting h4:first > b').text();
	var tags = button.closest('div.row').getElementsByTagName('a');

	for(let tag of tags) {
		tag.onclick = null;
	}

	postingList.forEach(function(item){
	    item.forEach(function(item2){
		    if(item2['posting_title'] == posTitle){
			    item.splice(item.indexOf(item2),1);
			}
		});
	});

	var recommend = '';
	recommend += '<div id="recommend" class="col-12">';
	recommend += '    <section class="box">';
	recommend += '        <h3>아래와 같은 채용공고도 있습니다</h3>';
	
	for(let i = 0; i<3; i++){

		while(postingList[postingList.length-1].length == 0){
		    postingList.pop();

		    if(postingList.length == 0) break;
		}
		
		if(postingList.length == 0) break;
		
		let lastPosList = postingList[postingList.length-1];
	    let recPosting = lastPosList[Math.floor(Math.random() * lastPosList.length)];
	    let recPosLoc = recPosting['posting_location'].split(',')[0];
		let recPosCr = recPosting['posting_career_code'];
		let recPosEd = recPosting['posting_education_code'];
		let recPosT = recPosting['posting_type'].split(',');
		let recPosCt = recPosting['posting_job_category'].split(',');

		if(recPosLoc.indexOf('전국') != -1) recPosLoc = /전국/.exec(recPosLoc)[0];
		else if(recPosLoc.indexOf('전체') != -1) recPosLoc = /[가-힣·]+전체$/.exec(recPosLoc)[0];
		else if(recPosLoc.indexOf('세종특별자치시') != -1) recPosLoc = /세종특별자치시/.exec(recPosLoc)[0];
		else if(recPosLoc.indexOf('중국.홍콩 기타') != -1) recPosLoc = /중국.홍콩 기타/.exec(recPosLoc)[0];
		else if(/[가-힣·]+기타$/.test(recPosLoc)) recPosLoc = /[가-힣·]+기타$/.exec(recPosLoc)[0];

		if(recPosCr == 0) recPosCr = '경력무관';
		else if(recPosCr == 1) recPosCr = '신입';
		else if(recPosCr == 2) recPosCr = '경력';
		else recPosCr = '신입·경력';

		if(recPosEd == 1) recPosEd = '고등학교졸업';
		else if(recPosEd == 2) recPosEd = '대학교졸업(2,3년)';
		else if(recPosEd == 3) recPosEd = '대학교졸업(4년)';
		else if(recPosEd == 4) recPosEd = '석사졸업';
		else if(recPosEd == 5) recPosEd = '박사졸업';
		else if(recPosEd == 6) recPosEd = '고등학교졸업이상';
		else if(recPosEd == 7) recPosEd = '대학교졸업(2,3년)이상';
		else if(recPosEd == 8) recPosEd = '대학교졸업(4년)이상';
		else if(recPosEd == 9) recPosEd = '석사졸업이상';
		else recPosEd = '학력무관';

		if(recPosT.indexOf('null') != -1) recPosT.splice(recPosT.indexOf('null'),1);
		recPosT = recPosT[0];

		if(recPosCt.length < 3) {
			recPosCt = recPosCt.join(',');
		} else {
			recPosCt.splice(2);
			recPosCt = recPosCt.join(',') + ' 외';
		}

		recommend += '        <hr>';
		recommend += '        <div class="row">';
		recommend += '		       <div class="col-8">';
		recommend += '                <h4><b>'+recPosting['posting_title']+'</b> <a href="'+recPosting['posting_url']+'" class="button more small" target="_blank">more</a></h4>';
		recommend += '            </div>';
		recommend += '            <div class="col-4">';
		recommend += '                <h4><b>'+recPosting['posting_company']+'</b></h4>';
		recommend += '            </div>';
		recommend += '        </div>';
		recommend += '        <div class="row job-condition">';
		recommend += '            <div class="col-12">';
		recommend += '                <span>'+recPosLoc+'</span>';
		recommend += '                <span>|</span>';
		recommend += '                <span>'+recPosCr+'</span>';
		recommend += '                <span>|</span>';
		recommend += '                <span>'+recPosEd+'</span>';
		recommend += '                <span>|</span>';
		recommend += '                <span>'+recPosT+'</span>';
		recommend += '            </div>';
		recommend += '        </div>';
		recommend += '        <div class="row job-category">';
		recommend += '            <div class="col-12">';
		recommend += '                <span>'+recPosCt+'</span>';
		recommend += '            </div>';
		recommend += '        </div>';
		
		postingList.forEach(function(item){
		    item.splice(item.indexOf(recPosting),1);
		});
	}

	recommend += '    </section>';
	recommend += '</div>';

	$('#main > :last').append(recommend);
}
			
$(document).ready(function(){
	$('#start').on('click',function(){
		
		var experience = $('input[name="experience"]:checked');
		var education = $('input[name="education"]:checked');
		var locations = $('input[name="location"]:checked + label');

		if(experience.length == 0) {
			alert('경력여부를 선택해주세요');
			return;
		}

		if(education.length == 0) {
			alert('학력을 선택해주세요');
			return;
		}

		if(locations.length == 0) {
			alert('지역을 선택해주세요');
			return;
		}

		var locationsValues = [];

		locations.each(function(){
			locationsValues.push($(this).text());
		});

		var allData = {"experience":experience.val(), "education":education.val(), "locations":locationsValues};

		$.ajax({
			url : "posting/get",
			type : "GET",
			data : allData,
			success : function(data) {

				postingList.length = 0;
				anskwdList.length = 0;
				
				if(data == null || data.length == 0){
					
					$('#main > :last').html('<div id="posting" class="col-12"></div>');
					$('#posting').html('<section class="box"></section>');
					$('#posting > :first').html('<h3>추천할 채용공고가 없습니다</h3>');
				} else {
					postingList.push(data);
					anskwdList.push('/');
					$('#main > :last').html('<div id="akinator" class="col-12"></div>');
					$('#akinator').html('<section class="box"></section>');
					$('#akinator > :first').html('<h3>추천받고 싶은 채용공고와 관련된 분야를 선택해주세요</h3>');

					akinator();
				}
			},
			error : function() {
				alert("시스템 에러가 발생했습니다. 관리자에게 문의해주세요");
			}
		});
	});
});