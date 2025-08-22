package com.himedia.groupware.dto;

import lombok.Data;

@Data
public class InfoDto {
    private int id;
    private String name;
    private int providerId;
    private String providerName;
    private int partId;
    private String partName;
    private int stateId;
    private String stateName;
}
