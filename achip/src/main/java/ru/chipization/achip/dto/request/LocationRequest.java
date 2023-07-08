package ru.chipization.achip.dto.request;

import lombok.*;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@EqualsAndHashCode
@ToString
public class LocationRequest {
    private Double latitude;
    private Double longitude;
}
