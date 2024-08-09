function detailSelect(input) {
    console.log("detailSelect()");
    console.log("input : " + input);
    
    // 'yearH2' 요소와 'detailInfo' 요소 가져오기
    const yearSelect = input;
    const detailInfo = document.querySelector('#detailInfo');
    const yearH2 = document.querySelector('#yearH2');
    const gnameDiv = document.querySelector('#gnameDiv');
    
    // 'detailInfo' 요소 표시
    if (detailInfo.style.display == 'none') {
        detailInfo.style.display = 'block';
    }

    
    // 'yearH2'에 연도 표시
    yearH2.textContent = yearSelect;

    // Ajax 요청
    $.ajax({
        type: "POST",
        url: "/doma/point/guListLoad.do",
        async: true, // 'async'로 수정
        dataType: "html",
        data: {
            "year": input
        },
        success: function(response) {
            console.log("success response:" + response);
            
            // JSON 데이터로 파싱
            const data = JSON.parse(response);
            console.log("Parsed data:" + data);

            // 기존의 select 박스 초기화
            gnameDiv.innerHTML = '<option value="">전체</option>';
            
            // 받아온 데이터로 select 박스 옵션 추가
            data.forEach(function(gu) {
                const option = document.createElement('option');
                option.value = gu;
                option.text = gu;
                gnameDiv.appendChild(option);
            });
        },
        error: function(response) {
            console.log("error:" + response);
        }
    });
     
}

document.getElementById('gnameDiv').addEventListener('change', function() {
    const selectedValue = this.value;
    const yearH2 = document.querySelector('#yearH2').innerText;
    const detailInfo = document.querySelector('#detail_info');
    console.log("Selected Value:", selectedValue);
    console.log("yearH2 :", yearH2);

    if (selectedValue) { 
        $.ajax({
            type: "POST",
            url: "/doma/point/pointDetail.do", 
            data:{
		        "year": yearH2,
		        "gname": selectedValue
		    },
            success: function(response) {
                console.log("통신 성공 :", response);
                const data = JSON.parse(response);

                // 기존의 <ul> 요소 비우기
                detailInfo.innerHTML = '';

                // 데이터 배열이 있다고 가정하고 각 항목을 li로 추가
                data.forEach(function(item) {
                    const listItem = document.createElement('ul');
                    listItem.innerHTML = `
                        <table class="info_table">
								<colgroup>
									<col>
									<col>
								</colgroup>
								<tbody>
                                    <tr>
										<input type="button" value="${item.accPoint}" style="background-color:white; width:331px;font-wight : bold; text-align : center; border: 3px solid black;">
									</tr>
									<tr>
										<th class="info_th" style="background-color: #FFDF00; border: 1px solid black; width : 100px;" >사고</th>
										<td style="border: 1px solid black; text-align : center; width : 230px;">${item.pointType}건</td>
									</tr>
                                    <tr>
										<th class="info_th" style="background-color: #FFDF00; border: 1px solid black; width : 100px;">사망</th>
										<td style="border: 1px solid black; text-align : center; width : 230px;">${item.accident}건</td>
									</tr>
									<tr>
										<th class="info_th" style="background-color: #FFDF00; border: 1px solid black; width : 100px;">사망</th>
										<td style="border: 1px solid black; text-align : center; width : 230px;">${item.dead}건</td>
									</tr>
									<tr>
										<th class="info_th" style="background-color: #FFDF00; border: 1px solid black; width : 100px;">중상</th>
										<td style="border: 1px solid black; text-align : center; width : 230px;">${item.seriously}건</td>
									</tr>
									<tr>
										<th class="info_th" style="background-color: #FFDF00; border: 1px solid black; width : 100px;">경상</th>
										<td style="border: 1px solid black; text-align : center; width : 230px;">${item.ordinary}건</td>
									</tr>
									<tr>
										<th class="info_th" style="background-color: #FFDF00; border: 1px solid black;">사건접수</th>
										<td style="border: 1px solid black; text-align : center; width : 230px;">${item.report}건</td>
									</tr>
								</tbody>
							</table>
                    `;
                    detailInfo.appendChild(listItem);
                });
            },
            error: function(response) {
                console.log("Error:", response);
                console.log("yearH2.value : " + yearH2);
                console.log("selectedValue.value : " + selectedValue);
            }
        });
    }
});
