package com.acorn.doma.service;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.PostConstruct;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.locationtech.proj4j.ProjCoordinate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import com.acorn.doma.cmn.PLog;
import com.acorn.doma.domain.Accident;
import com.acorn.doma.mapper.AccMapper;
import com.acorn.doma.proj4j.CoordinateConverter;

@Component
@EnableScheduling
public class SchedulerConfig implements PLog{
	private final String serverId;
    private final String serviceKey;
    private final AccMapper accMapper;


    @Autowired
    public SchedulerConfig(AccMapper accMapper, @Value("${server.id}") String serverId,@Qualifier("accInfoServiceKey") String serviceKey) {
        this.accMapper = accMapper;
        this.serverId = serverId;
        this.serviceKey = serviceKey;
    }
	@PostConstruct
    public void init() {
        System.out.println("Server ID: " + serverId);
    }

	@Scheduled(fixedDelay = 60000)
    public void insertAccidentData() {
        if ("server1".equals(serverId)) {
            int retryCount = 0;
            int maxRetries = 3; // 최대 재시도 횟수
            int retryDelay = 10000; // 재시도 지연 시간 (밀리초)

            while (retryCount < maxRetries) {
                try {
                    // 데이터 가져오기
                    String xmlData = fetchDataFromApi();
                    if (xmlData == null || xmlData.isEmpty()) {
                        throw new IOException("No data received from API.");
                    }

                    // 오류 처리
                    String code = getCode(xmlData);
                    if (code != null) {
                        if ("INFO-000".equals(code)) {
                            // 데이터 파싱
                            List<Accident> accInfoList = parseXmlData(xmlData);

                            // 기존 데이터 삭제
                            accMapper.doDeleteAll();

                            // 새 데이터 삽입
                            for (Accident accident : accInfoList) {
                                accMapper.dataInsert(accident);
                            }

                            // 성공하면 루프 종료
                            break;
                        } else {
                            handleApiError(code);
                            return;
                        }
                    }

                } catch (IOException e) {
                    // 데이터 가져오기 관련 예외 처리
                    e.printStackTrace();
                } catch (Exception e) {
                    // 기타 예외 처리
                    e.printStackTrace();
                }

                // 재시도 처리
                retryCount++;
                if (retryCount < maxRetries) {
                    try {
                        System.out.println("재시도 중.. " + retryDelay / 1000 + " 초...");
                        Thread.sleep(retryDelay); // 재시도 전 지연 시간
                    } catch (InterruptedException ie) {
                        ie.printStackTrace();
                        Thread.currentThread().interrupt(); // 인터럽트 처리
                        break;
                    }
                } else {
                    System.out.println("최대 재시도 횟수에 도달했습니다. API 연동 불가.");
                }
            }
        } else {
            System.out.println("해당 서버에서는 실시간 돌발 정보를 가져오지 못합니다.");
        }
    }

	public String fetchDataFromApi() throws IOException {
		String xmlData = "";
		StringBuilder urlBuilder = new StringBuilder("http://openapi.seoul.go.kr:8088"); /* URL */
		urlBuilder.append("/" + URLEncoder.encode(serviceKey, "UTF-8")); /* 인증키 (sample사용시에는 호출시 제한됩니다.) */
		urlBuilder.append("/" + URLEncoder.encode("xml", "UTF-8")); /* 요청파일타입 (xml,xmlf,xls,json) */
		urlBuilder.append("/" + URLEncoder.encode("AccInfo", "UTF-8")); /* 서비스명 (대소문자 구분 필수입니다.) */
		urlBuilder.append("/" + URLEncoder.encode("1", "UTF-8")); /* 요청시작위치 (sample인증키 사용시 5이내 숫자) */
		urlBuilder.append("/" + URLEncoder.encode("500", "UTF-8")); /* 요청종료위치(sample인증키 사용시 5이상 숫자 선택 안 됨) */
		URL url = new URL(urlBuilder.toString());
		HttpURLConnection conn = (HttpURLConnection) url.openConnection();
		conn.setRequestMethod("GET");
		conn.setRequestProperty("Content-type", "application/xml");
		System.out.println("Response code: " + conn.getResponseCode()); /* 연결 자체에 대한 확인이 필요하므로 추가합니다. */
		BufferedReader rd;

		// 서비스코드가 정상이면 200~300사이의 숫자가 나옵니다.
		if (conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
			rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
		} else {
			rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
		}
		StringBuilder sb = new StringBuilder();
		String line;
		while ((line = rd.readLine()) != null) {
			sb.append(line);
		}
		rd.close();
		conn.disconnect();
		xmlData = sb.toString();
	    
	    // Error code extraction
	    String code = getCode(xmlData);
	    if (code != null) {
	        log.error("API Code: " + code);
	    }
		return xmlData;
	}

	public List<Accident> parseXmlData(String xmlData) {
		List<Accident> accInfoList = new ArrayList<>();

		try {
			DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
			DocumentBuilder builder = factory.newDocumentBuilder();
			Document document = builder.parse(new java.io.ByteArrayInputStream(xmlData.getBytes("UTF-8")));

			// Normalize the XML Structure; It's just too important !!
			document.getDocumentElement().normalize();

			NodeList nList = document.getElementsByTagName("row");

			for (int temp = 0; temp < nList.getLength(); temp++) {
				Node node = nList.item(temp);
				if (node.getNodeType() == Node.ELEMENT_NODE) {
					Element eElement = (Element) node;

					String accId = eElement.getElementsByTagName("acc_id").item(0).getTextContent();
					String accType = eElement.getElementsByTagName("acc_type").item(0).getTextContent();
					String accDtype = eElement.getElementsByTagName("acc_dtype").item(0).getTextContent();
					String info = eElement.getElementsByTagName("acc_info").item(0).getTextContent();
					String occrDate = eElement.getElementsByTagName("occr_date").item(0).getTextContent();
					String occrTime = eElement.getElementsByTagName("occr_time").item(0).getTextContent();
					String endDate = eElement.getElementsByTagName("exp_clr_date").item(0).getTextContent();
					String endTime = eElement.getElementsByTagName("exp_clr_time").item(0).getTextContent();
					double grs80Longitude = 0.0;
					double grs80Latitude = 0.0;

					try {
						grs80Longitude = Double
								.parseDouble(eElement.getElementsByTagName("grs80tm_x").item(0).getTextContent());
						grs80Latitude = Double
								.parseDouble(eElement.getElementsByTagName("grs80tm_y").item(0).getTextContent());

//                         GRS80 좌표를 EPSG:4326으로 변환
						ProjCoordinate convertedCoord = CoordinateConverter.convert81(grs80Longitude, grs80Latitude);
						double longitude = convertedCoord.x;
						double latitude = convertedCoord.y;
						accInfoList.add(new Accident(accId, accType, accDtype, info, occrDate, occrTime, endDate,
								endTime, longitude, latitude));
					} catch (NumberFormatException nfe) {
						nfe.printStackTrace();
						// Handle the case where conversion fails, for example:
						// - Log the error
						// - Skip this record
						// - Set longitude and latitude to default values
					}

				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return accInfoList;
	}
	private static String getCode(String xmlData) {
	    String code = null;

	    try {
	        DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
	        DocumentBuilder builder = factory.newDocumentBuilder();
	        Document document = builder.parse(new java.io.ByteArrayInputStream(xmlData.getBytes("UTF-8")));

	        document.getDocumentElement().normalize();

	        NodeList nList = document.getElementsByTagName("CODE");
	        if (nList.getLength() > 0) {
	            Node node = nList.item(0);
	            if (node.getNodeType() == Node.ELEMENT_NODE) {
	                Element eElement = (Element) node;
	                code = eElement.getTextContent();
	            }
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return code;
	}
	private void handleApiError(String errorCode) {
        switch (errorCode) {
            case "ERROR-300":
                log.error("필수 값이 누락되어 있습니다.");
                break;
            case "INFO-100":
                log.error("인증키가 유효하지 않습니다.");
                break;
            case "ERROR-301":
                log.error("파일타입 값이 누락 혹은 유효하지 않습니다.");
                break;
            case "ERROR-310":
                log.error("해당하는 서비스를 찾을 수 없습니다.");
                break;
            case "ERROR-331":
                log.error("요청시작위치 값을 확인하십시오.");
                break;
            case "ERROR-332":
                log.error("요청종료위치 값을 확인하십시오.");
                break;
            case "ERROR-333":
                log.error("요청위치 값의 타입이 유효하지 않습니다.");
                break;
            case "ERROR-334":
                log.error("요청종료위치 보다 요청시작위치가 더 큽니다.");
                break;
            case "ERROR-335":
                log.error("샘플데이터는 한번에 최대 5건을 넘을 수 없습니다.");
                break;
            case "ERROR-336":
                log.error("데이터요청은 한번에 최대 1000건을 넘을 수 없습니다.");
                break;
            case "ERROR-500":
                log.error("서버 오류입니다.");
                break;
            case "ERROR-600":
                log.error("데이터베이스 연결 오류입니다.");
                break;
            case "ERROR-601":
                log.error("SQL 문장 오류 입니다.");
                break;
            case "INFO-200":
                log.info("해당하는 데이터가 없습니다.");
                break;
            default:
                log.error("알 수 없는 오류 코드: " + errorCode);
                break;
        }
    }
}
