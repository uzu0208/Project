package com.initialize;

import com.dto.MapDTO;
import com.service.MapService;
import com.service.MapServiceImpl;
import org.json.JSONArray;
import org.json.JSONObject;
import org.json.XML;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationListener;
import org.springframework.context.event.ContextRefreshedEvent;
import org.springframework.context.event.EventListener;
import org.springframework.stereotype.Component;

import javax.annotation.PostConstruct;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;

@Component
public class InitializingDatabase{

    @Autowired
    MapService service;

    @EventListener(ContextRefreshedEvent.class)
    public void loadApi(){

        try {
            // URL에 serviceKey를 넣고 get 방식으로 JSON을 가져오기
            StringBuilder urlBuilder = new StringBuilder("http://api.kcisa.kr/openapi/API_CNV_060/request");
            urlBuilder.append("?").append(URLEncoder.encode("serviceKey", "UTF-8"))
                      .append("=b2776a52-dfcb-4d91-8497-7c4b5b5a00a1").append("&");

            URL urlApi = new URL(urlBuilder.toString());
            HttpURLConnection urlConnection = (HttpURLConnection) urlApi.openConnection();
            urlConnection.setRequestMethod("GET");
            urlConnection.setRequestProperty("Content-type", "application/json");

            // api에서 값을 가져오기
            BufferedReader bufferedReader;
            if(urlConnection.getResponseCode() >= 200 && urlConnection.getResponseCode() <= 300) {
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

            // xml 데이터를 json으로 변환
            JSONObject xmlToJson = XML.toJSONObject(String.valueOf(result));

            // json의 item안의 배열 가져오기
            JSONObject jsonObject = new JSONObject(String.valueOf(xmlToJson));
            JSONArray jsonArray = jsonObject.getJSONObject("response").getJSONObject("body")
                                            .getJSONObject("items").getJSONArray("item");

            // json의 배열을 dto 넣고 db에 insert
            for (int i = 0; i < jsonArray.length(); i++){

                String title = jsonArray.getJSONObject(i).getString("title");
                String description = jsonArray.getJSONObject(i).getString("description");
                String url = jsonArray.getJSONObject(i).getString("url");
                String reference = String.valueOf(jsonArray.getJSONObject(i).get("reference"));
                String spatialCoverage = jsonArray.getJSONObject(i).getString("spatialCoverage");

                MapDTO dto = new MapDTO(title, description, url, reference, spatialCoverage);

                service.loadApi(dto);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
