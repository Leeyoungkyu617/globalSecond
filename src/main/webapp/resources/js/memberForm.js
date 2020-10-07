$(document).ready(function() {
		$('#find_address').click(function(event) {
			 new daum.Postcode({
			        oncomplete: function(data) {
			        	{
		                    // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
		                    // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
		                    var roadAddr = data.roadAddress; // 도로명 주소 변수
		                    var extraRoadAddr = ''; // 참고 항목 변수

		                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
		                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
		                    if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
		                        extraRoadAddr += data.bname;
		                    }
		                    // 건물명이 있고, 공동주택일 경우 추가한다.
		                    if (data.buildingName !== '' && data.apartment === 'Y') {
		                        extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
		                    }
		                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
		                    if (extraRoadAddr !== '') {
		                        extraRoadAddr = ' (' + extraRoadAddr + ')';
		                    }
		                    // 우편번호와 주소 정보를 해당 필드에 넣는다.
		                    console.log(data.jibunAddress);
		                    $('#address').val(data.jibunAddress);
		                }
			        }
			    }).open();
		})
		
		var context = window.location.pathname.substring(0, window.location.pathname.indexOf("/",2));

		$('#id').blur(function() {
			var id = $('#id').val();
			$.ajax({
				url:  context+'/overlapCheck?id='+id,
				type: "get",
				success : function(data){
					if(data){
						$("#id_label").html('<div  style="color: red;font-size: 11px; margin-bottom: 5px;">이미 사용중이거나 탈퇴한 아이디 입니다.</div>');
					}else{
						$("#id_label").empty();
					}
				}
			});
		});
		$('#nickName').blur(function() {
			var nickName = $('#nickName').val();
			$.ajax({
				url:  context + '/overlapCheck?nickName='+nickName,
				type: "get",
				success : function(data){
					if(data){
						$("#nickName_label").html('<div  style="color: red;font-size: 11px; margin-bottom: 5px;">이미 사용중이거나 탈퇴한 닉네임 입니다.</div>');
					}else{
						$("#nickName_label").empty();
					}
				}
			});
		});
	});