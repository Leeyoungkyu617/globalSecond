
	function checkFormjquery() {
		var errcnt = 0;
		$(".required").each(function() {
			fObj = $(this).attr("name");
			fVal = $(this).val();
			fTyp = toUpperCase($(this).attr("type"));
			fMsg = $(this).attr("msg");
			fMal = $(this).attr("chkmail");
			fNum = $(this).attr("chknum");
			
			if (fMsg != null) {
				if (fVal == "" && (fTyp == "SELECT-ONE" || fTyp == "SELECT-MULTIPLE")) {
					alert(fMsg + " 선택해 주세요");
					$(this).focus();
					errcnt++;
					return false;
				}

				if(fVal == "" && (fTyp == "TEXT" || fTyp == "FILE" || fTyp == "NUMBER" || fTyp == "HIDDEN" || fTyp == "TEXTAREA" || fTyp == "PASSWORD")) {

					alert(fMsg + " 입력해 주세요");
					$(this).focus();
					errcnt++;
					return false;
				}
				if (fVal != null && (fTyp == "RADIO" || fTyp == "CHECKBOX") && checkChecked(fObj) == false) {
					alert(fMsg + " 선택해 주세요");
					$(this).focus();
					errcnt++;
					return false;
				}
				if(fMal != null && fVal != "" && checkEmail(fVal) == false) {
					alert("이메일 주소가 올바르지 않습니다");
					$(this).focus();
					errcnt++;
					return false;
				}
			}

			if(fNum != null && fVal != "" && checkNum(fVal) == false) {
				alert("숫자만 입력해주세요.");
				$(this).focus();
				errcnt++;
				return false;
			}			
		});

		if (errcnt > 0)
			return false;
		else
			return true;
	}

	// 이메일 유효성 체크
	function checkEmail(str){
	    var reg = /^((\w|[\-\.])+)@((\w|[\-\.])+)\.([A-Za-z]+)$/;
	    if (str.search(reg) != -1) {
			return true;
		}
		return false;
	}
	
	// 숫자 유효성 체크
	function  checkNum( str ) {
		if ( isNaN( str ) ) {
			return false;
		}
		return true;
	}

	// 배열 요소일 경우 checked 된것이 있는지 확인
	function checkChecked(obj) {
		var objnm = $("input[name="+ obj +"]");
		var ret = false;

		$("input[name="+ obj +"]").each(function(){
			if ($(this).attr("checked")) {
				ret = true;
			}
		});

		return ret;
	}

	// 대문자 변환 ex) toUpperCase(문자)
	function toUpperCase(str) {
		var ret;
		str != null ? ret = str.toUpperCase() : ret = "";
		return ret;
	}
	
	function onlyNumber(event){  // 숫자만 입력 가능
		event = event || window.event;
		var keyID = (event.which) ? event.which : event.keyCode;
		if ( (keyID >= 48 && keyID <= 57) || (keyID >= 96 && keyID <= 105) || keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39 || keyID == 35 || keyID == 36 || keyID == 16 || keyID == 9 ) 
			/* 48~57:일반 숫자키 코드, 96~105:숫자키패드 숫자키 코드,  8=Backspace, 46=Delete, 37=왼쪽 화살표, 39=오른쪽 화살표, 35=home, 36=end, 16=shift, 9 = Tab*/
			return;
		else
			return false;
	}
