package com.example.domain;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@Getter
@Setter
@ToString
public class CardVo {
	private Integer cNum;
	private String cKinds;
	private String cName;
	private String cSale; 
	private String cOnoff;
	private String cDiscount;
	
	private CardInfoVo cardInfoVo; 
}
