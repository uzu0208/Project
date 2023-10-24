package com.initialize;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.event.ContextRefreshedEvent;
import org.springframework.context.event.EventListener;
import org.springframework.stereotype.Component;

import com.dto.MapDTO;
import com.service.MapService;

@Component
public class InitializingDatabase{

    @Autowired
    MapService service;

    @EventListener(ContextRefreshedEvent.class)
    public void loadApi(){

        try {

            int numOfRows = 300; // 페이지 당 데이터 갯수
            int pageNo = 1; // 페이지 번호
            int totalCount = 0; // 전체 데이터 수

            do {
                // URL에 serviceKey를 넣고 get 방식으로 JSON을 가져오기
                // 서비스키, 페이지 당 갯수 (500), json형식으로
                StringBuilder urlBuilder = new StringBuilder("http://api.data.go.kr/openapi/tn_pubr_public_cltur_fstvl_api");
                urlBuilder.append("?").append(URLEncoder.encode("serviceKey", "UTF-8"))
                          .append("=vtEFyqeXjI4bAb%2F0neijgpkbOanStTuZX0VCeP0TXUpISJWAXu1hmDOgtf47aCBgMvXx97w5F9i8M7OtlL9uHw%3D%3D")
                          .append("&").append(URLEncoder.encode("numOfRows", "UTF-8"))
                          .append("=").append(URLEncoder.encode(String.valueOf(numOfRows), "UTF-8"))
                          .append("&").append(URLEncoder.encode("type", "UTF-8"))
                          .append("=").append(URLEncoder.encode("json", "UTF-8"));

                // 페이지 수
                urlBuilder.append("&").append(URLEncoder.encode("pageNo", "UTF-8")).append("=")
                          .append(URLEncoder.encode(String.valueOf(pageNo), "UTF-8"));

                // Api 연결
                
                URL urlApi = new URL(urlBuilder.toString());
                HttpURLConnection urlConnection = (HttpURLConnection) urlApi.openConnection();
                urlConnection.setRequestMethod("GET");
                urlConnection.setRequestProperty("Content-type", "application/json");

                // api에서 값을 가져오기
                BufferedReader bufferedReader;
                if (urlConnection.getResponseCode() >= 200 && urlConnection.getResponseCode() <= 300) {
                    bufferedReader = new BufferedReader(new InputStreamReader(urlConnection.getInputStream()));
                } else {
                    bufferedReader = new BufferedReader(new InputStreamReader(urlConnection.getErrorStream()));
                }
                
               
                // 가져온 값을 한 줄씩 넣기
                StringBuilder result = new StringBuilder();
                String line;
                while ((line = bufferedReader.readLine()) != null) {
                    result.append(line);
                }

                // json의 item안의 배열 가져오기
                JSONObject jsonObject = new JSONObject(String.valueOf(result));
                JSONArray jsonArray = jsonObject.getJSONObject("response").getJSONObject("body")
                                                .getJSONArray("items");

                // 전체 데이터 수 가져오기
                totalCount = jsonObject.getJSONObject("response").getJSONObject("body")
                                       .getInt("totalCount");

                // json의 배열을 dto 넣고 db에 insert
                long beforeTime = System.currentTimeMillis();
                for (int i = 0; i < jsonArray.length(); i++) {

                    String fstvlNm = jsonArray.getJSONObject(i).getString("fstvlNm"); // 축제명
                    String opar = jsonArray.getJSONObject(i).getString("opar"); // 개최장소
                    String fstvlStartDate = jsonArray.getJSONObject(i).getString("fstvlStartDate"); // 축제시작일자
                    String fstvlEndDate = jsonArray.getJSONObject(i).getString("fstvlEndDate"); // 축제종료일자
                    String fstvlCo = jsonArray.getJSONObject(i).getString("fstvlCo"); // 축제내용
                    String mnnst = jsonArray.getJSONObject(i).getString("mnnst"); // 주관기관
                    String auspcInstt = jsonArray.getJSONObject(i).getString("auspcInstt"); // 주최기관
                    String suprtInstt = jsonArray.getJSONObject(i).getString("suprtInstt"); // 후원기관
                    String phoneNumber = jsonArray.getJSONObject(i).getString("phoneNumber"); // 전화번호
                    String homepageUrl = jsonArray.getJSONObject(i).getString("homepageUrl"); // 홈페이지주소
                    String relateInfo = jsonArray.getJSONObject(i).getString("relateInfo"); // 관련정보
                    String rdnmadr = jsonArray.getJSONObject(i).getString("rdnmadr"); // 소재지도로명주소
                    String lnmadr = jsonArray.getJSONObject(i).getString("lnmadr"); // 소재지지번주소
                    String latitude = jsonArray.getJSONObject(i).getString("latitude"); // 위도
                    String longitude = jsonArray.getJSONObject(i).getString("longitude"); // 경도
                    String referenceDate = jsonArray.getJSONObject(i).getString("referenceDate"); // 데이터기준일자
                    String insttCode = jsonArray.getJSONObject(i).getString("insttCode"); // 제공기관코드

                    MapDTO dto = new MapDTO(fstvlNm, opar, fstvlStartDate, fstvlEndDate, fstvlCo, mnnst, auspcInstt,
                                            suprtInstt, phoneNumber, homepageUrl, relateInfo, rdnmadr, lnmadr,
                                            latitude, longitude, referenceDate, insttCode);

                    service.loadApi(dto);
                }
                
                pageNo++;
                long afterTime = System.currentTimeMillis();
                System.out.println(afterTime-beforeTime);
                
            } while ((pageNo - 1) * numOfRows < totalCount) ;
         
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}