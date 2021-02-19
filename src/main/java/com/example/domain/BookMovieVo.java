package com.example.domain;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@Getter
@Setter
@ToString
public class BookMovieVo {
    private String id;
    private String area;
    private String theater;
    private String date;
    private String name;
    private Integer price;
}
