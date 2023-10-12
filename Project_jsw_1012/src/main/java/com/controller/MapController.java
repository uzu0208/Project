package com.controller;

import com.dto.MapDTO;
import com.service.MapService;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

@Controller
public class MapController {

    @Autowired
    MapService service;

    @GetMapping("/main")
    public String main(Model m) {

        // Dept 테이블의 모든 정보 가져오기
        m.addAttribute("list", service.findAll());
        return "main";
    }

    // 하루에 3시간마다 실행하는 메서드
    @Scheduled(cron = "0 0 0/3 1/1 * ? *")
    public void loadApi(){

        // open api에서 가져온 데이터를 저장하기 위한 변수
        StringBuilder result = new StringBuilder();

        try {
            // URL에 serviceKey를 넣고 get 방식으로 JSON을 가져오기
            StringBuilder urlBuilder = new StringBuilder("http://api.data.go.kr/openapi/tn_pubr_public_cltur_fstvl_api");
            urlBuilder.append("?").append(URLEncoder.encode("serviceKey", "UTF-8"))
                      .append("=%2BQzINS%2B1RTJ9DkDGYWJwYyRkAleMToscl%2FwZl0x2llfxbWb8bFGUj1xVBxYBR6%2B6f5EQXJplqgmmdpMGk8MvpA%3D%3D");
            URL url = new URL(urlBuilder.toString());
            HttpURLConnection urlConnection = (HttpURLConnection) url.openConnection();
            urlConnection.setRequestMethod("GET");
            urlConnection.setRequestProperty("content-type", "application/json");

            // open api에서 가져온 데이터를 한 줄씩 읽어서 저장
            BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(url.openStream(), StandardCharsets.UTF_8));
            result.append(bufferedReader.readLine());

            // records 배열 가져오기
            JSONParser jsonParser = new JSONParser();
            JSONObject jsonObject = (JSONObject) jsonParser.parse(result.toString());
            JSONArray jsonArray = (JSONArray) jsonObject.get("records");

            // 배열의 객체의 값을 가져와서 dto에 저장 후 db에 insert
            for(int i = 0; i < jsonArray.size(); i++){
                MapDTO dto = getDto(jsonArray, i);

                service.loadApi(dto);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * JSON의 배열로부터 각 객체의 값을 가져와서 MapDTO로 변환하는 메서드
     * @param jsonArray JSON의 배열
     * @param i 배열의 index
     * @return JSON 배열의 해당 index로부터 변환한 MapDTO
     */
    private static MapDTO getDto(JSONArray jsonArray, int i) {
        JSONObject object = (JSONObject) jsonArray.get(i);

        String fstvlNm = (String) object.get("축제명");
        String opar = (String) object.get("개최장소");
        String fstvlStartDate = (String) object.get("축제시작일자");
        String fstvlEndDate = (String) object.get("축제종료일자");
        String fstvlCo = (String) object.get("축제내용");
        String mnnst = (String) object.get("주관기관");
        String auspcInstt = (String) object.get("주최기관");
        String suprtInstt = (String) object.get("후원기관");
        String phoneNumber = (String) object.get("전화번호");
        String homepageUrl = (String) object.get("홈페이지주소");
        String relateInfo = (String) object.get("관련정보");
        String rdnmadr = (String) object.get("소재지도로명주소");
        String lnmadr = (String) object.get("소재지지번주소");
        String latitude = (String) object.get("위도");
        String longitude = (String) object.get("경도");
        String referenceDate = (String) object.get("데이터기준일자");
        String instt_code = (String) object.get("제공기관코드");
        String instt = (String) object.get("제공기관명");

        MapDTO dto = new MapDTO(fstvlNm, opar, fstvlStartDate, fstvlEndDate, fstvlCo, mnnst, auspcInstt,
                                suprtInstt, phoneNumber, homepageUrl, relateInfo, rdnmadr, lnmadr, latitude,
                                longitude, referenceDate, instt_code, instt);
        return dto;
    }
}
