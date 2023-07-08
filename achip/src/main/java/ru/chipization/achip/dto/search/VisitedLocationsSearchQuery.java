package ru.chipization.achip.dto.search;

import lombok.*;

import java.time.Instant;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@EqualsAndHashCode
@ToString
public class VisitedLocationsSearchQuery {
    private Instant startDateTime;
    private Instant endDateTime;
    private Integer from;
    private Integer size;
}
