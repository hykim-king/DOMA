<%--
/**
	Class Name:
	Description:
	Author : user
	Modification information
	
	수정일     수정자      수정내용
    -----   -----  -------------------------------------------
    2024. 7. 19        최초작성 
    
    author eclass 개발팀
    since 2024.07.18
*/
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="kr">
<head>
    <meta charset="UTF-8">
    <title>서울시 열린데이터 광장 OpenAPI 샘플(Javascript)</title>
</head>
<body>
<script>
    async function fetchData() {
        try {
            const response = await fetch('http://openapi.seoul.go.kr:8088/sample/xml/CardSubwayStatsNew/1/5/20220301');
            if (response.ok) {
                const data = await response.text(); // Assuming the response is XML as per the original code
                console.log(data);

                // Convert XML to JSON (Assuming XML is converted to JSON format as required by backend)
                const jsonData = xmlToJson(data);

                // Send data to backend server
                await sendDataToBackend(jsonData);
            } else {
                console.error('Error fetching data:', response.status, response.statusText);
            }
        } catch (error) {
            console.error('Fetch error:', error);
        }
    }

    function xmlToJson(xml) {
        // Convert XML to JSON as per requirement
        // This function needs to be implemented as per XML structure
    }

    async function sendDataToBackend(data) {
        try {
            const response = await fetch('http://localhost:8080/api/data', { // Your backend server URL
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(data)
            });
            if (response.ok) {
                console.log('Data successfully sent to backend');
            } else {
                console.error('Error sending data to backend:', response.status, response.statusText);
            }
        } catch (error) {
            console.error('Error sending data:', error);
        }
    }

    // Fetch data every 60 seconds
    setInterval(fetchData, 60000);
    
    // Initial fetch
    fetchData();
</script>
</body>
</html>
