package kr.or.ddit.sevenfs.vo.project;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.Data;

@Data
public class LinkVO {

    @JsonProperty("id")   // 백엔드 필드명과 프론트에서 요구하는 필드명이 다르기 때문에 사용
    private Long linkId; // TASK_LINK_NO

    @JsonProperty("source")
    private Long sourceId; // TASK_NO

    @JsonProperty("target")
    private Long targetId; // TRGT_TASK_NO

    @JsonProperty("type")
    private String linkType; // TASK_LINK_TY
}
