<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<html>
<head>

</head>
<body>
	<div id="content">
		<div id="contentwrap">
			<h2>menu3</h2>

			<input type="file" id="file3" /> <label for="file3">파일선택</label> <br>
			<input type="button" class="ui-button" id="_excel_upload_btn">엑셀
			업로드
			</input>
		</div>
	</div>
</body>


<script src="/js/xlsx.full.min.js"></script>
<script>



    let excelData = {};


    $(document).ready(function () {

        let reader = new FileReader();

       const api = _api();
        
        
        $("#file3").on('change',function(){

            //파일선택이 바뀔때 마다 실행 이벤트
            uploadStart(this);
        })

        
        $("#_excel_upload_btn").on('click',function(){
			//TODO here
		console.log('testhere');
			
		console.log(excelData);
		
		 api.registerExcelFileUpload(JSON.stringify(excelData)); 
		
						
        });

        

        function uploadStart(data){
            //데이터 타입 체크 가능
            let files = data.files
            reader.readAsBinaryString(files[0]);


        }


        reader.onload = async function(){
            //리더에 로드 될 때 이벤트
             loadExcel(this);
        }

        function loadExcel(excelInputData){
            debugger;
            let _sheet = [];

            const data = excelInputData.result; // binary 데이터

            const workbook = XLSX.read(data,{
                type: 'binary'
            });

            if(workbook.SheetNames != null && workbook.SheetNames.length > 0){

                const SheetName = workbook.SheetNames[0]; // excel 의 시트 이름 index 넘버가 sheet의 순서

                const rows = XLSX.utils.sheet_to_json(workbook.Sheets[SheetName],{
                    header :[
                        'column1',
                        'column2',
                        'column3',
                    ]
                });

                if(rows[0].column1 !== '고객아이디' || rows[0].column2 !== '고객이름' || rows[0].column3 !=='고객 전화번호'){
                    alert('지정된 양식만 등록할 수 있습니다.');
                    return ;

                }

                _sheet = rows.filter((r,idx) => idx >= 1).map(r => {return { // row의 0번 인덱스는 header 부분 header 가 증가함에 따라 숫자를 늘리면 된다.
                    'NO' : ((r.column1??'')+'').trim(), // 공백 제거
                    'NAME' : ((r.column2??'')+'').trim(), // 공백 제거
                    'PHONE' : ((r.column3??'')+'').trim() // 공백 제거

                };
                });


                if(_sheet.length > 0){
                    // 예외처리 가능 부분

                    let chkMsg = '';
                    for(let i = 0 ; i < _sheet.length ; i++){
                        const e = _sheet[i]; // 1row 에 진입


                        if(e.NO === '' || e.NO == null){
                            chkMsg = '고객 아이디는 필수 항목 입니다.'
                            break;
                        }

                        if(e.PHONE === '' || e.PHONE == null){
                            chkMsg = '전화번호는 필수항목 입니다.'
                            break;
                        }


                    }

                    if( chkMsg !== ''){
                        alert(chkMsg);
                        return false;
                    }

                    // 데이터 베이스 컬럼명에 맞게 전역변수에 저장 후 추후 저장 api을 태워서 보내면 된다.
                    excelData = _sheet.map((r,idx,arr)=> { return{
                        'INDEX' : (arr.length - idx) + '',
                        'NUMBER' : r.NO,
                        'CUSTOMER_ID' : r.NAME,
                        'CUSTOMER_PHNM':r.PHONE

                    };
                    })


                }else{
                    alert('등록할 항목이 없습니다.');

                }



            }




        }
        
        
        function _api(){
        	return{
        		registerExcelFileUpload : function(data) {
        				return $.ajax({
        	                url: '/excel/excelUpload.do',
        	                type : "POST",
        	                contentType : "application/json",
        	                data : data,
        	                success : function (responseData){
        	                    clearInputBox();
        	                    alert('엑셀 파일 업로드가 완료되었습니다.');


        	                },
        	                error: function(){

        	                }
        	            });

        			}
        			
        		}
        		
        	}
        	
        


    })



</script>


</html>