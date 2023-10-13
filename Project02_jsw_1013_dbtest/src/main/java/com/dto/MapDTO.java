package com.dto;

import org.apache.ibatis.type.Alias;

@Alias("MapDTO")
public class MapDTO {

    String title; // 제목
    String description; // 내용
    String url; // url
    String reference; // 관련문의
    String spatialCoverage; // 관련장소

    public MapDTO() {
    }

    public MapDTO(String title, String description, String url, String reference, String spatialCoverage) {
        this.title = title;
        this.description = description;
        this.url = url;
        this.reference = reference;
        this.spatialCoverage = spatialCoverage;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public String getReference() {
        return reference;
    }

    public void setReference(String reference) {
        this.reference = reference;
    }

    public String getSpatialCoverage() {
        return spatialCoverage;
    }

    public void setSpatialCoverage(String spatialCoverage) {
        this.spatialCoverage = spatialCoverage;
    }

    @Override
    public String toString() {
        return "MapDTO{" +
                "title='" + title + '\'' +
                ", description='" + description + '\'' +
                ", url='" + url + '\'' +
                ", reference='" + reference + '\'' +
                ", spatialCoverage='" + spatialCoverage + '\'' +
                '}';
    }
}
